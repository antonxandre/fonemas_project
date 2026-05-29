import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../generated/l10n/app_localizations.dart';
import '../view_models/book_reading_view_model.dart';
import '../../../../ui/core/theme/miki_design_system.dart';

class BookReadingPage extends StatelessWidget {
  final String bookId;

  const BookReadingPage({
    super.key,
    required this.bookId,
  });

  void _showCompletionDialog(BuildContext context, String bookTitle) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(28.0),
            decoration: MikiDecorations.glassMorphism(
              borderRadius: 32,
              bgColor: Colors.white.withValues(alpha: 0.95),
              borderColor: MikiColors.primaryContainer,
            ).copyWith(
              boxShadow: [
                BoxShadow(
                  color: MikiColors.primary.withValues(alpha: 0.15),
                  blurRadius: 40,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE2F6E9),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.auto_stories,
                      color: Color(0xFF34C759),
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Leitura Concluída!',
                  style: MikiTextStyles.headlineLg(color: MikiColors.text).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Parabéns! Você concluiu a leitura de "$bookTitle". Continue praticando para sua voz florescer!',
                  textAlign: TextAlign.center,
                  style: MikiTextStyles.bodyMd(
                    color: MikiColors.text.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss Dialog
                      context.go('/study'); // Go back to study home
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MikiColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: Text(
                      l10n.backToTrack,
                      style: MikiTextStyles.labelSm(color: Colors.white).copyWith(
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<BookReadingViewModel>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: MikiColors.background,
      body: Stack(
        children: [
          // 1. Decorative background paths & circles
          _buildBackgroundDecorations(),

          // 2. Page Content container
          SafeArea(
            bottom: false,
            child: ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                if (viewModel.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: MikiColors.primary),
                  );
                }

                if (viewModel.errorMessage != null) {
                  return Scaffold(
                    backgroundColor: MikiColors.background,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back, color: MikiColors.primary),
                        onPressed: () => context.go('/study'),
                      ),
                    ),
                    body: Center(
                      child: Text(viewModel.errorMessage!),
                    ),
                  );
                }

                final book = viewModel.book;
                if (book == null) {
                  return const SizedBox.shrink();
                }

                final currentPageIndex = viewModel.currentPageIndex;
                final totalPages = book.pages.length;
                final currentPageText = book.pages[currentPageIndex];
                final currentIllustration = book.illustrations[currentPageIndex];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 80), // Space for top header

                    // Minimalist Illustration Area
                    Expanded(
                      flex: 11,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                        child: Container(
                          decoration: MikiDecorations.glassMorphism(
                            borderRadius: 36,
                            bgColor: Colors.white.withValues(alpha: 0.35),
                            borderColor: Colors.white.withValues(alpha: 0.5),
                          ).copyWith(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              )
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            currentIllustration,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: MikiColors.primaryContainer.withValues(alpha: 0.3),
                              child: const Icon(Icons.menu_book_sharp, color: MikiColors.primary, size: 50),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Story text segment
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 1.5,
                              color: MikiColors.primary.withValues(alpha: 0.15),
                            ),
                            const SizedBox(height: 24),
                            // Page Text
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Text(
                                  currentPageText,
                                  textAlign: TextAlign.center,
                                  style: MikiTextStyles.bodyLg(color: MikiColors.text).copyWith(
                                    fontSize: 21,
                                    height: 1.55,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Dots Progress Indicators
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(totalPages, (index) {
                                final isActive = index == currentPageIndex;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                  height: 6,
                                  width: isActive ? 24 : 6,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? MikiColors.primary
                                        : MikiColors.primary.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                );
                                }),
                              ),
                            const SizedBox(height: 80), // Space for bottom navigation controls
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // 3. Floating glass top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(context),
          ),

          // 4. Floating bottom navigation page turn controls
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                final book = viewModel.book;
                if (book == null) {
                  return const SizedBox.shrink();
                }
                return _buildFloatingControls(context, viewModel, book.pages.length);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Top header bar
  Widget _buildHeader(BuildContext context) {
    final viewModel = context.read<BookReadingViewModel>();
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
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: MikiColors.primary),
                  onPressed: () => context.go('/study'),
                ),
                Expanded(
                  child: ListenableBuilder(
                    listenable: viewModel,
                    builder: (context, _) {
                      final title = viewModel.book?.title ?? '';
                      return Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: MikiTextStyles.headlineMd(color: MikiColors.primary).copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 48), // Balance for back button
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Floating controls at bottom
  Widget _buildFloatingControls(BuildContext context, BookReadingViewModel viewModel, int totalPages) {
    final isFirstPage = viewModel.currentPageIndex == 0;

    return Container(
      height: 72,
      decoration: MikiDecorations.glassMorphism(
        borderRadius: 36,
        bgColor: Colors.white.withValues(alpha: 0.5),
        borderColor: Colors.white.withValues(alpha: 0.6),
      ).copyWith(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous page button
          Opacity(
            opacity: isFirstPage ? 0.3 : 1.0,
            child: SizedBox(
              width: 56,
              height: 56,
              child: IconButton(
                icon: const Icon(Icons.chevron_left, color: MikiColors.primary, size: 28),
                onPressed: isFirstPage ? null : () => viewModel.prevPage(),
                style: IconButton.styleFrom(
                  backgroundColor: MikiColors.background,
                  shape: const CircleBorder(),
                ),
              ),
            ),
          ),
          // Page label text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PÁGINA',
                style: MikiTextStyles.labelSm(
                  color: MikiColors.text.withValues(alpha: 0.5),
                ).copyWith(fontSize: 8, letterSpacing: 1.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                '${viewModel.currentPageIndex + 1} de $totalPages',
                style: MikiTextStyles.headlineSm(color: MikiColors.primary).copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Next page button
          SizedBox(
            width: 56,
            height: 56,
            child: IconButton(
              icon: const Icon(Icons.chevron_right, color: Colors.white, size: 28),
              onPressed: () {
                viewModel.nextPage();
                if (viewModel.isCompleted) {
                  _showCompletionDialog(context, viewModel.book!.title);
                }
              },
              style: IconButton.styleFrom(
                backgroundColor: MikiColors.primary,
                shape: const CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Background decorations
  Widget _buildBackgroundDecorations() {
    return Stack(
      children: [
        Positioned(
          left: -150,
          top: -50,
          child: Container(
            width: 400,
            height: 400,
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
