import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:pillcity/bottom_navigation/bottom_navigation_widget.dart';
import 'package:pillcity/circles/circles_view_controller.dart';
import 'package:pillcity/common/i18n_function/i18n_switch.dart';
import 'package:pillcity/data/global.dart';
import 'package:pillcity/home/home_view_controller.dart';
import 'package:pillcity/notifications/notifications_view_controller.dart';
import 'package:pillcity/profile/profile_view_controller.dart';

class BottomNavigationView extends State<BottomNavigationWidget>
    implements I18nSwitchDelegate {
  int _selectedIndex = 0;
  static const List<String> pageName = ['主页', '圈子', '我的', '通知'];
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = [];
  final I18nSwitch _langSwitch = I18nSwitch();

  BottomNavigationView() {
    _widgetOptions = <Widget>[
      const HomeViewController(),
      const CirclesViewController(),
      const ProfileViewController(),
      const NotificationsViewController(),
    ];
  }

  @override
  void initState() {
    super.initState();
    _langSwitch.delegate = this;
    _langSwitch.loadConfig();
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

  @override
  i18nSwitchDelegateOnChange(String from, String to) {
    setState(() {
      changeLocale(context, to);
      g_language = to;
    });
  }
}
