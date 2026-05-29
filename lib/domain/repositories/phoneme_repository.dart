import '../../domain/models/phoneme.dart';

abstract class PhonemeRepository {
  Future<List<Phoneme>> getPhonemesByCategory(String categoryId, {String? subCategoryId});
}
