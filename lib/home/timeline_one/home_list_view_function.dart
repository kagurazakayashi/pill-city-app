import 'package:flutter/material.dart';
import 'package:pillcity/data_moudle/data_post.dart';
import 'package:pillcity/common/network/network_enum_status.dart';
import 'package:pillcity/home/timeline_one/timeline_block/home_block_view_controller.dart';
import 'package:pillcity/home/timeline_function.dart';

abstract class HomeListViewFunctionDelegate {
  changeProgressVisible(bool isVisible);
  updateData(List<HomeBlockViewController> subViews);
}

class HomeListViewFunction implements TimeLineFunctionDelegate {
  BuildContext? context;
  HomeListViewFunctionDelegate? delegate;
  final TimelineFunction _d = TimelineFunction();
  bool progressVisible = true;

  HomeListViewFunction() {
    _d.delegate = this;
  }

  void setContext(BuildContext uiContext) {
    context ??= uiContext;
    _d.context ??= uiContext;
  }

  void getTimeline() {
    _d.getTimeline();
  }

  @override
  void onCommunicating(NetworkStatus status) {
    int showpgr = _d.showProgressBar(progressVisible, status);
    if (showpgr < 0) return;
    if (delegate != null) {
      delegate!.changeProgressVisible(showpgr == 1);
    }
  }

  @override
  void onUpdate(List<DataPost> posts) {
    List<HomeBlockViewController> subViews = [];
    for (DataPost post in posts) {
      HomeBlockViewController subView = HomeBlockViewController(data: post);
      subViews.add(subView);
    }
    if (delegate != null) {
      delegate!.updateData(subViews);
    }
  }
}
