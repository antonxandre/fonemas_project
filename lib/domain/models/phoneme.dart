class Phoneme {
  final String id;
  final String symbol; // e.g. "/a/"
  final String name; // e.g. "Aberta, Central"
  final List<String> examples; // e.g. ["casa", "pai"]
  final String categoryId; // e.g. "vogais"
  final String subcategoryId; // e.g. "orais" or "nasais"
  final String locale; // e.g. "pt_BR"

  const Phoneme({
    required this.id,
    required this.symbol,
    required this.name,
    required this.examples,
    required this.categoryId,
    required this.subcategoryId,
    required this.locale,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'examples': examples,
      'categoryId': categoryId,
      'subcategoryId': subcategoryId,
      'locale': locale,
    };
  }

  factory Phoneme.fromMap(Map<String, dynamic> map, String documentId) {
    return Phoneme(
      id: documentId,
      symbol: map['symbol'] ?? '',
      name: map['name'] ?? '',
      examples: List<String>.from(map['examples'] ?? []),
      categoryId: map['categoryId'] ?? '',
      subcategoryId: map['subcategoryId'] ?? '',
      locale: map['locale'] ?? 'pt_BR',
    );
  }
}
