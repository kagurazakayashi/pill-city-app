import 'package:flutter/material.dart';
import 'package:pill_city/home/timeline_function.dart';
import 'package:pill_city/home/timeline_one/home_list_view_controller.dart';

class HomeListView extends State<HomeListViewController> {
  final TimelineFunction _f = TimelineFunction();
  List list = [1, 2, 32, 4, 5, 6, 78, 9, 12, 25, 652, 51, 5, 21];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: list.length * 2 - 1,
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        final index = i ~/ 2;
        return Text(list[index].toString());
      },
    );
  }
}
