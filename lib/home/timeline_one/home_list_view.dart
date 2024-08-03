import 'package:flutter/material.dart';
import 'package:pillcity/home/timeline_one/timeline_block/home_block_view_controller.dart';
import 'package:pillcity/home/timeline_one/home_list_view_controller.dart';
import 'package:pillcity/home/timeline_one/home_list_view_function.dart';

class HomeListView extends State<HomeListViewController>
    implements HomeListViewFunctionDelegate {
  final HomeListViewFunction _f = HomeListViewFunction();
  final LinearProgressIndicator _linearProgressIndicator =
      const LinearProgressIndicator();
  bool _progressVisible = true;
  List<HomeBlockViewController> list = [];

  @override
  void initState() {
    super.initState();
    _f.delegate = this;
    _f.getTimeline();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _f.setContext(context);
    return Stack(
      fit: StackFit.passthrough,
      children: [
        if (list.isNotEmpty)
          ListView.builder(
            // padding: const EdgeInsets.all(16.0),
            itemCount: list.length * 2 - 1,
            itemBuilder: (context, i) {
              if (i.isOdd) {
                return const Divider(
                  thickness: 2,
                );
              }
              final index = i ~/ 2;
              return list[index];
            },
          ),
        if (_progressVisible)
          Align(
            alignment: Alignment.topCenter,
            child: _linearProgressIndicator,
          ),
      ],
    );
  }

  @override
  void changeProgressVisible(bool isVisible) {
    setState(() {
      _progressVisible = isVisible;
      _f.progressVisible = isVisible;
    });
  }

  @override
  void updateData(List<HomeBlockViewController> subViews) {
    setState(() {
      list = subViews;
    });
  }
}
