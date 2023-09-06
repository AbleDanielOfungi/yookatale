import 'package:flutter/material.dart';

class CategoriesPageDynamic extends StatelessWidget {
  const CategoriesPageDynamic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Categories'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
