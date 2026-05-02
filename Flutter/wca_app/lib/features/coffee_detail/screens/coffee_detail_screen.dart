import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/country_flag.dart';
import '../../../core/utils/platform_utils.dart';
import 'iframe_helper_noweb.dart'
    if (dart.library.html) 'iframe_helper_web.dart';
import '../models/variedad_nombre_dto.dart';
import '../models/variedad_detalle_dto.dart';
import '../services/variety_api_service.dart';

/// Reconocedor de arrastre vertical que gana el arena de gestos de forma inmediata,
/// antes de que el SingleChildScrollView padre pueda reclamar el gesto.
/// Esto permite que el WebView reciba el scroll vertical sin competencia.
class _EagerVerticalDrag extends VerticalDragGestureRecognizer {
  @override
  void addAllowedPointer(PointerDownEvent event) {
    super.addAllowedPointer(event);
    // aquí se supera al scroll padre aceptando rápido el gesto:
    resolve(GestureDisposition.accepted);
  }

  @override
  void rejectGesture(int pointer) => acceptGesture(pointer);
}

/// Pantalla de Variedades de café.
///
/// Flujo:
/// 1. Al entrar, carga los nombres con GET /api/Variedades/nombres.
/// 2. Muestra un selector (DropdownMenu) + mapa Power BI siempre visible.
/// 3. Al seleccionar una variedad, carga los detalles (GET /api/Variedades/detalles/{id}).
/// 4. Hace scroll automático debajo del mapa Power BI a la sección de detalles.
///
class CoffeeDetailScreen extends StatefulWidget {
  const CoffeeDetailScreen({super.key});

  @override
  State<CoffeeDetailScreen> createState() => _CoffeeDetailScreenState();
}

class _CoffeeDetailScreenState extends State<CoffeeDetailScreen> {
  // ── Dependencias ─────────────────────────────────────────────────
  final VarietyApiService _apiService = VarietyApiService();
  final ScrollController _scrollController = ScrollController();

  /// GlobalKey en la sección de detalle → destino del scroll automático.
  final GlobalKey _detailSectionKey = GlobalKey();

  // ── Estado ───────────────────────────────────────────────────────
  /// Lista de nombres para el selector.
  List<VariedadNombreDto> _varietyNames = [];

  /// Detalle completo de la variedad seleccionada (incluye cafés asociados).
  VariedadDetalleDto? _selectedVariety;

  bool _loadingNames = true;
  bool _loadingDetail = false;
  String? _error;

  // ── Power BI (iframe web) ────────────────────────────────────────

  /// Contador estático--> cada instancia del widget obtiene un viewType único,
  /// lo que permite registrar un nuevo factory aunque la pantalla se haya
  /// visitado antes, si no, vuelve el error en el selector, porque la instancia anterior sigue registrada.
  static int _instanceCount = 0;
  late final String _viewType;

  /// Referencia al iframe para manipular su visibilidad CSS cuando el dropdown
  /// está abierto. En plataformas no-web, los métodos son no-op.
  late IframeRef _iframeRef;

  /// FocusNode del selector. Cuando el dropdown se abre ocultamos
  /// el iframe vía CSS; cuando se cierra, lo restauramos.
  late final FocusNode _dropdownFocusNode;

  // ── Power BI (WebView móvil) ─────────────────────────────────────
  WebViewController? _webViewController;

