

import 'package:flutter/material.dart';
import '../account_page.dart';
import '../cartPage.dart';
import '../category_page_dynamic.dart';
import '../homePage.dart';
import '../scannerscreen.dart';

class Dashboard extends StatefulWidget {

  static const  String id='dashboard';

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _selectedIndex = 0;

  List pages =  [
    const HomePage(),
    const CartPage(),
    ScannerScreen(),
    const CategoriesPageDynamic(),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedFontSize: 13,
          unselectedFontSize: 13,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.green.shade600,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items:  [
            BottomNavigationBarItem(
                backgroundColor: Colors.lightGreen,
                icon: const Icon(Icons.home, size: 30,),
                activeIcon: Icon(Icons.home, color: Colors.green[600], size: 30,),
                label: "Home"),
            BottomNavigationBarItem(
                backgroundColor: Colors.lightGreen,
                icon: const Icon(Icons.shopping_cart_outlined, size: 30,),
                activeIcon: Icon(Icons.shopping_cart_outlined, color: Colors.green[600], size: 30,),
                label: "Cart"),
            BottomNavigationBarItem(
                backgroundColor: Colors.lightGreen,
                icon: const Icon(Icons.scanner, size: 30,),
                activeIcon: Icon(Icons.scanner_outlined, color: Colors.green[600], size: 30,),
                label: "Scanner"),
            BottomNavigationBarItem(
                backgroundColor: Colors.lightGreen,
                icon: const Icon(Icons.list, size: 30,),
                activeIcon: Icon(Icons.list, color: Colors.green[600], size: 30,),
                label: "List"),
            BottomNavigationBarItem(
                backgroundColor: Colors.lightGreen,
                icon: const Icon(Icons.person_outline, size: 30,),
                activeIcon: Icon(Icons.person_outline, color: Colors.green[600], size: 30,),
                label: "Profile"),
          ]),
    );
  }
}
