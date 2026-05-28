import 'package:flutter/material.dart';
import '../../../../core/theme/miki_design_system.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MikiColors.background,
      body: Stack(
        children: [
          // 1. Concentric background decorative circles
          _buildBackgroundCircles(),

          // 2. Main content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80), // Space for top header

                  // Profile Avatar
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: MikiColors.primary.withValues(alpha: 0.2),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: MikiColors.primary.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: MikiColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Miki Style',
                    style: MikiTextStyles.headlineMd(color: MikiColors.text).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Fonoaudiologia Infantil',
                    style: MikiTextStyles.bodyMd(
                      color: MikiColors.text.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Stats section
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.local_fire_department,
                          iconColor: Colors.orange,
                          value: '5 Dias',
                          label: 'Ofensiva',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.star,
                          iconColor: Colors.amber,
                          value: '120 XP',
                          label: 'Pontuação',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Achievements or Settings list
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    decoration: MikiDecorations.glassMorphism(
                      borderRadius: 24,
                      bgColor: Colors.white.withValues(alpha: 0.5),
                      borderColor: Colors.white.withValues(alpha: 0.6),
                    ),
                    child: Column(
                      children: [
                        _buildSettingItem(
                          icon: Icons.palette_outlined,
                          title: 'Estilo Visual',
                          subtitle: 'Tema Miki Suave',
                        ),
                        const Divider(height: 24, color: Colors.white),
                        _buildSettingItem(
                          icon: Icons.volume_up_outlined,
                          title: 'Efeitos Sonoros',
                          subtitle: 'Habilitados',
                        ),
                        const Divider(height: 24, color: Colors.white),
                        _buildSettingItem(
                          icon: Icons.notifications_none_outlined,
                          title: 'Lembrete Diário',
                          subtitle: 'Todos os dias às 18:00',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 120), // Scroll spacer
                ],
              ),
            ),
          ),

          // 3. Floating glass header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1.0,
          ),
        ),
      ),
      child: ClipRRect(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: MikiColors.primary),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Perfil',
                      style: MikiTextStyles.headlineMd(color: MikiColors.text).copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: MikiColors.primary),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: MikiDecorations.glassMorphism(
        borderRadius: 24,
        bgColor: Colors.white.withValues(alpha: 0.5),
        borderColor: Colors.white.withValues(alpha: 0.6),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: MikiTextStyles.headlineSm(color: MikiColors.text).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: MikiTextStyles.labelSm(
              color: MikiColors.text.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: MikiColors.primary.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: MikiColors.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: MikiTextStyles.headlineSm(color: MikiColors.text).copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: MikiTextStyles.bodyMd(
                  color: MikiColors.text.withValues(alpha: 0.5),
                ).copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.chevron_right,
          color: MikiColors.outline,
          size: 20,
        ),
      ],
    );
  }

  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        Positioned(
          left: -150,
          top: 150,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x1F8E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
        Positioned(
          right: -100,
          bottom: 100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x148E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
