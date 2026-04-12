import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web;
import '../../../core/constants/app_constants.dart';
import '../models/variedad_nombre_dto.dart';
import '../models/variedad_detalle_dto.dart';
import '../services/variety_api_service.dart';

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
  /// Lista de nombres para el selector. Se carga una vez en initState.
  List<VariedadNombreDto> _varietyNames = [];

  /// Detalle completo de la variedad seleccionada (incluye cafés asociados).
  VariedadDetalleDto? _selectedVariety;

  bool _loadingNames = true;
  bool _loadingDetail = false;
  String? _error;

  // ── Power BI (iframe web) ────────────────────────────────────────
  /// Identificador único para el PlatformView del iframe.
  /// Cada HtmlElementView necesita un viewType distinto; si usáramos
  /// el mismo que HomeScreen, Flutter reutilizaría la misma vista.
  final String _viewType = 'power-bi-varieties-iframe';
  bool _iframeRegistered = false;

  // ── Ciclo de vida ────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _registerIframe();
    _loadVarietyNames();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Registra el iframe de Power BI en el registry de Flutter Web.
  ///
  /// `platformViewRegistry.registerViewFactory` asocia un String (viewType)
  /// con una función que crea un HTMLElement. Flutter lo inserta como
  /// un elemento HTML real dentro del DOM, fuera del canvas de Flutter.
  /// Por eso puede mostrar contenido de terceros (como Power BI).
  void _registerIframe() {
    // Solo en web y solo una vez:
    if (!kIsWeb || _iframeRegistered) return;
    ui_web.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId) {
        final iframe = web.HTMLIFrameElement()
          // TODO: Cambia esta URL cuando tengas el dashboard de variedades.
          ..src = AppConstants.powerBiDesktopUrl
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..allow = 'fullscreen';
        return iframe;
      },
    );
    _iframeRegistered = true;
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
  ///
  /// Patrón idéntico al `_onCoffeeSelected` de CoffeeListScreen:
  /// 1. Ponemos estado "cargando" → spinner.
  /// 2. Hacemos la petición HTTP.
  /// 3. Actualizamos estado con los datos recibidos.
  /// 4. Hacemos scroll a la sección de detalle.
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
  ///
  /// - `addPostFrameCallback` espera a que el frame actual termine de
  ///   pintarse para buscar su posición (porque acabamos de hacer setState y el widget de detalle
  ///   aún no existe en el árbol).
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

  /// Helper: bandera emoji desde nombre de país en español.
  String _countryFlag(String pais) {
    const flags = {
      'etiopía': '🇪🇹', 'etiopia': '🇪🇹',
      'colombia': '🇨🇴',
      'brasil': '🇧🇷',
      'guatemala': '🇬🇹',
      'costa rica': '🇨🇷',
      'honduras': '🇭🇳',
      'perú': '🇵🇪', 'peru': '🇵🇪',
      'panamá': '🇵🇦', 'panama': '🇵🇦',
      'jamaica': '🇯🇲',
      'méxico': '🇲🇽', 'mexico': '🇲🇽',
      'nicaragua': '🇳🇮',
      'el salvador': '🇸🇻',
      'kenia': '🇰🇪', 'kenya': '🇰🇪',
      'yemen': '🇾🇪',
      'indonesia': '🇮🇩',
      'vietnam': '🇻🇳',
      'india': '🇮🇳',
      'bolivia': '🇧🇴',
      'ecuador': '🇪🇨',
      'república dominicana': '🇩🇴',
      'cuba': '🇨🇺',
      'ruanda': '🇷🇼', 'rwanda': '🇷🇼',
      'uganda': '🇺🇬',
      'tanzania': '🇹🇿',
      'papúa nueva guinea': '🇵🇬',
      'china': '🇨🇳',
      'tailandia': '🇹🇭',
      'myanmar': '🇲🇲',
    };
    return flags[pais.toLowerCase()] ?? '🌍';
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

                      // ── 2. Mapa Power BI ── (siempre visible)
                      _buildPowerBiMap(theme),

                      const SizedBox(height: 24),

                      // ── 3. Spinner mientras carga detalles ──
                      if (_loadingDetail)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(child: CircularProgressIndicator()),
                        ),

                      // ── 4. Detalle de la variedad ──
                      if (_selectedVariety != null) ...[
                        _buildVarietyDetail(theme),
                        const SizedBox(height: 24),

                        // ── 5. Cafés asociados ──
                        if (_selectedVariety!.cafes.isNotEmpty)
                          _buildCafesList(theme),
                      ],

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
  /// Muestra el mapa de Power BI en web, o un aviso en escritorio.
  ///
  /// Está envuelto en una Card con altura fija (400px) para que el
  /// SingleChildScrollView pueda calcular su tamaño. Sin altura fija
  /// el iframe intentaría expandirse infinitamente dentro del scroll.
  /// TOD0: ir retocando el Power BI para que se adapte bien a esta altura.
  Widget _buildPowerBiMap(ThemeData theme) {
    final bool isDesktop = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.linux ||
            defaultTargetPlatform == TargetPlatform.macOS);

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
                  'Mapa de Variedades',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: Text(
              'Distribución geográfica de las regiones de cultivo',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(
            height: 400,
            child: isDesktop
                ? Center(
                    child: Text(
                      'Abre la app en Chrome para ver el mapa.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : HtmlElementView(viewType: _viewType),
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
                        ? 'Sin cafés asociados en la base de datos'
                        : '${variety.cafes.length} café${variety.cafes.length > 1 ? 's' : ''} asociado${variety.cafes.length > 1 ? 's' : ''}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Widget: Lista de cafés asociados ─────────────────────────────
  /// Muestra cada café (si los hay) como una Card individual con productor, región y país.
  ///
  Widget _buildCafesList(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.coffee_rounded,
                size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              'Cafés que cultivan esta variedad',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,// si no intenta ocupar altyura infinita dentro del scroll
          physics: const NeverScrollableScrollPhysics(),//porque ya estamos dentro de un SingleChildScrollView
          itemCount: _selectedVariety!.cafes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final cafe = _selectedVariety!.cafes[index];
            return _buildCafeCard(theme, cafe);
          },
        ),
      ],
    );
  }

  /// Card individual de un café asociado a la variedad:
  Widget _buildCafeCard(ThemeData theme, VariedadCafeDto cafe) {
    return Card(
      elevation: 0,
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
                    _countryFlag(cafe.pais!),
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
