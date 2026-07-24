import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const WahhidApp());
}

// Global ThemeNotifier
class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.dark);

  void toggleTheme() {
    value = value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

final themeNotifier = ThemeNotifier();

// SharedPreferences Storage Helper
class LocalStorage {
  static Future<List<Map<String, String>>> getBilimlar() async {
    final prefs = await SharedPreferences.getInstance();
    final titles = prefs.getStringList('titles') ?? [
      'Flutter nima?',
      'Shared Preferences',
      'Sevimlilar tizimi',
      'Qidiruv tizimi (Search)',
    ];
    final contents = prefs.getStringList('contents') ?? [
      'Google tomonidan yaratilgan cross-platform framework.',
      'Ma\'lumotlarni qurilmada kalit-qiymat ko\'rinishida saqlash.',
      'Foydalanuvchiga yoqqan maqolalarni alohida saqlab borish imkoniyati.',
      'Maqolalar orasidan keraklisini tezda topish uchun qidiruv filtri.'
    ];

    List<Map<String, String>> list = [];
    for (int i = 0; i < titles.length; i++) {
      list.add({'title': titles[i], 'content': contents[i]});
    }
    return list;
  }

  static Future<void> addBilim(String title, String content) async {
    final prefs = await SharedPreferences.getInstance();
    final titles = prefs.getStringList('titles') ?? [];
    final contents = prefs.getStringList('contents') ?? [];

    titles.insert(0, title);
    contents.insert(0, content);

    await prefs.setStringList('titles', titles);
    await prefs.setStringList('contents', contents);
  }

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  static Future<void> toggleFavorite(String title) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];

    if (favorites.contains(title)) {
      favorites.remove(title);
    } else {
      favorites.add(title);
    }
    await prefs.setStringList('favorites', favorites);
  }
}

class WahhidApp extends StatelessWidget {
  const WahhidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, child) {
        return MaterialApp(
          title: 'Wahhid Pro Search',
          themeMode: currentTheme,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF1F5F9),
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF0B0F19),
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          home: const MainScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const BlogScreen(),
    const FavoritesScreen(),
    const ShareScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF111827), const Color(0xFF0B0F19), const Color(0xFF020617)]
                : [const Color(0xFFFFFFFF), const Color(0xFFE2E8F0), const Color(0xFFCBD5E1)],
          ),
        ),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.5 : 0.15),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B).withOpacity(0.6) : Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: isDark ? Colors.white.withOpacity(0.15) : Colors.black.withOpacity(0.1)),
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: const Color(0xFF38BDF8),
                unselectedItemColor: isDark ? const Color(0xFF94A3B8) : Colors.grey,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Asosiy'),
                  BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), activeIcon: Icon(Icons.menu_book), label: 'Bilimlar'),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), activeIcon: Icon(Icons.favorite), label: 'Sevimlilar'),
                  BottomNavigationBarItem(icon: Icon(Icons.share_outlined), activeIcon: Icon(Icons.share), label: 'Ulashish'),
                  BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'So\'zlama'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const GlassCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B).withOpacity(0.4) : Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isDark ? Colors.white.withOpacity(0.12) : Colors.black.withOpacity(0.08)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Wahhid • Ultimate Pro', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, elevation: 0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GlassCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.search, size: 70, color: Color(0xFF38BDF8)),
                SizedBox(height: 20),
                Text('Qidiruv tizimi qo\'shildi!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                SizedBox(height: 10),
                Text('Bilimlar bo\'limida endi maqolalarni qidiruv satri orqali tezda topishingiz mumkin.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 2. Bilimlar Sahifasi (Real-time Search bilan)
class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List<Map<String, String>> _allBilimlar = [];
  List<Map<String, String>> _filteredBilimlar = [];
  List<String> _favorites = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_filterSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadData() async {
    final all = await LocalStorage.getBilimlar();
    final favs = await LocalStorage.getFavorites();
    setState(() {
      _allBilimlar = all;
      _filteredBilimlar = all;
      _favorites = favs;
    });
  }

  void _filterSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBilimlar = _allBilimlar.where((bilim) {
        final title = bilim['title']!.toLowerCase();
        final content = bilim['content']!.toLowerCase();
        return title.contains(query) || content.contains(query);
      }).toList();
    });
  }

  void _toggleFav(String title) async {
    await LocalStorage.toggleFavorite(title);
    final favs = await LocalStorage.getFavorites();
    setState(() {
      _favorites = favs;
    });
  }

  void _showAddDialog(BuildContext dialogContext) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: dialogContext,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Yangi Bilim Qo\'shish'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Sarlavha')),
            const SizedBox(height: 10),
            TextField(controller: contentController, decoration: const InputDecoration(labelText: 'Maqola matni')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Bekor qilish')),
          ElevatedButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                await LocalStorage.addBilim(titleController.text, contentController.text);
                _loadData();
                Navigator.pop(ctx);
              }
            },
            child: const Text('Saqlash'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Bilimlar Bazasi & Qidiruv', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, elevation: 0),
      body: Column(
        children: [
          // Qidiruv paneli
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Maqolalardan qidirish...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: _filteredBilimlar.isEmpty
                ? const Center(child: Text('Hech qanday natija topilmadi', style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    itemCount: _filteredBilimlar.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final bilim = _filteredBilimlar[index];
                      final title = bilim['title']!;
                      final isFav = _favorites.contains(title);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: GlassCard(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF38BDF8))),
                                    const SizedBox(height: 8),
                                    Text(bilim['content']!, style: const TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.redAccent : Colors.grey),
                                onPressed: () => _toggleFav(title),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        backgroundColor: const Color(0xFF2563EB),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Qo\'shish', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

// 3. Sevimlilar Sahifasi
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, String>> _favBilimlar = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    final all = await LocalStorage.getBilimlar();
    final favTitles = await LocalStorage.getFavorites();
    setState(() {
      _favBilimlar = all.where((b) => favTitles.contains(b['title'])).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Saqlangan Sevimlilar', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, elevation: 0),
      body: _favBilimlar.isEmpty
          ? const Center(
              child: Text('Hozircha sevimlilar yo\'q. Bilimlar bo\'limidan yurakcha bosing!', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 16)),
            )
          : ListView.builder(
              itemCount: _favBilimlar.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final bilim = _favBilimlar[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(bilim['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                        const SizedBox(height: 8),
                        Text(bilim['content']!, style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// 4. Ulashish Sahifasi
class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Ulashish Markazi', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Xabar yuborish', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Matn kiriting...',
                  filled: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Muvaffaqiyatli jo\'natildi!'), backgroundColor: Color(0xFF22C55E)),
                    );
                    _controller.clear();
                  }
                },
                icon: const Icon(Icons.send, color: Colors.white),
                label: const Text('Jo\'natish', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 5. So'zlamalar Sahifasi
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _downloadBackup(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Backup muvaffaqiyatli yuklab olindi!'),
        backgroundColor: Color(0xFF22C55E),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('So\'zlamalar', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.brightness_6, color: Color(0xFF38BDF8)),
                title: const Text('Tungi / Kunduzgi rejim'),
                trailing: Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (val) {
                    themeNotifier.toggleTheme();
                  },
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.cloud_download, color: Color(0xFF22C55E)),
                title: const Text('Backup yuklab olish'),
                subtitle: const Text('Barcha ma\'lumotlarni zaxiralash'),
                onTap: () => _downloadBackup(context),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.person, color: Colors.purple),
                title: Text('Muallif'),
                subtitle: Text('Muhammadamin Wahhid'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
