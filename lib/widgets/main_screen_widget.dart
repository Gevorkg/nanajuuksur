import 'package:flutter/material.dart';
import 'package:flutter_ark_test/main/home_screen.dart';
import 'package:flutter_ark_test/main/haircut_man.dart';
import 'package:flutter_ark_test/main/haircut_woman.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 22, bottom:5, right: 120 ),
          child: Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/nanalogot.png',), fit: BoxFit.contain,
          )
          ),),
        ),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          HouseScreen(),
          HaircutMWidget(),
          HaircutWList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Kodu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.man),
            label: 'Mehed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.woman),
            label: 'Naised',
          ),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
