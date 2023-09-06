import 'package:flutter/material.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Scanner Screen'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
