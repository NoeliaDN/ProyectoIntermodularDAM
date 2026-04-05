import 'package:flutter/material.dart';
import '../models/cafe_nombre_dto.dart';
import '../models/cafe_lote_dto.dart';
import '../models/sca_dto.dart';
import '../services/coffee_api_service.dart';
import '../widgets/sca_radar_chart.dart';

/// Pantalla de cafés de especialidad.
///
/// Flujo:
/// 1. Carga la lista de nombres (GET /api/cafes/nombres).
/// 2. El usuario selecciona un café en el DropdownMenu.
/// 3. Se cargan a la vez la info (GET /api/cafes/{id}) y el perfil SCA (GET /api/cafes/{id}/sca).
/// 4. Se hace scroll automático a la sección de detalle.
class CoffeeListScreen extends StatefulWidget {
  const CoffeeListScreen({super.key});

  @override
  State<CoffeeListScreen> createState() => _CoffeeListScreenState();
}

class _CoffeeListScreenState extends State<CoffeeListScreen> {
  // ── Dependencias ─────────────────────────────────────────────────
  final CoffeeApiService _apiService = CoffeeApiService();
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _infoSectionKey = GlobalKey(); // con GlobalKey sabremos dónde está la info a la que queremos ir

  // ── Estado ───────────────────────────────────────────────────────
  List<CafeNombreDto> _coffeeNames = []; // Lista para el selector
  CafeLoteDto? _selectedCoffee;           // Info del café seleccionado
  ScaDto? _scaData;                       // Perfil SCA del café seleccionado
  bool _loadingNames = true;              // ¿Estamos cargando la lista?
  bool _loadingDetail = false;            // ¿Estamos cargando el detalle?
  String? _error;                         // Mensaje de error si algo falla

  // ── Ciclo de vida ────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _loadCoffeeNames(); // Cargar nombres al entrar en la pantalla
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ── Lógica de negocio ────────────────────────────────────────────

  /// Carga la lista de nombres de cafés para seleccionar:.
  Future<void> _loadCoffeeNames() async {
    try {
      final names = await _apiService.fetchCoffeeNames();
      if (!mounted) return; // Comprobamos que el widget sigue vivo
      setState(() {
        _coffeeNames = names;
        _loadingNames = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'No se pudieron cargar los cafés.\nRevisa que la API esté en marcha.';
        _loadingNames = false;
      });
    }
  }

  // Una vez seleccionado el café, llamamos a los endpoints para rellenar la info:
  Future<void> _onCoffeeSelected(int id) async {
    setState(() {
      _loadingDetail = true;
      _selectedCoffee = null;
      _scaData = null;
      _error = null;
    });

    try {
      final results = await Future.wait([// para ejecutarllas a la vez
        _apiService.fetchCoffeeInfo(id),
        _apiService.fetchCoffeeSca(id),
      ]);

      if (!mounted) return;
      setState(() {
        _selectedCoffee = results[0] as CafeLoteDto?;
        _scaData = results[1] as ScaDto?;
        _loadingDetail = false;
      });

      // Hacer scroll suave hasta la sección de info
      _scrollToInfo();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Error al cargar los datos del café.';
        _loadingDetail = false;
      });
    }
  }

  /// Desplaza la pantalla hasta la sección de info con `Scrollable.ensureVisible`.
  void _scrollToInfo() {
    WidgetsBinding.instance.addPostFrameCallback((_) {// esperamos un frame a que cargue antes de hacer scroll
      if (_infoSectionKey.currentContext != null) {
        Scrollable.ensureVisible(
          _infoSectionKey.currentContext!,
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
        title: const Text('Cafés de Especialidad'),
        centerTitle: true,
      ),
      body: _loadingNames
          // spinner mientras carga y gestión de errores con iconos majos y botón de reintento:
          ? const Center(child: CircularProgressIndicator())
          // Si hay error y no hay datos → mensaje de error
          : (_error != null && _coffeeNames.isEmpty)
              ? Center(
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
                            _loadCoffeeNames();
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  ),
                )
              //  Contenido principal 
              : SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── 1. Selector de café ──
                      _buildSelector(theme),

                      const SizedBox(height: 32),

                      // ── 2. Indicador de carga del detalle ──
                      if (_loadingDetail)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(child: CircularProgressIndicator()),
                        ),

                      // ── 3. Información del café ──
                      if (_selectedCoffee != null) ...[
                        _buildCoffeeInfo(theme),
                        const SizedBox(height: 24),
                      ],

                      // ── 4. Gráfico radial SCA ──
                      if (_scaData != null) _buildScaSection(theme),

                      // Espacio inferior para que el scroll no corte
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
    );
  }

  // ── Widget: Selector ─────────────────────────────────────────────
  /// Card con DropdownMenu para buscar cafés de la lista:
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
            // Cabecera del selector
            Row(
              children: [
                Icon(Icons.coffee_rounded, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Selecciona un café',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // DropdownMenu de Material 3:
            DropdownMenu<int>(
              expandedInsets: EdgeInsets.zero, // Ocupa todo el ancho
              hintText: 'Buscar café...',
              enableFilter: true,        // habilito búsqueda
              requestFocusOnTap: true,  // para abrir teclado
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
              // Cada entrada del menú → un café con su id y nombre
              dropdownMenuEntries: _coffeeNames.map((coffee) {
                return DropdownMenuEntry<int>(
                  value: coffee.id,
                  label: coffee.nombre,
                );
              }).toList(),
              onSelected: (int? id) {
                if (id != null) _onCoffeeSelected(id);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ── Widget: Info del café ────────────────────────────────────────
  /// Card con nombre, ubicación, descripción extendida y notas de cata.
  Widget _buildCoffeeInfo(ThemeData theme) {
    final coffee = _selectedCoffee!;

    return Card(
      key: _infoSectionKey, // Key para el scroll automático
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre del café (título) 
            Text(
              coffee.nombre,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),

            // Ubicación (región)
            if (coffee.regionId != null)
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 18, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text(
                    'Región #${coffee.regionId}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),

            //  Altitud 
            if (coffee.altitudMedia != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.terrain_outlined,
                      size: 18, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text(
                    '${coffee.altitudMedia!.toStringAsFixed(0)} m.s.n.m.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),

            // Descripción extendida 
            if (coffee.descripcionExtendida != null &&
                coffee.descripcionExtendida!.isNotEmpty) ...[
              Text(
                'Descripción',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                coffee.descripcionExtendida!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.6, // Interlineado
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Notas de cata
            if (coffee.notasCata != null &&
                coffee.notasCata!.isNotEmpty) ...[
              Text(
                'Notas de Cata',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              // Contenedor notas:
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withAlpha(60),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.local_cafe_outlined,
                        size: 20, color: theme.colorScheme.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        coffee.notasCata!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ── Widget: Sección SCA ──────────────────────────────────────────
  /// Card que envuelve el gráfico radial SCA (ScaRadarChart).
  Widget _buildScaSection(ThemeData theme) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),// dejo espacio bajo el gráfico
        child: Column(
          children: [
            Text(
              'Perfil Sensorial SCA',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ScaRadarChart(sca: _scaData!),
          ],
        ),
      ),
    );
  }
}
