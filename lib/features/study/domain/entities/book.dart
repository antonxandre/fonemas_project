class Book {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;
  final String coverImageAlt;
  final List<String> pages;
  final List<String> illustrations;
  final List<String> illustrationsAlt;
  final bool isRecommended;

  const Book({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.coverImageAlt,
    required this.pages,
    required this.illustrations,
    required this.illustrationsAlt,
    this.isRecommended = false,
  });
}
