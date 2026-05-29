import 'package:flutter/material.dart';
import '../../../../generated/l10n/app_localizations.dart';
import '../../../../ui/core/theme/miki_design_system.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MikiColors.background,
      body: Stack(
        children: [
          // Background concentric circles
          _buildBackgroundCircles(),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  // Page Title & Subtitle
                  Text(
                    l10n.profileTitle,
                    style: MikiTextStyles.headlineLg(color: MikiColors.text).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.profileSubtitle,
                    style: MikiTextStyles.bodyMd(color: MikiColors.outline),
                  ),
                  const SizedBox(height: 36),

                  // Avatar & General info Card
                  _buildProfileCard(),
                  const SizedBox(height: 24),

                  // Therapist Diagnostics and Clinical Stats
                  Text(
                    "Métricas Clínicas",
                    style: MikiTextStyles.headlineSm(color: MikiColors.text).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStatTile(
                    icon: Icons.graphic_eq,
                    color: MikiColors.lavender,
                    title: "Precisão de Pronúncia",
                    value: "92%",
                  ),
                  const SizedBox(height: 12),
                  _buildStatTile(
                    icon: Icons.history_edu,
                    color: MikiColors.iceBlue,
                    title: "Tempo de Estudo Total",
                    value: "4h 25min",
                  ),
                  const SizedBox(height: 12),
                  _buildStatTile(
                    icon: Icons.task_alt,
                    color: MikiColors.rosePink,
                    title: "Exercícios Concluídos",
                    value: "18 / 24",
                  ),
                  const SizedBox(height: 36),

                  // System Info Card (Miki Style branding)
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: MikiDecorations.glassMorphism(borderRadius: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.mikiStyle,
                          style: MikiTextStyles.labelMd(color: MikiColors.primary).copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "v1.0.0",
                          style: MikiTextStyles.labelSm(color: MikiColors.outline),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Space to scroll past navigation bar
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [MikiColors.primary, MikiColors.lavender],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: MikiColors.primary.withValues(alpha: 0.2),
                  blurRadius: 12,
                  spreadRadius: 2,
                )
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // User Name
          Text(
            "Arthur Andrade",
            style: MikiTextStyles.headlineSm(color: MikiColors.text).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          // User Role/Details
          Text(
            "Paciente • Trilha de Fonemas Alveolares",
            style: MikiTextStyles.labelSm(color: MikiColors.outline),
          ),
        ],
      ),
    );
  }

  Widget _buildStatTile({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: MikiColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: MikiColors.text.withValues(alpha: 0.7),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: MikiTextStyles.bodyMd(color: MikiColors.text).copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: MikiTextStyles.headlineSm(color: MikiColors.primary).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        Positioned(
          left: -120,
          top: -120,
          child: Container(
            width: 320,
            height: 320,
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
          right: -80,
          bottom: 120,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x1F8E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