  // ── Ciclo de vida ────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _viewType = 'power-bi-varieties-iframe-${_instanceCount++}';
    _iframeRef = createAndRegisterIframe(_viewType, AppConstants.powerBiVariedadesUrl);
    _dropdownFocusNode = FocusNode()..addListener(_onDropdownFocusChange);
    if (!kIsWeb) {
      _webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(AppConstants.powerBiVariedadesUrl));
    }
    _loadVarietyNames();
  }

  @override
  void dispose() {
    _dropdownFocusNode
      ..removeListener(_onDropdownFocusChange)
      ..dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Cuando el dropdown se despliega o no, mostramos / ocultamos el iframe.
  /// Así el iframe no se recarga porque nunca sale del DOM.
  void _onDropdownFocusChange() {
    _iframeRef.setVisibility(!_dropdownFocusNode.hasFocus);
  }

  // ── Lógica de negocio ────────────────────────────────────────────

  Future<void> _loadVarietyNames() async {
    try {
      final names = await _apiService.fetchVarietyNames();
      if (!mounted) return;
      setState(() {
        _varietyNames = names;
        _loadingNames = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error =
            'No se pudieron cargar las variedades.\nRevisa que la API esté en marcha.';
        _loadingNames = false;
      });
    }
  }

  /// Llamado al seleccionar una variedad en el DropdownMenu.
   Future<void> _onVarietySelected(int id) async {
    setState(() {
      _loadingDetail = true;
      _selectedVariety = null;
      _error = null;
    });

    try {
      final detail = await _apiService.fetchVarietyDetails(id);
      if (!mounted) return;
      setState(() {
        _selectedVariety = detail;
        _loadingDetail = false;
      });
      _scrollToDetail();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Error al cargar los detalles de la variedad.';
        _loadingDetail = false;
      });
    }
  }

  /// Scroll suave hasta la sección de detalle:  
  void _scrollToDetail() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_detailSectionKey.currentContext != null) {
        Scrollable.ensureVisible(
          _detailSectionKey.currentContext!,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

// ── UI ───────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Variedades de Café'),
      ),
      body: _loadingNames
          ? const Center(child: CircularProgressIndicator())
          : (_error != null && _varietyNames.isEmpty)
              ? _buildError(theme)
              : SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── 1. Selector de variedad ──
                      _buildSelector(theme),

                      const SizedBox(height: 24),

                      // ── Mapa Power BI ── (altura fija para que el scroll funcione)
                      _buildPowerBiMap(theme),

                      const SizedBox(height: 24),

                      // ── Spinner  ──
                      if (_loadingDetail)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(child: CircularProgressIndicator()),
                        ),

                      // ── Detalle de la variedad (incluye cafés asociados si procede) ──
                      if (_selectedVariety != null)
                        _buildVarietyDetail(theme),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
    );
  }

  // ── Widget: Error ────────────────────────────────────────────────
  Widget _buildError(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded,
                size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                setState(() {
                  _loadingNames = true;
                  _error = null;
                });
                _loadVarietyNames();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  // ── Widget: Selector (DropdownMenu) ─────────────────────────────────────────────

  Widget _buildSelector(ThemeData theme) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.eco_outlined, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Selecciona una variedad',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownMenu<int>(
              expandedInsets: EdgeInsets.zero,
              hintText: 'Buscar variedad...',
              enableFilter: true,
              requestFocusOnTap: true,
              focusNode: _dropdownFocusNode,
              leadingIcon: Icon(
                Icons.search_rounded,
                color: theme.colorScheme.primary,
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerLowest,
              ),
              dropdownMenuEntries: _varietyNames.map((v) {
                return DropdownMenuEntry<int>(
                  value: v.variedadId,
                  label: v.variedadNombre,
                );
              }).toList(),
              onSelected: (int? id) {
                if (id != null) _onVarietySelected(id);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ── Widget: Mapa Power BI ────────────────────────────────────────
  /// Muestra el mapa de Power BI en web, o un aviso en escritorio (MVP).
  ///
  /// Está envuelto en una Card con altura fija para que el
  /// SingleChildScrollView pueda calcular su tamaño. Sin altura fija
  /// el iframe intentaría expandirse infinitamente dentro del scroll.
  Widget _buildPowerBiMap(ThemeData theme) {
    final bool isDesktop = isDesktopPlatform;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              children: [
                Icon(Icons.map_outlined,
                    size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Mapa de Variedades y sus Productores',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Web: altura responsiva (porcentaje de pantalla) para que el iframe se expanda bien.
          // Móvil: 400px fijos (el WebView está fuera de un ScrollView, no hay overflow).
          SizedBox(
            height: kIsWeb
                ? (MediaQuery.sizeOf(context).height * 0.59).clamp(320.0, 700.0) // 59% para web
                : 400,
            child: kIsWeb
                // El CSS lo oculta mientras el dropdown está abierto:
                ? Stack(
                    children: [
                      // Fondo que se ve cuando el iframe está oculto:
                      Container(
                        color: theme.colorScheme.surfaceContainerLowest,
                      ),
                      HtmlElementView(viewType: _viewType),
                    ],
                  )
                : isDesktop
                    ? Center(
                        child: Text(
                          'Abre la app en Chrome para ver el mapa.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    // Móvil (Android/iOS): cede todos los gestos al WebView.
                    // _EagerVerticalDrag evita que el ScrollView padre gane
                    // la arena de gestos en el eje vertical.
                    : WebViewWidget(
                        controller: _webViewController!,
                        gestureRecognizers: {
                          Factory<_EagerVerticalDrag>(
                            () => _EagerVerticalDrag(),
                          ),
                          Factory<HorizontalDragGestureRecognizer>(
                            () => HorizontalDragGestureRecognizer(),
                          ),
                          Factory<ScaleGestureRecognizer>(
                            () => ScaleGestureRecognizer(),
                          ),
                        },
                      ),
          ),
        ],
      ),
    );
  }

  // ── Widget: Detalle de variedad ──────────────────────────────────
  /// Card principal con nombre, especie y descripción de la variedad.
  ///
  Widget _buildVarietyDetail(ThemeData theme) {
    final variety = _selectedVariety!;

    return Card(
      key: _detailSectionKey,// para localizarla con el scroll automático
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Nombre de la variedad ──
            Text(
              variety.variedadNombre,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 12),

            // ── Especie ──
            if (variety.especie != null)
              Row(
                children: [
                  Icon(Icons.spa_outlined,
                      size: 16, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Text(
                    'Especie: ',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    variety.especie!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),

            // ── Descripción ──
            if (variety.variedadDescripcion != null &&
                variety.variedadDescripcion!.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),
              Text(
                variety.variedadDescripcion!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                ),
              ),
            ],

            // ── Info de cafés asociados ──
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withAlpha(60),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.coffee_outlined,
                      size: 16, color: theme.colorScheme.primary),
                  const SizedBox(width: 6),
                  Text(
                    variety.cafes.isEmpty
                        ? 'Sin cafés asociados en la base de datos (MVP)'
                        : '${variety.cafes.length} café${variety.cafes.length > 1 ? 's' : ''} asociado${variety.cafes.length > 1 ? 's' : ''}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // ── Lista de cafés dentro de la misma Card ──
            if (variety.cafes.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.coffee_rounded,
                      size: 20, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Cafés característicos de esta variedad y sus productores',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Generamos las tarjetas de café (si hay):
              ...variety.cafes.map((cafe) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildCafeCard(theme, cafe),
              )),
            ],
          ],
        ),
      ),
    );
  }

  /// Card individual de un café asociado a la variedad:
  Widget _buildCafeCard(ThemeData theme, VariedadCafeDto cafe) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceBright,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Nombre del café con bandera ──
            Row(
              children: [
                if (cafe.pais != null) ...[
                  Text(
                    countryFlag(cafe.pais!),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    cafe.cafeNombre,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ── Región ──
            if (cafe.region != null || cafe.pais != null)
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 16, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Región: ',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          TextSpan(
                            text: [
                              if (cafe.region != null) cafe.region,
                              if (cafe.pais != null) cafe.pais,
                            ].join(', '),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            // ── Productor ──
            if (cafe.productor != null) ...[
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.person_outline_rounded,
                      size: 16, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Productor: ',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                cafe.productor!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            if (cafe.tipoProductor != null) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  cafe.tipoProductor!,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color:
                                        theme.colorScheme.onSecondaryContainer,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (cafe.productorDescripcion != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            cafe.productorDescripcion!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
