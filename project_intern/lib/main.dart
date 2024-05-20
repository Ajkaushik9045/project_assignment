import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_intern/utils/FruitDisplayScreen.dart';
import 'package:project_intern/utils/inputData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  static const MethodChannel _platform = MethodChannel('fruit_selection');

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      _showFruitSelection();
    }
  }

  Future<void> _showFruitSelection() async {
    try {
      await _platform.invokeMethod('showFruitSelection');
    } catch (e) {
      print('Error invoking platform method: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Center(
          child: _selectedIndex == 0
              ? inputData() // Replace this with your TTS screen widget
              : Fruitdisplayscreen(selectedFruits: [],), // Placeholder for the fruit display
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.volume_up),
              label: 'TTS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Fruits',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
