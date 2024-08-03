import 'package:flutter/material.dart';
import 'package:pillcity/bottom_navigation/bottom_navigation_widget.dart';

class BottomNavigationViewController extends StatelessWidget {
  const BottomNavigationViewController({super.key});
  static const String _title = '';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: BottomNavigationWidget(),
    );
  }
}
