import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/miki_design_system.dart';
import '../widgets/miki_bottom_nav_bar.dart';

class MainNavigationPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigationPage({
    super.key,
    required this.navigationShell,
  });

  void _onItemTapped(int index) {
    final oldIndex = navigationShell.currentIndex;
    if (oldIndex != index) {
      final tabNames = ['Trilha', 'Estudos', 'Perfil'];
      debugPrint('[Tab] Switch tab from ${tabNames[oldIndex]} to ${tabNames[index]}');
    }
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MikiColors.background,
      body: Stack(
        children: [
          navigationShell,
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MikiBottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
