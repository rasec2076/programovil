import 'package:flutter/material.dart';
import 'package:prueba_seminario1/pages/perfil/perfil.dart';
import 'package:prueba_seminario1/pages/principal/principal.dart';
import 'package:prueba_seminario1/pages/Insignias/insignias.dart';

class MiHomePage extends StatefulWidget {
  const MiHomePage({super.key});

  @override
  State<MiHomePage> createState() => _MiHomePageState();
}

class _MiHomePageState extends State<MiHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    Principal(),
    Perfil(),
    InsigniasPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFDABD87),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Niveles', backgroundColor: Color(0xFF2c2c2c)),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'Insignias'),
        ],
      ),
    );
  }
}