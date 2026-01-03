import 'package:flutter/material.dart';
import 'ana_sayfa.dart';

class TabEkrani extends StatefulWidget {
  const TabEkrani({Key? key}) : super(key: key);

  @override
  _TabEkraniState createState() => _TabEkraniState();
}

class _TabEkraniState extends State<TabEkrani> {
  int _secilenIndex = 0;

  // Diğer sayfalar boş şimdilik, hepsi AnaSayfa'yı gösterebilir veya boş container olabilir
  final List<Widget> _sayfalar = [
    const AnaSayfa(),
    const Center(child: Text("Keşfet Sayfası")),
    const Center(child: Text("Gelişim Sayfası")),
    const Center(child: Text("Profil Sayfası")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _sayfalar[_secilenIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _secilenIndex,
        selectedItemColor: const Color(0xFF00C9B7),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _secilenIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Keşfet'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Gelişim'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}