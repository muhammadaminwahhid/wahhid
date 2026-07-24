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
        primarySwatch: Colors.blue,
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

  // Bo'limlar ro'yxati
  final List<Widget> _pages = [
    const HomeScreen(),
    const BlogScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blog',
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
      appBar: AppBar(title: const Text('Wahhid - Asosiy')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Xush kelibsiz!\nBu yerda o\'zingiz to\'plagan eng muhim bilimlar chiqadi.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// 2. Blog Sahifasi (Bilimlar bazasi)
class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mening Bilimlarim (Blog)')),
      body: ListView.builder(
        itemCount: 5, // Namuna uchun 5 ta element
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              title: Text('Bilim sarlavhasi #${index + 1}'),
              subtitle: const Text('Bu yerda to\'plagan bilimingizning qisqacha mazmuni bo\'ladi...'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Kelgusida maqola ichiga kirish funksiyasi yoziladi
              },
            ),
          );
        },
      ),
    );
  }
}

// 3. So'zlamalar Sahifasi
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('So\'zlamalar')),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Tungi rejim'),
            trailing: Switch(value: false, onChanged: null),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Ilova haqida'),
            subtitle: Text('Wahhid v1.0.0'),
          ),
        ],
      ),
    );
  }
}
