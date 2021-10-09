import 'package:flutter/material.dart';
import 'package:pill_city/common/i18n_function.dart';

import 'home_function.dart';
import 'home_view_controller.dart';

class HomeView extends State<HomeViewController> {
  final HomeFunction _f = HomeFunction();

  @override
  void initState() {
    super.initState();
    _f.getTimeline();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('home')),
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
      body: const Center(child: Text('null')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
        backgroundColor: Colors.red[400],
      ),
    );
  }
}
