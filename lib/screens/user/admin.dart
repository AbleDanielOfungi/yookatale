import 'package:flutter/material.dart';

import '../popular product/upload/product_upload.dart';


class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) {
            return AddPopularProductScreen();
          }));
        },
        child: Center(
            child: Icon(Icons.add)
        ),
      ),
    );
  }
}
