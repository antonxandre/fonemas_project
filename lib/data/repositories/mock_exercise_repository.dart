import '../../domain/models/exercise.dart';
import '../../domain/repositories/exercise_repository.dart';

class MockExerciseRepository implements ExerciseRepository {
  @override
  Future<List<Exercise>> getExercisesForTrack(String trackId) async {
    // Simulate short loading delay
    await Future.delayed(const Duration(milliseconds: 300));

    return const [
      // 1. Cards Minimalistas Miki (2 Cards with images)
      Exercise(
        id: 'ex_1',
        type: 'minimal_pairs',
        prompt: 'Onde está o som certo?',
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
      ),

      // 2. Desafio de 4 Animais (2x2 Grid with images)
      Exercise(
        id: 'ex_2',
        type: 'minimal_pairs',
        prompt: 'Onde está o som certo?',
        correctOption: 'Arara',
        options: [
          ExerciseOption(
            text: 'Arara',
            imageUrl: 'https://lh3.googleusercontent.com/aida/ADBb0ugajT7_yg1Ak5V9KVzftxNIDcqIEjVfnyoBgAy4f6uXWKQ9EArya7_tZ7lwlPBHpfeINaWyfNdl6G3NlHyCcy7HZsCY6RhYxFe2R0hNTWzhtAApRPjAa_tDrTY8x5w0y6MsVhOqbIFAGmH_8Qw-gk7Htg_GkVwEDYqA48UyApqMzTR9oWEqYA14oWeYFQEt0bSJ5cTV4OVb3e73ob2JWMl3gt3GLBbYFBhMsCq2666q2HMGDVtJSLUFgZy8',
          ),
          ExerciseOption(
            text: 'Raposa',
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAsoOOCp5if6PapqUuEaIz-LyndpDjYywJALq2i8TGUJXuKRbPDXCid8lNb6zU_vOPpvfpIl_VVRT6vQImLi28aNtkcrKxOagrPPBNL84DDKdDFSYNN-nMQSunLrn0qPTIF4SxKIQP7NIRE-4r5Abh5MSl5O1j1ZIqgu1uXbCo7WDJBXSqFrya5N2XqCAZVKG7yq4fmnqYD4AAXQBxI-ZYwlywez61pQc1znF1RzIAdSxB1q8dmgqQaZKejG1yYnIIgOHFwCOSlx6tA',
          ),
          ExerciseOption(
            text: 'Coelho',
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAST4DETBZmNjIaGH7LQsd80Dh_-9ORthxYdl5Ns1KYYSqdbZeLnMRLJ5Z5EMcQAFki6M8zLRB97qQXqgCI-2r5WTHhPVJt-bi0FtimKazTKrushSodknF43xzwZd-Gw2A5vxcDGZv6HcoAEZ5iN-wlCE2QHIckH4ospn9gWCYFmajorLmYwUezm6RWBBHGOfgzfv8ZQig0OSSDwXeBNTASYfY65A0hB-Qa5mzsid8gPXAAmnwo2fByuJep-qr1d7MDC4scPa2OJXN1',
          ),
          ExerciseOption(
            text: 'Tartaruga',
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD92A_vb2Crzv2vihlBdD1q006d_Tpyrxi0gYw4gxK5sbEuNjUyOkJ5H-BRh69QsWP7efsQlKW9XVCNyuRex0byfrTj1u3Up2-OAUbR6KnZLObXhFEAWBAn69S2c9G9wXFhCcw_KcF-tL2W5oIuyozZA7gmqWVf94PVRNlHFGAdn9_i_QFJmRERvdByEOrnwU_HAbcpP_m1GewervuqFhy9J1NzMJA6HCvfLCmSWPlYNHLWupwHsApOA0oKlsodkeOHs-ftHAmCfdGm',
          ),
        ],
      ),

      // 3. Text-only Minimal Pairs (No images - demonstrating adaptive fallback)
      Exercise(
        id: 'ex_3',
        type: 'minimal_pairs',
        prompt: 'Qual palavra inicia com /f/?',
        correctOption: 'Faca',
        options: [
          ExerciseOption(text: 'Faca'),
          ExerciseOption(text: 'Vaca'),
        ],
      ),
    ];
  }
}
