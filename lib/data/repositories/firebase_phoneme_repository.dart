import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/phoneme.dart';
import '../../domain/repositories/phoneme_repository.dart';

class FirebasePhonemeRepository implements PhonemeRepository {
  final FirebaseFirestore _firestore;

  FirebasePhonemeRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Phoneme>> getPhonemesByCategory(String categoryId, {String? subCategoryId}) async {
    Query query = _firestore.collection('phonemes').where('categoryId', isEqualTo: categoryId);
    
    if (subCategoryId != null) {
      query = query.where('subcategoryId', isEqualTo: subCategoryId);
    }
    
    final snapshot = await query.get();
    
    final phonemes = snapshot.docs.map((doc) {
      return Phoneme.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();

    // Sort in-memory to avoid requiring a composite index in Firestore
    phonemes.sort((a, b) => a.symbol.compareTo(b.symbol));

    return phonemes;
  }
}
