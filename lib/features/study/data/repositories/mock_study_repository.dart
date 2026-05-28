import '../../domain/entities/book.dart';
import '../../domain/repositories/study_repository.dart';

class MockStudyRepository implements StudyRepository {
  final List<Book> _books = const [
    Book(
      id: 'jornada_pequeno_som',
      title: 'A Jornada do Pequeno Som',
      description: 'Uma aventura mágica sobre descobrir a própria voz no silêncio da floresta.',
      coverImageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuATBIKvCb6Y5TCRUv32BnosdtM6rehnQR3ANjGHVDpscRvonhvjQ0JzH7h0WuJtGoxqOy0uKdKkipIddcCQd-Ll8k6EIl583NTLYxGu_JCV0P8RxYFT7tF5F24sMY_9CQErFzwU01FMbuVjmWPpc2WFdtapczAV-yFDEjpSNA44_km4N2kZcCpfdDq7aG2ZzQU8YFx7lf6urD5MPslKxRtSZxzGwhybWHRy_rT53WS8xs-8tHgi4Y0nA9QkAGKoOXeiYObJDT0x-6MY',
      coverImageAlt: 'A beautiful moonlit forest pathway with soft glow of lights.',
      isRecommended: true,
      pages: [
        'O Pequeno Som caminhava por entre as árvores gigantes, onde o silêncio era uma música suave que esperava para ser cantada.',
        'Ele subiu no topo da montanha e soprou o vento leve: "Sssss... Lllll..." Cada letra parecia um passarinho voando.',
        'Ao final do dia, o som encontrou seu eco na caverna brilhante: "Olá, amigo! Agora posso cantar alto!" E sorriu feliz.',
      ],
      illustrations: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAFadHALNkkRzI3VrSHk_qXhp-Z2DdAoe_vq9y58O8WD58l7OsBSSniz65JOqbCQ1ehp64-BvHfjcV5nUcIaL4C5QbOO-MS1DHZ_AEfw5dBDMCaVFcd74jK4a_w_P5FtIVmGYF5k-O8-z0FQz9lMefWJKMAkHEMCGCWPQbd52oXB_q10f0TJIhF1O_3l0i2IJckHTRaIdgnblKlZE1-esjhWBKfonymyci55MoXlMoyC4IkE1SGxMaCvmJMbjxE-LMXxBHOGv5vq2MY',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuATBIKvCb6Y5TCRUv32BnosdtM6rehnQR3ANjGHVDpscRvonhvjQ0JzH7h0WuJtGoxqOy0uKdKkipIddcCQd-Ll8k6EIl583NTLYxGu_JCV0P8RxYFT7tF5F24sMY_9CQErFzwU01FMbuVjmWPpc2WFdtapczAV-yFDEjpSNA44_km4N2kZcCpfdDq7aG2ZzQU8YFx7lf6urD5MPslKxRtSZxzGwhybWHRy_rT53WS8xs-8tHgi4Y0nA9QkAGKoOXeiYObJDT0x-6MY',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAFadHALNkkRzI3VrSHk_qXhp-Z2DdAoe_vq9y58O8WD58l7OsBSSniz65JOqbCQ1ehp64-BvHfjcV5nUcIaL4C5QbOO-MS1DHZ_AEfw5dBDMCaVFcd74jK4a_w_P5FtIVmGYF5k-O8-z0FQz9lMefWJKMAkHEMCGCWPQbd52oXB_q10f0TJIhF1O_3l0i2IJckHTRaIdgnblKlZE1-esjhWBKfonymyci55MoXlMoyC4IkE1SGxMaCvmJMbjxE-LMXxBHOGv5vq2MY',
      ],
      illustrationsAlt: [
        'A serene minimalist watercolor illustration of a mystical forest path.',
        'A soft-focus landscape depicting a mountain peak with gentle winds blowing.',
        'A glowing cavern reflecting light with small spark elements.',
      ],
    ),
    Book(
      id: 'arara_azul',
      title: 'A Arara Azul',
      description: 'Acompanhe as aventuras da ararinha nas copas das árvores da Amazônia.',
      coverImageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAhfLQlZsx0IM7JnXTR4WpT0D3zwFouE7zjWT9o1E7qKGA3SyvZPpn1qvdlpwh5bMp9iuLxSCiKyN0Ay7qCbIMAm4P489NH_VOP-5XD150XvRxruGDErxJjqKOZ75xC2kZTBUNOlIu1gEvggwunk8jOMVF43f_mCTi1SFwQcvl0kqTWN-OunSp0L3JzoMbB5bn8dgX58Ek1jbRsxMzZOp3E7pP5_D8_klptTJD6btrxbHK-amI4hiHCnQZPMpErRmiuG2CMgIbND2gH',
      coverImageAlt: 'A minimalist watercolor painting of a bright blue macaw perched on a branch.',
      pages: [
        'A arara azul adora voar alto no céu limpo. Ela bate suas asas coloridas e canta alto: "Ra, re, ri, ro, ru!"',
        'Ela pousa no galho da laranjeira para comer uma fruta doce. "Que delícia de laranja vermelha!", pensa a ararinha.',
        'Junto com suas amigas araras, ela faz uma grande festa na floresta. Todas cantam juntas até o sol ir embora.',
      ],
      illustrations: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAhfLQlZsx0IM7JnXTR4WpT0D3zwFouE7zjWT9o1E7qKGA3SyvZPpn1qvdlpwh5bMp9iuLxSCiKyN0Ay7qCbIMAm4P489NH_VOP-5XD150XvRxruGDErxJjqKOZ75xC2kZTBUNOlIu1gEvggwunk8jOMVF43f_mCTi1SFwQcvl0kqTWN-OunSp0L3JzoMbB5bn8dgX58Ek1jbRsxMzZOp3E7pP5_D8_klptTJD6btrxbHK-amI4hiHCnQZPMpErRmiuG2CMgIbND2gH',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAhfLQlZsx0IM7JnXTR4WpT0D3zwFouE7zjWT9o1E7qKGA3SyvZPpn1qvdlpwh5bMp9iuLxSCiKyN0Ay7qCbIMAm4P489NH_VOP-5XD150XvRxruGDErxJjqKOZ75xC2kZTBUNOlIu1gEvggwunk8jOMVF43f_mCTi1SFwQcvl0kqTWN-OunSp0L3JzoMbB5bn8dgX58Ek1jbRsxMzZOp3E7pP5_D8_klptTJD6btrxbHK-amI4hiHCnQZPMpErRmiuG2CMgIbND2gH',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAhfLQlZsx0IM7JnXTR4WpT0D3zwFouE7zjWT9o1E7qKGA3SyvZPpn1qvdlpwh5bMp9iuLxSCiKyN0Ay7qCbIMAm4P489NH_VOP-5XD150XvRxruGDErxJjqKOZ75xC2kZTBUNOlIu1gEvggwunk8jOMVF43f_mCTi1SFwQcvl0kqTWN-OunSp0L3JzoMbB5bn8dgX58Ek1jbRsxMzZOp3E7pP5_D8_klptTJD6btrxbHK-amI4hiHCnQZPMpErRmiuG2CMgIbND2gH',
      ],
      illustrationsAlt: [
        'A blue macaw flying gracefully against a pastel sky.',
        'The macaw eating oranges on a green branch.',
        'A colorful flock of macaws gathered on tropical trees.',
      ],
    ),
    Book(
      id: 'amigo_baleia',
      title: 'O Amigo Baleia',
      description: 'Mergulhe no fundo do oceano azul e cante com o maior animal do mar.',
      coverImageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDB_zPrMqReTVUH8JrjcnYchmM-bDoiEvf1k34v3JZI1UhvrDDSvXxvZj4jR5LSklnGYqLt3IVt1Tq7FxpEb3rtNoJY1NyAEGZ4ShXCtBAGLDllvNM03-v1X553mFsBh2znJRFvwQiAvT6jEFE_6-SaqFGQy3-F14rAMrvaWToLn7qQa3sLY_gzpVYKV5jn6zEhtBzU8kG2kRrUkOouCjS-Sy5IRZs2SnJFeSvfWCQw1bKn77S_06d_6EaYtJwG1nA870AuR8-Cf2yh',
      coverImageAlt: 'A gentle, large whale swimming in a soft-focus ocean of watercolor bubbles.',
      pages: [
        'O amigo baleia mora no fundo do mar azul. Ele é muito grande e adora brincar com as ondas soltando água: "Splish, splash!"',
        'Ele nada devagar conversando com os peixinhos dourados. Sua voz é um canto calmo e profundo: "Uuuuu... Ooooo..."',
        'Quando a lua brilha no céu, a baleia dorme flutuando na água morna, sonhando com novas viagens pelo oceano.',
      ],
      illustrations: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDB_zPrMqReTVUH8JrjcnYchmM-bDoiEvf1k34v3JZI1UhvrDDSvXxvZj4jR5LSklnGYqLt3IVt1Tq7FxpEb3rtNoJY1NyAEGZ4ShXCtBAGLDllvNM03-v1X553mFsBh2znJRFvwQiAvT6jEFE_6-SaqFGQy3-F14rAMrvaWToLn7qQa3sLY_gzpVYKV5jn6zEhtBzU8kG2kRrUkOouCjS-Sy5IRZs2SnJFeSvfWCQw1bKn77S_06d_6EaYtJwG1nA870AuR8-Cf2yh',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDB_zPrMqReTVUH8JrjcnYchmM-bDoiEvf1k34v3JZI1UhvrDDSvXxvZj4jR5LSklnGYqLt3IVt1Tq7FxpEb3rtNoJY1NyAEGZ4ShXCtBAGLDllvNM03-v1X553mFsBh2znJRFvwQiAvT6jEFE_6-SaqFGQy3-F14rAMrvaWToLn7qQa3sLY_gzpVYKV5jn6zEhtBzU8kG2kRrUkOouCjS-Sy5IRZs2SnJFeSvfWCQw1bKn77S_06d_6EaYtJwG1nA870AuR8-Cf2yh',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDB_zPrMqReTVUH8JrjcnYchmM-bDoiEvf1k34v3JZI1UhvrDDSvXxvZj4jR5LSklnGYqLt3IVt1Tq7FxpEb3rtNoJY1NyAEGZ4ShXCtBAGLDllvNM03-v1X553mFsBh2znJRFvwQiAvT6jEFE_6-SaqFGQy3-F14rAMrvaWToLn7qQa3sLY_gzpVYKV5jn6zEhtBzU8kG2kRrUkOouCjS-Sy5IRZs2SnJFeSvfWCQw1bKn77S_06d_6EaYtJwG1nA870AuR8-Cf2yh',
      ],
      illustrationsAlt: [
        'A large whale blowing water out of its blowhole.',
        'The whale swimming with small tropical fish.',
        'A peaceful moonlit sea with a whale sleeping on the surface.',
      ],
    ),
    Book(
      id: 'coelho_branco',
      title: 'O Coelho Branco',
      description: 'Pule e brinque com o coelhinho comilão enquanto treina sons rápidos.',
      coverImageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDsrE6kBZk9T7GtAe3K5BJWl8zn9VkYCzTEGCeagWnBUIp0LXeAd670F6QpVQRd18w1yPQONXXUvCczPC8sw1mLcCAj_tnSXOmE-l8sOMerQTOnoCBrSVmFyYhcThXVwfB4uQSL8OkWJ_W1wfPnJ7dBhV_jzQYOxYbiwZIzqBZCb73eq4vVzDRToIg3kb8idCKUZDzI6FcFQmJ6hJUQj-8QZc28GtWJ9-FHKjib3R8FGLEXBF2XWq-Q7K_waE_O5Q-vfIVua3VBWNtX',
      coverImageAlt: 'A delicate illustration of a soft white rabbit sitting in a field of pastel wildflowers.',
      pages: [
        'O coelho branco pula rápido pelo gramado verde. Ele mexe o nariz bem depressa: "Fung, fung!" e come uma cenoura crocante.',
        'Ele tem orelhas bem compridas e escuta todos os barulhos da mata: "Tic, tac, toc... Quem está aí?"',
        'O coelhinho corre para sua toca quentinha debaixo da terra e dorme encolhido com sua família feliz.',
      ],
      illustrations: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDsrE6kBZk9T7GtAe3K5BJWl8zn9VkYCzTEGCeagWnBUIp0LXeAd670F6QpVQRd18w1yPQONXXUvCczPC8sw1mLcCAj_tnSXOmE-l8sOMerQTOnoCBrSVmFyYhcThXVwfB4uQSL8OkWJ_W1wfPnJ7dBhV_jzQYOxYbiwZIzqBZCb73eq4vVzDRToIg3kb8idCKUZDzI6FcFQmJ6hJUQj-8QZc28GtWJ9-FHKjib3R8FGLEXBF2XWq-Q7K_waE_O5Q-vfIVua3VBWNtX',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDsrE6kBZk9T7GtAe3K5BJWl8zn9VkYCzTEGCeagWnBUIp0LXeAd670F6QpVQRd18w1yPQONXXUvCczPC8sw1mLcCAj_tnSXOmE-l8sOMerQTOnoCBrSVmFyYhcThXVwfB4uQSL8OkWJ_W1wfPnJ7dBhV_jzQYOxYbiwZIzqBZCb73eq4vVzDRToIg3kb8idCKUZDzI6FcFQmJ6hJUQj-8QZc28GtWJ9-FHKjib3R8FGLEXBF2XWq-Q7K_waE_O5Q-vfIVua3VBWNtX',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDsrE6kBZk9T7GtAe3K5BJWl8zn9VkYCzTEGCeagWnBUIp0LXeAd670F6QpVQRd18w1yPQONXXUvCczPC8sw1mLcCAj_tnSXOmE-l8sOMerQTOnoCBrSVmFyYhcThXVwfB4uQSL8OkWJ_W1wfPnJ7dBhV_jzQYOxYbiwZIzqBZCb73eq4vVzDRToIg3kb8idCKUZDzI6FcFQmJ6hJUQj-8QZc28GtWJ9-FHKjib3R8FGLEXBF2XWq-Q7K_waE_O5Q-vfIVua3VBWNtX',
      ],
      illustrationsAlt: [
        'A fluffy white rabbit chewing on a bright orange carrot.',
        'A rabbit with long ears raised listening attentively.',
        'A cozy family of rabbits sleeping together in their burrow.',
      ],
    ),
  ];

  @override
  Future<List<Book>> getBooks() async {
    // Simulate minor loading delay
    await Future.delayed(const Duration(milliseconds: 200));
    return _books;
  }

  @override
  Future<Book?> getBookById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    for (final book in _books) {
      if (book.id == id) {
        return book;
      }
    }
    return null;
  }
}
