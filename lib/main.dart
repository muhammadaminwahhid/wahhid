import 'package:flutter/material.dart';

void main() {
  runApp(const WahhidApp());
}

class WahhidApp extends StatelessWidget {
  const WahhidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wahhid',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
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
    const ShareScreen(), // Yangi qo'shilgan Share bo'limi
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Asosiy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Bilimlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Ulashish',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'So\'zlamalar',
          ),
        ],
      ),
    );
  }
}

// 1. Home Sahifasi
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wahhid - Asosiy Makon')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.rocket_launch, size: 90, color: Colors.deepPurple),
              SizedBox(height: 20),
              Text(
                'Salom, Dasturchi!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Ilovamizga yangi "Ulashish va Qabul qilish" bo\'limi qo\'shildi!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. Blog / Bilimlar Sahifasi
class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  final List<Map<String, String>> _bilimlar = const [
    {
      'title': 'Flutter nima?',
      'content': 'Flutter — bu Google tomonidan yaratilgan, bitta kod bazasi bilan Android, iOS va Web uchun ilovalar yaratish imkonini beruvchi kuchli framework.'
    },
    {
      'title': 'Git va GitHub asoslari',
      'content': 'Git bu versiyalarni boshqarish tizimi, GitHub esa bu kodlarni bulutda ochiq yoki yopiq holda saqlash va jamoa bo\'lib ishlash platformasi.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mening Bilimlar Bazam')),
      body: ListView.builder(
        itemCount: _bilimlar.length,
        itemBuilder: (context, index) {
          final bilim = _bilimlar[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(bilim['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(bilim['content']!, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          );
        },
      ),
    );
  }
}

// 3. Yangi Shere (Ulashish va Qabul qilish) Sahifasi
class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  final TextEditingController _controller = TextEditingController();
  String _receivedData = 'Hozircha ma\'lumot kelib tushmadi...';

  void _sendData() {
    if (_controller.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Muvaffaqiyatli jo\'natildi: "${_controller.text}"')),
      );
      _controller.clear();
    }
  }

  void _receiveData() {
    setState(() {
      _receivedData = 'Salom! Bu tarmoqdagi boshqa qurilmadan kelgan xabar: "Flutter loyihasi zo\'r ishlayapti!"';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ma\'lumot Jo\'natish va Qabul qilish')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ma\'lumot Jo\'natish (Share)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Jo\'natish uchun matn yozing...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: _sendData,
              icon: const Icon(Icons.send),
              label: const Text('Jo\'natish'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const Divider(height: 40, thickness: 2),
            const Text(
              'Ma\'lumot Qabul qilish',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple.shade200),
              ),
              child: Text(
                _receivedData,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: _receiveData,
              icon: const Icon(Icons.download),
              label: const Text('Qabul qilib olishni tekshirish'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
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
      appBar: AppBar(title: const Text('So\'zlamalar')),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.person, color: Colors.deepPurple),
            title: Text('Muallif'),
            subtitle: Text('Muhammadamin Wahhid'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info, color: Colors.deepPurple),
            title: Text('Ilova versiyasi'),
            subtitle: Text('v1.3.0 (Share bo\'limi qo\'shildi)'),
          ),
        ],
      ),
    );
  }
}
