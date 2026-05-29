import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../ui/core/theme/miki_design_system.dart';

class TrackSubPathPage extends StatefulWidget {
  final String trackId;

  const TrackSubPathPage({
    super.key,
    required this.trackId,
  });

  @override
  State<TrackSubPathPage> createState() => _TrackSubPathPageState();
}

class _TrackSubPathPageState extends State<TrackSubPathPage> with SingleTickerProviderStateMixin {
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    // Pulse glow animation for active node
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  String get _formattedTitle {
    switch (widget.trackId) {
      case 'vogais':
        return 'Vogais';
      case 'bilabiais':
        return 'Bilabiais';
      case 'alveolares':
        return 'Alveolares';
      case 'velares':
        return 'Velares';
      case 'fricativas':
        return 'Fricativas';
      default:
        return 'Alveolares';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MikiColors.background,
      extendBody: true,
      body: Stack(
        children: [
          // 1. Background concentric circles
          _buildBackgroundCircles(),

          // 2. Main content scrolling path
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 80), // Space for top header

                  // Daily Goal Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: _buildDailyGoalCard(),
                  ),
                  const SizedBox(height: 48),

                  // Sub-Path Nodes with custom organic path
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: CustomPaint(
                        painter: SubPathWavyConnectorPainter(
                          color: MikiColors.primary.withValues(alpha: 0.12),
                          strokeWidth: 1.5,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Column(
                            children: [
                              // Node 1: Completed
                              _buildSubPathNode(
                                label: '/s/ Inicial',
                                status: SubNodeStatus.completed,
                                horizontalOffset: 0,
                              ),
                              const SizedBox(height: 24),

                              // Node 2: Completed
                              _buildSubPathNode(
                                label: 'Grupos de /r/',
                                status: SubNodeStatus.completed,
                                horizontalOffset: 48,
                              ),
                              const SizedBox(height: 24),

                              // Node 3: Active (tappable)
                              _buildSubPathNode(
                                label: '/l/ Inicial',
                                symbol: '/l/',
                                status: SubNodeStatus.active,
                                horizontalOffset: -48,
                                onTap: () => context.push('/exercise/${widget.trackId}'),
                              ),
                              const SizedBox(height: 24),

                              // Node 4: Locked
                              _buildSubPathNode(
                                label: 'Africados /ch/',
                                status: SubNodeStatus.locked,
                                horizontalOffset: 32,
                              ),
                              const SizedBox(height: 24),

                              // Node 5: Locked
                              _buildSubPathNode(
                                label: 'Fricativos /th/',
                                status: SubNodeStatus.locked,
                                horizontalOffset: -64,
                              ),
                              const SizedBox(height: 36),

                              // Final Destination Node
                              _buildFinalDestinationNode(
                                label: 'O Grande Orador',
                                horizontalOffset: 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),

          // 3. Floating Glassmorphism Header
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

  // Header Builder
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
                      icon: const Icon(Icons.arrow_back_ios_new, color: MikiColors.primary),
                      onPressed: () => context.go('/'),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formattedTitle,
                      style: MikiTextStyles.headlineMd(color: MikiColors.text).copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.5),
                    border: Border.all(
                      color: MikiColors.primaryContainer,
                      width: 1.0,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person_outline,
                      color: MikiColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Daily Goal Card
  Widget _buildDailyGoalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: MikiDecorations.glassMorphism(
        borderRadius: 24,
        bgColor: Colors.white.withValues(alpha: 0.4),
        borderColor: Colors.white.withValues(alpha: 0.5),
      ).copyWith(
        boxShadow: [
          BoxShadow(
            color: MikiColors.primary.withValues(alpha: 0.03),
            blurRadius: 40,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PROGRESSO DIÁRIO',
                    style: MikiTextStyles.labelSm(
                      color: MikiColors.primary.withValues(alpha: 0.5),
                    ).copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Meta Diária',
                    style: MikiTextStyles.headlineMd(color: MikiColors.primary).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '12',
                    style: MikiTextStyles.headlineLg(color: MikiColors.primary).copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '/ 20',
                    style: MikiTextStyles.labelSm(
                      color: MikiColors.text.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          // Custom progress bar
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: MikiColors.outline.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.6, // 12 / 20 = 60%
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFC9CBF4), Color(0xFFAECCD2)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFAECCD2).withValues(alpha: 0.3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                // Indicator tip node
                Positioned(
                  left: (MediaQuery.of(context).size.width - 96) * 0.6 - 6, // dynamic offset matching list padding
                  top: -3,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFAECCD2),
                        width: 2.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.eco,
                color: MikiColors.rosePink,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'CONTINUE PROGREDINDO',
                style: MikiTextStyles.labelSm(color: MikiColors.text).copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Sub-Path Node Builder
  Widget _buildSubPathNode({
    required String label,
    String? symbol,
    required SubNodeStatus status,
    required double horizontalOffset,
    VoidCallback? onTap,
  }) {
    final double nodeSize = status == SubNodeStatus.active ? 80.0 : 56.0;
    
    // Node styling based on status
    BoxDecoration decoration;
    Widget child;

    switch (status) {
      case SubNodeStatus.completed:
        decoration = BoxDecoration(
          color: MikiColors.primaryContainer.withValues(alpha: 0.4),
          shape: BoxShape.circle,
          border: Border.all(
            color: MikiColors.primary.withValues(alpha: 0.1),
            width: 1.0,
          ),
        );
        child = const Icon(
          Icons.check,
          color: MikiColors.primary,
          size: 20,
        );
        break;
      case SubNodeStatus.active:
        decoration = MikiDecorations.glassMorphism(
          borderRadius: 40,
          bgColor: MikiColors.tertiaryContainer.withValues(alpha: 0.3),
          borderColor: MikiColors.tertiaryContainer,
        ).copyWith(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        );
        child = Text(
          symbol ?? '/l/',
          style: MikiTextStyles.headlineLg(color: MikiColors.primary).copyWith(
            fontWeight: FontWeight.w300,
          ),
        );
        break;
      case SubNodeStatus.locked:
        decoration = BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.08),
          shape: BoxShape.circle,
          border: Border.all(
            color: MikiColors.outlineVariant.withValues(alpha: 0.3),
            width: 1.0,
          ),
        );
        child = Icon(
          Icons.lock,
          color: MikiColors.text.withValues(alpha: 0.3),
          size: 18,
        );
        break;
    }

    return Center(
      child: Container(
        width: 320,
        height: 100,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Glowing circles behind active node
            if (status == SubNodeStatus.active) ...[
              AnimatedBuilder(
                animation: _glowController,
                builder: (context, child) {
                  return Positioned(
                    left: 160 + horizontalOffset - 40 - (20 * _glowController.value),
                    top: 50 - 40 - (20 * _glowController.value),
                    child: Opacity(
                      opacity: (1.0 - _glowController.value) * 0.5,
                      child: Container(
                        width: 80 + (40 * _glowController.value),
                        height: 80 + (40 * _glowController.value),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: MikiColors.primary.withValues(alpha: 0.2),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                left: 160 + horizontalOffset - 40,
                top: 50 - 40,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: MikiColors.tertiary.withValues(alpha: 0.15),
                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Node bubble button
            Positioned(
              left: 160 + horizontalOffset - (nodeSize / 2),
              top: 50 - (nodeSize / 2),
              child: GestureDetector(
                onTap: status == SubNodeStatus.active ? onTap : null,
                child: Opacity(
                  opacity: status == SubNodeStatus.locked ? 0.4 : 1.0,
                  child: Container(
                    width: nodeSize,
                    height: nodeSize,
                    decoration: decoration,
                    child: Center(child: child),
                  ),
                ),
              ),
            ),

            // Active badge for Node 3
            if (status == SubNodeStatus.active)
              Positioned(
                left: 160 + horizontalOffset + 24,
                top: 50 - (nodeSize / 2) - 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: MikiColors.tertiary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    'AGORA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

            // Label next to node bubble
            Positioned(
              left: 160 + horizontalOffset + (nodeSize / 2) + 16,
              top: 50 - 11,
              child: Opacity(
                opacity: status == SubNodeStatus.locked ? 0.4 : 1.0,
                child: Text(
                  label,
                  style: (status == SubNodeStatus.active
                          ? MikiTextStyles.headlineMd(color: MikiColors.primary)
                          : MikiTextStyles.labelMd(color: MikiColors.text))
                      .copyWith(
                    fontWeight: status == SubNodeStatus.active
                        ? FontWeight.w600
                        : FontWeight.normal,
                    fontSize: status == SubNodeStatus.active ? 18 : 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Final Goal Island
  Widget _buildFinalDestinationNode({
    required String label,
    required double horizontalOffset,
  }) {
    return Center(
      child: Container(
        width: 320,
        height: 140,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 160 + horizontalOffset - 48,
              top: 40 - 48,
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MikiColors.primary.withValues(alpha: 0.1),
                    width: 1.0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 160 + horizontalOffset - 40,
              top: 40 - 40,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: MikiDecorations.glassMorphism(
                    borderRadius: 40,
                    bgColor: Colors.white.withValues(alpha: 0.3),
                    borderColor: MikiColors.primary.withValues(alpha: 0.2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.auto_awesome,
                      color: MikiColors.primary,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 96,
              child: Opacity(
                opacity: 0.4,
                child: Text(
                  label.toUpperCase(),
                  style: MikiTextStyles.labelSm(color: MikiColors.text).copyWith(
                    letterSpacing: 2.0,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Background Concentric Circle Builder
  Widget _buildBackgroundCircles() {
    return Stack(
      children: [
        Positioned(
          left: -200,
          top: 100,
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x268E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
        Positioned(
          left: -190,
          top: 110,
          child: Container(
            width: 580,
            height: 580,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x0F8E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: 400,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x268E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
        Positioned(
          right: 15,
          top: 395,
          child: Container(
            width: 210,
            height: 210,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x0F8E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum SubNodeStatus {
  completed,
  active,
  locked,
}

// Custom Painter for Sub-Path wavy trail connector
class SubPathWavyConnectorPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  SubPathWavyConnectorPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Start at center-top
    path.moveTo(w * 0.5, 0);

    // C 140,100 60,200 100,300
    path.cubicTo(
      w * (140 / 200), h * (100 / 800),
      w * (60 / 200), h * (200 / 800),
      w * 0.5, h * (300 / 800),
    );

    // S 140,500 100,600
    // (reflected CP1: X = 140, Y = 400)
    path.cubicTo(
      w * (140 / 200), h * (400 / 800),
      w * (140 / 200), h * (500 / 800),
      w * 0.5, h * (600 / 800),
    );

    // S 60,700 100,800
    // (reflected CP1: X = 60, Y = 700)
    path.cubicTo(
      w * (60 / 200), h * (700 / 800),
      w * (60 / 200), h * (700 / 800),
      w * 0.5, h,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
