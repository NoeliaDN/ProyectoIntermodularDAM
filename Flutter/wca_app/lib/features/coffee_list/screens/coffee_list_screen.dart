import 'package:flutter/material.dart';
import '../models/cafe_nombre_dto.dart';
import '../models/cafe_lote_dto.dart';
import '../models/sca_dto.dart';
import '../models/cafe_altitudes_dto.dart';
import '../services/coffee_api_service.dart';
import '../widgets/sca_radar_chart.dart';
import '../widgets/altitude_bar_chart.dart';

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
  List<CafeAltitudesDto> _altitudesData = []; // Altitudes de todos los cafés para el gráfico
  CafeLoteDto? _selectedCoffee;           // Info del café seleccionado
  ScaDto? _scaData;                       // Perfil SCA del café seleccionado
  bool _loadingNames = true;              // ¿Estamos cargando la lista?
  bool _loadingDetail = false;            // ¿Estamos cargando el detalle?
  String? _error;                         // Mensaje de error si algo falla

  // ── Ciclo de vida ────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
       
    //_loadCoffeeNames(); //cargar nombres al entrar en pantalla
    _loadInitialData(); // Cargamos nombres y altitudes a la vez
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ── Lógica de negocio ────────────────────────────────────────────

  /// Carga la lista de nombres y las altitudes de todos los cafés.
  Future<void> _loadInitialData() async {
    try {
      final results = await Future.wait([
        _apiService.fetchCoffeeNames(),
        _apiService.fetchCoffeeAltitudes(),
      ]);
      if (!mounted) return;
      setState(() {
        _coffeeNames = results[0] as List<CafeNombreDto>;
        _altitudesData = results[1] as List<CafeAltitudesDto>;
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

  // Mantenemos el nombre anterior por si queda alguna referencia interna:
  Future<void> _loadCoffeeNames() => _loadInitialData();

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

  // ── Helper: bandera del país ─────────────────────────────────────
  /// Convierte el nombre del país en español al emoji de su bandera.
  /// Los emojis de bandera son caracteres Unicode especiales (indicadores
  /// regionales). Si el país no está mapeado, devuelve un globo genérico.
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
                      if (_scaData != null) ...[  
                        _buildScaSection(theme),
                        const SizedBox(height: 24),
                      ],

                      // ── 5. Gráfico comparativo de altitudes ──
                      if (_altitudesData.isNotEmpty)
                        _buildAltitudesSection(theme),

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
            //Nombre del café (título) + bandera emoji
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (coffee.pais != null) ...
                  [
                    Text(
                      _countryFlag(coffee.pais!),
                      style: const TextStyle(fontSize: 28),
                    ),
                    const SizedBox(width: 10),
                  ],
                Expanded(
                  child: Text(
                    coffee.nombre,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Región
            if (coffee.region != null)
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 18, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text(
                    coffee.region!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),

            // // País (nombre completo, debajo de la región)
            // if (coffee.pais != null) ...[  
            //   const SizedBox(height: 4),
            //   Row(
            //     children: [
            //       Icon(Icons.public_outlined,
            //           size: 18, color: theme.colorScheme.onSurfaceVariant),
            //       const SizedBox(width: 4),
            //       Text(
            //         coffee.pais!,
            //         style: theme.textTheme.bodyMedium?.copyWith(
            //           color: theme.colorScheme.onSurfaceVariant,
            //         ),
            //       ),
            //     ],
            //   ),
            // ],

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

            // Nivel de tueste (barra visual)
            if (coffee.tueste != null) ...[  
              _buildRoastIndicator(theme, coffee.tueste!),
              const SizedBox(height: 16),
            ],

            // Método de proceso (badge de color)
            if (coffee.proceso != null) ...[  
              _buildProcessBadge(theme, coffee.proceso!, coffee.procesoDescripcion),
              const SizedBox(height: 20),
            ],

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

  // ── Widget: Badge de proceso ─────────────────────────────────────
  /// Muestra el método de proceso como un chip de color con icono y
  /// una descripción breve de qué significa ese proceso desde la BD.
 
  Widget _buildProcessBadge(ThemeData theme, String proceso, String? descripcion) {
    // Solo color e icono vienen de Flutter; la descripción viene de la BD
    final data = _processData(proceso.toLowerCase());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Método de Proceso',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: data.color.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: data.color.withAlpha(100)),
          ),
          child: Row(
            children: [
              // Icono del proceso con fondo circular de color
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: data.color.withAlpha(50),
                  shape: BoxShape.circle,
                ),
                child: Icon(data.icon, size: 22, color: data.color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre del proceso
                    Text(
                      proceso,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: data.color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Descripción de la BD; si el proceso es desconocido (default),
                    // se usa la descripción genérica hardcodeada como fallback.
                    Text(
                      descripcion ?? data.description ?? '',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Devuelve los datos visuales (color e icono) para cada proceso.
  /// La descripción viene de la BD para los procesos conocidos.
  /// Solo el caso default tiene descripción hardcodeada como fallback.
  _ProcessData _processData(String proceso) {
    switch (proceso.toLowerCase().trim()) {
      case 'lavado':
        return const _ProcessData(
          color: Color(0xFF1976D2),
          icon: Icons.water_drop_outlined,
        );
      case 'natural':
        return const _ProcessData(
          color: Color(0xFFE65100),
          icon: Icons.wb_sunny_outlined,
        );
      case 'honey':
        return const _ProcessData(
          color: Color(0xFFF59700),
          icon: Icons.opacity,
        );
      case 'anaeróbico':
        return const _ProcessData(
          color: Color(0xFF7B1FA2),
          icon: Icons.science_outlined,
        );
      default:
        return const _ProcessData(
          color: Color(0xFF546E7A),
          icon: Icons.settings_outlined,
          description: 'Método de procesado del grano.',
        );
    }
  }

  // ── Widget: Indicador de tueste (LinearGradient)────────────────────────────────
  
  Widget _buildRoastIndicator(ThemeData theme, String tueste) {
    //  nombre → posición en la barra (de 0 a 1):
    const levels = {
      'claro': 0.10,
      'medio claro': 0.35,
      'medio': 0.50,
      'medio oscuro': 0.75,
      'oscuro': 0.98,
    };
    final position = levels[tueste.toLowerCase()] ?? 0.55;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título + nombre del tueste en la misma línea:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nivel de Tueste',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              tueste,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Barra + marcador:
        LayoutBuilder( // para calcular sobre el ancho total de la pantalla
          builder: (context, constraints) {
            const markerSize = 20.0;
            const barHeight = 12.0;
            // Calculamos la izquierda del marcador para que su centro quede
            // en la posición correcta, sin salirse del borde:
            final markerLeft = (constraints.maxWidth * position - markerSize / 2)
                .clamp(0.0, constraints.maxWidth - markerSize);

            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Barra de gradiente: de tostado claro a muy oscuro (por si lo meto más adelante, aunque en cafés de especialidad no suelen tener ese tueste)
                Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(barHeight / 2),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFD4A96A), 
                        Color(0xFF8B5A2B), 
                        Color(0xFF3B1A08), 
                      ],
                    ),
                  ),
                ),
                // Marcador blanco con borde:
                Positioned(
                  left: markerLeft,
                  child: Container(
                    width: markerSize,
                    height: markerSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        width: 2.5,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 6),
        // Etiquetas extremos de la barra:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Claro',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              'Oscuro',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Widget: Sección altitudes comparativo ────────────────────────
  /// Card con el gráfico de barras de altitudes de todos los cafés.
  /// La barra del café seleccionado se resalta con el color primario.
  Widget _buildAltitudesSection(ThemeData theme) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 8, 16),
        child: Column(
          children: [
            Text(
              'Altitud Media del Cultivo',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Comparativa de todos los cafés · m.s.n.m.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            AltitudeBarChart(
              altitudes: _altitudesData,
              selectedId: _selectedCoffee?.id,
            ),
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
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 46),// dejo espacio bajo el gráfico
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

/// Datos visuales para el badge del método de proceso.
class _ProcessData {
  final Color color;
  final IconData icon;
  final String? description;
  const _ProcessData({
    required this.color,
    required this.icon,
    this.description,
  });
}
