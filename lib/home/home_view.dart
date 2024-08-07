import 'package:flutter/material.dart';
import 'package:pillcity/common/i18n_function/i18n_function.dart';
import 'package:pillcity/home/home_function.dart';
import 'package:pillcity/home/home_view_controller.dart';
import 'package:pillcity/home/timeline_one/home_list_view_controller.dart';

class HomeView extends State<HomeViewController> {
  final HomeFunction _f = HomeFunction();
  final HomeListViewController _homeListViewController =
      const HomeListViewController();
  // final HomeBlockViewController _homeBlockViewController = const HomeBlockViewController();

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
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('bottomtab.home')),
        backgroundColor: Colors.red[400],
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: _homeListViewController,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red[400],
        child: const Icon(Icons.edit),
      ),
    );
  }
}
