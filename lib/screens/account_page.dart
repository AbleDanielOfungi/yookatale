import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Accounts'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
