import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../generated/l10n/app_localizations.dart';
import '../view_models/study_view_model.dart';
import '../../../../domain/models/book.dart';
import '../../../../ui/core/theme/miki_design_system.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<StudyViewModel>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MikiColors.background,
      body: Stack(
        children: [
          // 1. Concentric background decorative circles & organic path
          _buildBackgroundDecorations(context),

          // 2. Main content scrolling area
          SafeArea(
            bottom: false,
            child: ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                if (viewModel.isLoading && viewModel.books.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: MikiColors.primary,
                    ),
                  );
                }

                if (viewModel.errorMessage != null && viewModel.books.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.errorLoadingBooks,
                          style: MikiTextStyles.headlineSm(color: MikiColors.primary),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          viewModel.errorMessage!,
                          style: MikiTextStyles.bodyMd(color: MikiColors.text),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => viewModel.loadBooks(),
                          child: Text(l10n.tryAgain),
                        ),
                      ],
                    ),
                  );
                }

                final books = viewModel.books;
                Book? recommendedBook;
                List<Book> gridBooks = [];

                if (books.isNotEmpty) {
                  recommendedBook = books.firstWhere((b) => b.isRecommended, orElse: () => books.first);
                  gridBooks = books.where((b) => b.id != recommendedBook?.id).toList();
                }

                return RefreshIndicator(
                  onRefresh: () => viewModel.loadBooks(),
                  color: MikiColors.primary,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 80), // Space for top header

                        // Welcome Header Section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.studyArea,
                              style: MikiTextStyles.headlineLg(color: MikiColors.primary).copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.studyDescription,
                              style: MikiTextStyles.bodyMd(
                                color: MikiColors.text.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Highlights (Featured Book) Section
                        if (recommendedBook != null) ...[
                          _buildSectionHeader(title: 'Destaques', icon: Icons.auto_awesome),
                          const SizedBox(height: 12),
                          _buildFeaturedBookCard(context, recommendedBook),
                          const SizedBox(height: 40),
                        ],

                        // Free Books Grid Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Livros Gratuitos',
                              style: MikiTextStyles.headlineMd(color: MikiColors.primary).copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'VER TODOS',
                              style: MikiTextStyles.labelSm(color: MikiColors.text.withValues(alpha: 0.5)).copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 24,
                            childAspectRatio: 0.68,
                          ),
                          itemCount: gridBooks.length + 1, // +1 for Coming Soon card
                          itemBuilder: (context, index) {
                            if (index < gridBooks.length) {
                              return _buildGridBookCard(context, gridBooks[index]);
                            } else {
                              return _buildComingSoonCard();
                            }
                          },
                        ),

                        const SizedBox(height: 120), // Spacer to scroll past bottom bar
                      ],
                    ),
                  ),
                );
              },
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

  // Section header
  Widget _buildSectionHeader({required String title, required IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.toUpperCase(),
          style: MikiTextStyles.labelSm(color: MikiColors.primary).copyWith(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          icon,
          color: MikiColors.primary.withValues(alpha: 0.4),
          size: 16,
        ),
      ],
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
                      icon: const Icon(Icons.menu, color: MikiColors.primary),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'FonoKit',
                      style: MikiTextStyles.headlineMd(color: MikiColors.primary).copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 32,
                  height: 32,
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
                      size: 18,
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

  // Featured Recommended Book Card
  Widget _buildFeaturedBookCard(BuildContext context, Book book) {
    return GestureDetector(
      onTap: () => context.push('/study/read/${book.id}'),
      child: Container(
        decoration: MikiDecorations.glassMorphism(
          borderRadius: 28,
          bgColor: Colors.white.withValues(alpha: 0.45),
          borderColor: Colors.white.withValues(alpha: 0.5),
        ).copyWith(
          boxShadow: [
            BoxShadow(
              color: MikiColors.primary.withValues(alpha: 0.08),
              blurRadius: 25,
              offset: const Offset(0, 10),
            )
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.network(
                book.coverImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: MikiColors.primaryContainer,
                  child: const Icon(Icons.menu_book, color: MikiColors.primary, size: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: MikiColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'RECOMENDADO',
                      style: MikiTextStyles.labelSm(color: MikiColors.onSecondaryContainer).copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    book.title,
                    style: MikiTextStyles.headlineMd(color: MikiColors.primary).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    book.description,
                    style: MikiTextStyles.bodyMd(
                      color: MikiColors.text.withValues(alpha: 0.7),
                    ).copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () => context.push('/study/read/${book.id}'),
                      icon: const Icon(Icons.menu_book, size: 16),
                      label: Text(
                        'LER AGORA',
                        style: MikiTextStyles.labelSm(color: Colors.white).copyWith(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MikiColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
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

  // Grid item card
  Widget _buildGridBookCard(BuildContext context, Book book) {
    return GestureDetector(
      onTap: () => context.push('/study/read/${book.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: MikiDecorations.glassMorphism(
                borderRadius: 20,
                bgColor: Colors.white.withValues(alpha: 0.4),
                borderColor: Colors.white.withValues(alpha: 0.5),
              ).copyWith(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        book.coverImageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: MikiColors.primaryContainer.withValues(alpha: 0.4),
                          child: const Icon(Icons.book, color: MikiColors.primary, size: 30),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: MikiColors.rosePink,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Grátis',
                        style: TextStyle(
                          color: MikiColors.tertiary,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            book.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: MikiTextStyles.labelSm(color: MikiColors.primary).copyWith(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          InkWell(
            onTap: () => context.push('/study/read/${book.id}'),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ler Agora',
                  style: TextStyle(
                    color: MikiColors.secondary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 2),
                Icon(
                  Icons.chevron_right,
                  color: MikiColors.secondary,
                  size: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Coming soon empty state grid card
  Widget _buildComingSoonCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: MikiColors.primary.withValues(alpha: 0.15),
                width: 1.5,
                style: BorderStyle.values[1],
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_stories_outlined,
                    color: MikiColors.primaryFixedDim,
                    size: 28,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Novas histórias\nem breve',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: MikiColors.primaryFixedDim,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Mistério da Floresta',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: MikiTextStyles.labelSm(color: MikiColors.primary.withValues(alpha: 0.4)).copyWith(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Background Concentric Circles
  Widget _buildBackgroundDecorations(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: -100,
          top: 120,
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x1A8E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
        Positioned(
          right: -120,
          bottom: 180,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x148E8D96),
                width: 0.5,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: StudyOrganicPathPainter(
              color: MikiColors.primary.withValues(alpha: 0.08),
            ),
          ),
        ),
      ],
    );
  }
}

// Background dashed path custom painter
class StudyOrganicPathPainter extends CustomPainter {
  final Color color;

  StudyOrganicPathPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(-20, h * 0.1);
    path.cubicTo(w * 0.3, h * 0.15, w * 0.7, h * 0.05, w + 20, h * 0.25);
    path.cubicTo(w * 0.7, h * 0.45, w * 0.3, h * 0.55, -20, h * 0.7);
    path.cubicTo(w * 0.3, h * 0.85, w * 0.7, h * 0.9, w + 20, h * 0.95);

    // Draw dashed path
    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0.0;
      const dashLength = 5.0;
      const spaceLength = 5.0;
      while (distance < metric.length) {
        final length = dashLength;
        final nextDistance = distance + length;
        final extractPath = metric.extractPath(distance, nextDistance);
        canvas.drawPath(extractPath, paint);
        distance = nextDistance + spaceLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
