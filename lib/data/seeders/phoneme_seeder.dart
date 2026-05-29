import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/phoneme.dart';

class PhonemeSeeder {
  final FirebaseFirestore _firestore;

  PhonemeSeeder({FirebaseFirestore? firestore}) 
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> seedIfNeeded() async {
    try {
      final snapshot = await _firestore.collection('phonemes').limit(1).get();
      if (snapshot.docs.isEmpty) {
        debugPrint('🌱 Phonemes collection is empty. Seeding database...');
        await _runSeeder();
        debugPrint('✅ Phonemes seeded successfully.');
      } else {
        debugPrint('🌳 Phonemes collection already has data. Skipping seeder.');
      }
    } catch (e) {
      debugPrint('❌ Error while checking/seeding phonemes: $e');
    }
  }

  Future<void> _runSeeder() async {
    final batch = _firestore.batch();
    final collection = _firestore.collection('phonemes');

    final phonemes = [
      // --- Vogais Orais ---
      const Phoneme(
        id: 'vogal_oral_a',
        symbol: '/a/',
        name: 'Aberta, Central',
        examples: ['casa', 'pai'],
        categoryId: 'vogais',
        subcategoryId: 'orais',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'vogal_oral_e_aberta',
        symbol: '/ɛ/',
        name: 'Média-aberta, Anterior',
        examples: ['pé', 'bela'],
        categoryId: 'vogais',
        subcategoryId: 'orais',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'vogal_oral_e_fechada',
        symbol: '/e/',
        name: 'Média-fechada, Anterior',
        examples: ['você', 'mesa'],
        categoryId: 'vogais',
        subcategoryId: 'orais',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'vogal_oral_i',
        symbol: '/i/',
        name: 'Fechada, Anterior',
        examples: ['dia', 'fita'],
        categoryId: 'vogais',
        subcategoryId: 'orais',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'vogal_oral_o_aberta',
        symbol: '/ɔ/',
        name: 'Média-aberta, Posterior',
        examples: ['vó', 'porta'],
        categoryId: 'vogais',
        subcategoryId: 'orais',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'vogal_oral_o_fechada',
        symbol: '/o/',
        name: 'Média-fechada, Posterior',
        examples: ['bolo', 'amor'],
        categoryId: 'vogais',
        subcategoryId: 'orais',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'vogal_oral_u',
        symbol: '/u/',
        name: 'Fechada, Posterior',
        examples: ['rua', 'tudo'],
        categoryId: 'vogais',
        subcategoryId: 'orais',
        locale: 'pt_BR',
      ),

      // --- Vogais Nasais ---
      const Phoneme(
        id: 'vogal_nasal_a',
        symbol: '/ã/',
        name: 'Nasal, Central',
        examples: ['rã', 'campo'],
        categoryId: 'vogais',
        subcategoryId: 'nasais',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'vogal_nasal_e',
        symbol: '/ẽ/',
        name: 'Nasal, Anterior',
        examples: ['vento', 'lembro'],
        categoryId: 'vogais',
        subcategoryId: 'nasais',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'vogal_nasal_i',
        symbol: '/ĩ/',
        name: 'Nasal, Anterior',
        examples: ['limpo', 'sinto'],
        categoryId: 'vogais',
        subcategoryId: 'nasais',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'vogal_nasal_o',
        symbol: '/õ/',
        name: 'Nasal, Posterior',
        examples: ['sombra', 'conto'],
        categoryId: 'vogais',
        subcategoryId: 'nasais',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'vogal_nasal_u',
        symbol: '/ũ/',
        name: 'Nasal, Posterior',
        examples: ['mundo', 'junto'],
        categoryId: 'vogais',
        subcategoryId: 'nasais',
        locale: 'pt_BR',
      ),
      
      // --- Bilabiais Surdas ---
      const Phoneme(
        id: 'bilabial_surda_p',
        symbol: '/p/',
        name: 'Plosiva Bilabial Surda',
        examples: ['pato', 'capa'],
        categoryId: 'bilabiais',
        subcategoryId: 'surdas',
        locale: 'pt_BR',
      ),
      
      // --- Bilabiais Sonoras ---
      const Phoneme(
        id: 'bilabial_sonora_b',
        symbol: '/b/',
        name: 'Plosiva Bilabial Sonora',
        examples: ['bola', 'cabo'],
        categoryId: 'bilabiais',
        subcategoryId: 'sonoras',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'bilabial_sonora_m',
        symbol: '/m/',
        name: 'Nasal Bilabial Sonora',
        examples: ['macaco', 'cama'],
        categoryId: 'bilabiais',
        subcategoryId: 'sonoras',
        locale: 'pt_BR',
      ),

      // --- Alveolares Surdas ---
      const Phoneme(
        id: 'alveolar_surda_t',
        symbol: '/t/',
        name: 'Plosiva Alveolar Surda',
        examples: ['tatu', 'bata'],
        categoryId: 'alveolares',
        subcategoryId: 'surdas',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'alveolar_surda_s',
        symbol: '/s/',
        name: 'Fricativa Alveolar Surda',
        examples: ['sapo', 'passo'],
        categoryId: 'alveolares',
        subcategoryId: 'surdas',
        locale: 'pt_BR',
      ),

      // --- Alveolares Sonoras ---
      const Phoneme(
        id: 'alveolar_sonora_d',
        symbol: '/d/',
        name: 'Plosiva Alveolar Sonora',
        examples: ['dado', 'fada'],
        categoryId: 'alveolares',
        subcategoryId: 'sonoras',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'alveolar_sonora_n',
        symbol: '/n/',
        name: 'Nasal Alveolar Sonora',
        examples: ['navio', 'pano'],
        categoryId: 'alveolares',
        subcategoryId: 'sonoras',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'alveolar_sonora_l',
        symbol: '/l/',
        name: 'Lateral Alveolar Sonora',
        examples: ['lata', 'bala'],
        categoryId: 'alveolares',
        subcategoryId: 'sonoras',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'alveolar_sonora_r_tepe',
        symbol: '/ɾ/',
        name: 'Tepe Alveolar Sonora',
        examples: ['barata', 'caro'],
        categoryId: 'alveolares',
        subcategoryId: 'sonoras',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'alveolar_sonora_z',
        symbol: '/z/',
        name: 'Fricativa Alveolar Sonora',
        examples: ['zebra', 'casa'],
        categoryId: 'alveolares',
        subcategoryId: 'sonoras',
        locale: 'pt_BR',
      ),

      // --- Velares Surdas ---
      const Phoneme(
        id: 'velar_surda_k',
        symbol: '/k/',
        name: 'Plosiva Velar Surda',
        examples: ['casa', 'maca'],
        categoryId: 'velares',
        subcategoryId: 'surdas',
        locale: 'pt_BR',
      ),

      // --- Velares Sonoras ---
      const Phoneme(
        id: 'velar_sonora_g',
        symbol: '/g/',
        name: 'Plosiva Velar Sonora',
        examples: ['gato', 'fogo'],
        categoryId: 'velares',
        subcategoryId: 'sonoras',
        locale: 'pt_BR',
      ),

      // --- Fricativas Surdas ---
      const Phoneme(
        id: 'fricativa_surda_f',
        symbol: '/f/',
        name: 'Fricativa Labiodental Surda',
        examples: ['faca', 'café'],
        categoryId: 'fricativas',
        subcategoryId: 'surdas',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'fricativa_surda_ch',
        symbol: '/ʃ/',
        name: 'Fricativa Pós-Alveolar Surda',
        examples: ['chave', 'bicho'],
        categoryId: 'fricativas',
        subcategoryId: 'surdas',
        locale: 'pt_BR',
      ),

      // --- Fricativas Sonoras ---
      const Phoneme(
        id: 'fricativa_sonora_v',
        symbol: '/v/',
        name: 'Fricativa Labiodental Sonora',
        examples: ['vaca', 'luva'],
        categoryId: 'fricativas',
        subcategoryId: 'sonoras',
        locale: 'pt_BR',
      ),
      const Phoneme(
        id: 'fricativa_sonora_j',
        symbol: '/ʒ/',
        name: 'Fricativa Pós-Alveolar Sonora',
        examples: ['gelo', 'beijo'],
        categoryId: 'fricativas',
        subcategoryId: 'sonoras',
        locale: 'pt_BR',
      ),
    ];

    for (var phoneme in phonemes) {
      final docRef = collection.doc(phoneme.id);
      batch.set(docRef, phoneme.toMap());
    }

    await batch.commit();
  }
}
