import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/exercise.dart';

class ExerciseSeeder {
  final FirebaseFirestore _firestore;

  ExerciseSeeder({FirebaseFirestore? firestore}) 
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> seedIfNeeded() async {
    try {
      final snapshot = await _firestore.collection('exercises').limit(1).get();
      if (snapshot.docs.isEmpty) {
        debugPrint('🌱 Exercises collection is empty. Seeding database...');
        await _runSeeder();
        debugPrint('✅ Exercises seeded successfully.');
      } else {
        debugPrint('🌳 Exercises collection already has data. Skipping seeder.');
      }
    } catch (e) {
      debugPrint('❌ Error while checking/seeding exercises: $e');
    }
  }

  Future<void> _runSeeder() async {
    final batch = _firestore.batch();
    final collection = _firestore.collection('exercises');

    // Helper function to create an exercise document with the correct phonemeId
    void addExercise(String id, String phonemeId, Exercise exercise) {
      final docRef = collection.doc(id);
      final data = exercise.toMap();
      data['phonemeId'] = phonemeId; // Link to the phoneme
      batch.set(docRef, data);
    }

    // --- Exercícios para Vogal /a/ (vogal_oral_a) ---
    addExercise('ex_a_1', 'vogal_oral_a', const Exercise(
      id: 'ex_a_1',
      type: 'minimal_pairs',
      prompt: 'Onde está o som certo? (/a/)',
      correctOption: 'Arara',
      options: [
        ExerciseOption(
          text: 'Arara',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA7LPeXNt-U8wfqgzxleMyvdCQElcQzImyilRA7dG6zQZ1K57EG7eAsO0iEjlDu4Jh7iKuS5SvjR8WLvSbBGU-HlzAzqWOT4tPpZlVWACzR3lMthsPkCsat733Mtq5i4he28I6uev8kNuBqGxKJOSVov2TytnF_1vHkaVfCq4Wa6DUOw-prB0y4UCQdlGUruG2vL4NAmZCFzOmh4kljUau3ulBpHYb8c5MiyO0XdpFDz42rvoPIgMat9-gmS0lo_ZmMIynhrLc5-eZN',
        ),
        ExerciseOption(
          text: 'Baleia',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuATNXjpH96GLFWNIez1kyTejd9Ohc2oh1brBXs-KO4V2fWmLDEsQL0W5ZmWgTzawgoyl7z063nQ4pnvdzE5savVNb9IXyV2bsJmnX-eDRuWRbx9v9X2yUrHIitMYBFVha7O4YukawsK95ZJDH4UqAR4ImIO_8RUlYpWyAP0IasXxBTWo2eWAvzIqyXlzBiRZYtxFOixKMZ3IfuqHqL24uKYdp-tzA17P1hwFBW7u9P3AZRFJXNFSX56Xe5YXxwySNu2JbEPJLHkZCJA',
        ),
      ],
    ));

    addExercise('ex_a_2', 'vogal_oral_a', const Exercise(
      id: 'ex_a_2',
      type: 'minimal_pairs',
      prompt: 'Onde está o som de /a/?',
      correctOption: 'Abacaxi',
      options: [
        ExerciseOption(text: 'Abacaxi'),
        ExerciseOption(text: 'Uva'),
        ExerciseOption(text: 'Morango'),
        ExerciseOption(text: 'Limão'),
      ],
    ));

    // --- Exercícios para Vogal /ɛ/ (vogal_oral_e_aberta) ---
    addExercise('ex_e_1', 'vogal_oral_e_aberta', const Exercise(
      id: 'ex_e_1',
      type: 'minimal_pairs',
      prompt: 'Qual animal tem o som de /ɛ/?',
      correctOption: 'Jacaré',
      options: [
        ExerciseOption(text: 'Sapo'),
        ExerciseOption(text: 'Jacaré'),
      ],
    ));

    await batch.commit();
  }
}
