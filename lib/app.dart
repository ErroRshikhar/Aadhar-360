import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/stress_screen.dart';
import 'screens/map_screen.dart';
import 'screens/mitra_ai_screen.dart';
import 'screens/settings_screen.dart';

class AadharApp extends StatefulWidget {
  const AadharApp({super.key});
  @override
  State<AadharApp> createState() => _AadharAppState();
}

class _AadharAppState extends State<AadharApp> {
  int _idx = 0;
  final _pages = [
    const HomeScreen(),
    const StressScreen(),
    const MapScreen(),
    const MitraAiScreen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    // This is the main interface with the Bottom Navigation Bar
    return Scaffold(
      body: _pages[_idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        onTap: (i) => setState(() => _idx = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade900,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: "Stress"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Mitra AI"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
