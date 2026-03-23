// ══════════════════════════════════════════════════
//  MODELS
// ══════════════════════════════════════════════════

class UserModel {
  final String id;
  final String name;
  final String email;
  final String role; // 'user' | 'admin'
  final String avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatar = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
    id: j['id'], name: j['name'], email: j['email'],
    role: j['role'], avatar: j['avatar'] ?? '',
  );
}

class ZikrModel {
  final int id;
  final String text;
  final String source;
  final int count;
  final String category;

  ZikrModel({
    required this.id, required this.text, required this.source,
    required this.count, required this.category,
  });
}

class HisnChapterModel {
  final int id;
  final String title;
  final List<ZikrModel> adhkar;

  HisnChapterModel({required this.id, required this.title, required this.adhkar});
}

// ══════════════════════════════════════════════════
//  FAKE API SERVICE
// ══════════════════════════════════════════════════

class FakeApiService {
  // ── Auth ──────────────────────────────────────
  static Future<UserModel?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final users = _fakeUsers();
    try {
      return users.firstWhere(
        (u) => u.email == email && password == '123456',
      );
    } catch (_) {
      return null;
    }
  }

  static Future<UserModel?> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name, email: email, role: 'user',
    );
  }

  static Future<bool> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  static Future<List<ZikrModel>> getMorningAzkar() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _morningAzkar();
  }

  static Future<List<ZikrModel>> getEveningAzkar() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _eveningAzkar();
  }

  static Future<List<ZikrModel>> getMasbahaList() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _masbahaList();
  }

  static Future<List<HisnChapterModel>> getHisnChapters() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _hisnChapters();
  }

  static Future<Map<String, dynamic>> getDashboardStats() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return {
      'totalUsers': 1248,
      'activeToday': 342,
      'totalSebha': 89430,
      'topZikr': 'سبحان الله وبحمده',
    };
  }


  static List<UserModel> _fakeUsers() => [
    UserModel(id: '1', name: 'الاء عزوم', email: 'admin@test.com', role: 'admin'),
    UserModel(id: '2', name: 'مها مروان',  email: 'user@test.com',  role: 'user'),
  ];

  static List<ZikrModel> _masbahaList() => [
    ZikrModel(id: 1, text: 'استغفر الله الذي لا إله إلا هو الحي القيوم وأتوب إليه',
        source: 'الترمذي', count: 100, category: 'استغفار'),
    ZikrModel(id: 2, text: 'سبحان الله وبحمده\nسبحان الله العظيم',
        source: 'البخاري', count: 100, category: 'تسبيح'),
    ZikrModel(id: 3, text: 'لا إله إلا الله وحده لا شريك له\nله الملك وله الحمد وهو على كل شيء قدير',
        source: 'البخاري', count: 100, category: 'تهليل'),
    ZikrModel(id: 4, text: 'الله أكبر',
        source: 'صحيح مسلم', count: 100, category: 'تكبير'),
    ZikrModel(id: 5, text: 'لا حول ولا قوة إلا بالله',
        source: 'البخاري', count: 100, category: 'حوقلة'),
  ];

  static List<ZikrModel> _morningAzkar() => [
    ZikrModel(id: 1, text: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ',
        source: 'أبو داود', count: 1, category: 'صباح'),
    ZikrModel(id: 2, text: 'اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ',
        source: 'الترمذي', count: 1, category: 'صباح'),
    ZikrModel(id: 3, text: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ', source: 'البخاري', count: 100, category: 'صباح'),
    ZikrModel(id: 4, text: 'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ', source: 'القرآن', count: 3, category: 'صباح'),
    ZikrModel(id: 5, text: 'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ قُلْ هُوَ اللَّهُ أَحَدٌ...',
        source: 'أبو داود', count: 3, category: 'صباح'),
  ];

  static List<ZikrModel> _eveningAzkar() => [
    ZikrModel(id: 1, text: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ',
        source: 'أبو داود', count: 1, category: 'مساء'),
    ZikrModel(id: 2, text: 'اللَّهُمَّ بِكَ أَمْسَيْنَا وَبِكَ أَصْبَحْنَا',
        source: 'الترمذي', count: 1, category: 'مساء'),
    ZikrModel(id: 3, text: 'اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ وَأُشْهِدُ حَمَلَةَ عَرْشِكَ',
        source: 'أبو داود', count: 4, category: 'مساء'),
  ];

  static List<HisnChapterModel> _hisnChapters() => [
    HisnChapterModel(id: 1, title: 'الاستيقاظ من النوم', adhkar: [
      ZikrModel(id: 1, text: 'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
          source: 'البخاري', count: 1, category: 'نوم'),
    ]),
    HisnChapterModel(id: 2, title: 'عند لبس الثوب', adhkar: [
      ZikrModel(id: 1, text: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ خَيْرِهِ وَخَيْرِ مَا هُوَ لَهُ',
          source: 'أبو داود', count: 1, category: 'لبس'),
    ]),
    HisnChapterModel(id: 3, title: 'دخول الخلاء', adhkar: [
      ZikrModel(id: 1, text: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْخُبُثِ وَالْخَبَائِثِ',
          source: 'البخاري', count: 1, category: 'خلاء'),
    ]),
    HisnChapterModel(id: 4, title: 'الخروج من الخلاء', adhkar: [
      ZikrModel(id: 1, text: 'غُفْرَانَكَ', source: 'أبو داود', count: 1, category: 'خلاء'),
    ]),
    HisnChapterModel(id: 5, title: 'الوضوء', adhkar: [
      ZikrModel(id: 1, text: 'بِسْمِ اللَّهِ', source: 'أبو داود', count: 1, category: 'وضوء'),
    ]),
    HisnChapterModel(id: 6, title: 'بعد الوضوء', adhkar: [
      ZikrModel(id: 1,
          text: 'أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
          source: 'مسلم', count: 1, category: 'وضوء'),
    ]),
    HisnChapterModel(id: 7, title: 'الدعاء عند الخروج من البيت', adhkar: [
      ZikrModel(id: 1, text: 'بِسْمِ اللَّهِ، تَوَكَّلْتُ عَلَى اللَّهِ، وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
          source: 'أبو داود', count: 1, category: 'بيت'),
    ]),
    HisnChapterModel(id: 8, title: 'الدعاء عند دخول البيت', adhkar: [
      ZikrModel(id: 1, text: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ خَيْرَ الْمَوْلَجِ وَخَيْرَ الْمَخْرَجِ',
          source: 'أبو داود', count: 1, category: 'بيت'),
    ]),
  ];
}
