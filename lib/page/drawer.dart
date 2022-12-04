import 'package:flutter/material.dart';
import 'package:don8_flutter/main.dart';
import 'example.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Menambahkan clickable menu
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Route menu ke halaman utama
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'Don8')),
              );
            },
          ),
          ListTile(
            title: const Text('Design System'),
            onTap: () {
              // Route menu ke halaman tambah budget
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ContohPenggunaan()),
              );
            },
          ),
        ],
      ),
    );
  }
}