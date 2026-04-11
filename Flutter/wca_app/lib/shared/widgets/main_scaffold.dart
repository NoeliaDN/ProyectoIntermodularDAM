import 'package:flutter/material.dart';
import 'package:wca_app/features/home/screens/home_screen.dart';
import 'package:wca_app/features/coffee_list/screens/coffee_list_screen.dart';
import 'package:wca_app/features/coffee_detail/screens/coffee_detail_screen.dart';

/// Scaffold principal con [NavigationBar] (Material 3).

/// Este widget controla la navegación entre las 3 secciones de la app:
///   0 → Mapa global (Home)      — icono: globo terráqueo
///   1 → Listado de cafés        — icono: taza de café
///   2 → Variedades              — icono: grano de café? --> TOD0: revisar icono


class MainScaffold extends StatefulWidget {/// El estado del índice seleccionado se gestiona con un [StatefulWidget]
                                          /// porque es un estado local de UI (no necesita gestión de estado global).
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  // Índice pestaña seleccionada:
  int _selectedIndex = 0; // Home -->pantalla principal

  // Lista pantallas:
  static const List<Widget> _screens = [
    HomeScreen(),
    CoffeeListScreen(),
    CoffeeDetailScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El body muestra la pantalla correspondiente al índice seleccionado.
      body: _screens[_selectedIndex],

      // ── Barra de navegación inferior ─────────────────────────────
      bottomNavigationBar: NavigationBar(
        // Índice actual: controla qué destino está activo.
        selectedIndex: _selectedIndex,

        // Callback--> se ejecuta al pulsar un destino:      
        onDestinationSelected: (int index) {
          setState(() { //reconstruye el widget con el nuevo índice.
            _selectedIndex = index;
          });
        },

        // Destinos de navegación, con iconos y eqtiquetas:
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.public_outlined),
            selectedIcon: Icon(Icons.public),
            label: 'Mapa',
          ),
          NavigationDestination(
            icon: Icon(Icons.coffee_outlined),
            selectedIcon: Icon(Icons.coffee),
            label: 'Cafés',
          ),
          NavigationDestination(
            icon: Icon(Icons.eco_outlined),
            selectedIcon: Icon(Icons.eco),
            label: 'Variedades',
          ),
        ],
      ),
    );
  }
}
