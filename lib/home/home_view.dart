import 'package:flutter/material.dart';
import 'package:pill_city/common/i18n_function/i18n_function.dart';
import 'package:pill_city/common/network/network_enum_status.dart';
import 'package:pill_city/home/home_function.dart';
import 'package:pill_city/home/home_view_controller.dart';
import 'package:pill_city/home/timeline_one/home_list_view_controller.dart';

class HomeView extends State<HomeViewController>
    implements HomeFunctionDelegate {
  final HomeFunction _f = HomeFunction();
  final LinearProgressIndicator _linearProgressIndicator =
      const LinearProgressIndicator();
  final HomeListViewController _homeListViewController =
      const HomeListViewController();
  bool _progressVisible = false;

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
    _f.context ??= context;
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
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          _homeListViewController,
          if (_progressVisible)
            Align(
              alignment: Alignment.topCenter,
              child: _linearProgressIndicator,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
        backgroundColor: Colors.red[400],
      ),
    );
  }

  @override
  void onCommunicating(NetworkStatus status) {
    int showpgr = _f.showProgressBar(_progressVisible, status);
    if (showpgr < 0) return;
    setState(() {
      _progressVisible = (showpgr == 1);
    });
  }
}
