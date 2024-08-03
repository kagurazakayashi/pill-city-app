import 'package:flutter/material.dart';
import 'package:pillcity/notifications/notifications_function.dart';
import 'package:pillcity/notifications/notifications_view_controller.dart';

class NotificationsView extends State<NotificationsViewController> {
  final NotificationsFunction _f = NotificationsFunction();

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
    return const Text('通知');
  }
}
