import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const WahhidApp());
}

class WahhidApp extends StatelessWidget {
  const WahhidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wahhid Pro',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0F19), // Chuqur qora-ko'k tus
        useMaterial3: true,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
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
    const ShareScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF111827), // Qora-ko'k
              Color(0xFF0B0F19), // Qora
              Color(0xFF020617), // To'q qora
            ],
          ),
        ),
        child: Stack(
          children: [
            // Orqa fondagi kumush va ko'k rangli yorug' bezaklar
            Positioned(
              top: -60,
              right: -30,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(0.15),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: -40,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.1),
                ),
              ),
            ),
            _pages[_currentIndex],
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
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
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B).withOpacity(0.6), // Silver/Gray tusli shisha
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: const Color(0xFF38BDF8), // Yorqin ko'k
                unselectedItemColor: const Color(0xFF94A3B8), // Kumush/Kulrang
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Asosiy'),
                  BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), activeIcon: Icon(Icons.menu_book), label: 'Bilimlar'),
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

// Glass Card (Oq, Silver, Qora uyg'unligidagi shaffof kassa)
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const GlassCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B).withOpacity(0.4), // Kumush/Ko'k shisha
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
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

// 1. Asosiy Sahifa
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Wahhid • Oq & Ko\'k & Yashil', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GlassCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.verified, size: 70, color: Color(0xFF22C55E)), // Yashil rang
                SizedBox(height: 20),
                Text(
                  'Yangi Palitra Muvaffaqiyatli O\'rnatildi!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Qora, Silver (kumush), Oq, Ko\'k va Yashil ranglar uyg\'unligi ilovaga alohida joziba bag\'ishladi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)), // Silver tus
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 2. Bilimlar Sahifasi
class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  final List<Map<String, String>> _bilimlar = const [
    {
      'title': 'Ranglar psixologiyasi',
      'content': 'Ko\'k rang – ishonch va professionallikni, yashil rang – rivojlanish va muvaffaqiyatni bildiradi.'
    },
    {
      'title': 'Silver va Qora dizayn',
      'content': 'Qora va kumush tuslar ilovaning zamonaviy, qat\'iy hamda premium ko\'rinishini ta\'minlaydi.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Bilimlar Bazasi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _bilimlar.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final bilim = _bilimlar[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(bilim['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF38BDF8))), // Ko'k sarlavha
                  const SizedBox(height: 8),
                  Text(bilim['content']!, style: const TextStyle(fontSize: 14, color: Color(0xFFCBD5E1))), // Oq-kumush matn
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 3. Ulashish Sahifasi
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
      appBar: AppBar(
        title: const Text('Ulashish Markazi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Xabar yuborish', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Matn kiriting...',
                  hintStyle: const TextStyle(color: Color(0xFF64748B)),
                  filled: true,
                  fillColor: const Color(0xFF0F172A).withOpacity(0.6), // Qora fon
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Muvaffaqiyatli jo\'natildi!', style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFF22C55E)),
                    );
                    _controller.clear();
                  }
                },
                icon: const Icon(Icons.send, color: Colors.white),
                label: const Text('Jo\'natish', style: TextStyle(fontSize: 16, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB), // Ko'k tugma
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

// 4. So'zlamalar Sahifasi
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('So\'zlamalar', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ListTile(
                leading: Icon(Icons.person, color: Color(0xFF38BDF8)),
                title: Text('Muallif', style: TextStyle(color: Colors.white)),
                subtitle: Text('Muhammadamin Wahhid', style: TextStyle(color: Color(0xFF94A3B8))),
              ),
              Divider(color: Color(0xFF334155)),
              ListTile(
                leading: Icon(Icons.palette, color: Color(0xFF22C55E)), // Yashil ikonka
                title: Text('Ranglar palitrasi', style: TextStyle(color: Colors.white)),
                subtitle: Text('Oq, Silver, Ko\'k, Yashil, Qora', style: TextStyle(color: Color(0xFF94A3B8))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
