import 'package:flutter/material.dart';
import 'package:pill_city/bottom_navigation/bottom_navigation_widget.dart';
import 'package:pill_city/circles/circles_view.dart';
import 'package:pill_city/home/home_view.dart';
import 'package:pill_city/notifications/notifications_view.dart';
import 'package:pill_city/profile/profile_view.dart';

class BottomNavigationView extends State<BottomNavigationWidget> {
  int _selectedIndex = 0;
  static const List<String> pageName = ['主页', '圈子', '我的', '通知'];
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = [];

  BottomNavigationView() {
    _widgetOptions = <Widget>[
      const HomeView(),
      const CirclesView(),
      const ProfileView(),
      const NotificationsView(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: pageName[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.group_work_outlined),
            label: pageName[1],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: pageName[2],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
            label: pageName[3],
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.grey[900],
        unselectedItemColor: Colors.grey[400],
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
