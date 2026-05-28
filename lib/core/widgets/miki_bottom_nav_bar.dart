import 'package:flutter/material.dart';
import '../theme/miki_design_system.dart';

class MikiBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MikiBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        boxShadow: [
          BoxShadow(
            color: MikiColors.primary.withValues(alpha: 0.08),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, -6),
          ),
        ],
        border: const Border(
          top: BorderSide(
            color: MikiColors.outlineVariant,
            width: 1.0,
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 10.0,
            bottom: 8.0 + bottomPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(
                context: context,
                icon: Icons.alt_route,
                label: 'TRILHA',
                index: 0,
              ),
              _buildBottomNavItem(
                context: context,
                icon: Icons.menu_book_outlined,
                label: 'ESTUDOS',
                index: 1,
              ),
              _buildBottomNavItem(
                context: context,
                icon: Icons.person_outline_rounded,
                label: 'PERFIL',
                index: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isActive = index == currentIndex;
    final color = isActive ? MikiColors.primary : MikiColors.outline;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: isActive ? MikiColors.primaryContainer : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: MikiTextStyles.labelSm(color: color).copyWith(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
