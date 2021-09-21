import 'package:flutter/material.dart';
import 'package:pill_city/bottom_navigation/bottom_navigation_widget.dart';

class BottomNavigationViewController extends StatelessWidget {
  const BottomNavigationViewController({Key? key}) : super(key: key);
  static const String _title = '';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: BottomNavigationWidget(),
    );
  }
}
