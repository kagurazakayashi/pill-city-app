import 'package:flutter/material.dart';
import 'package:pill_city/data_moudle/data_post.dart';
import 'package:pill_city/home/timeline_one/timeline_block/home_block_view_controller.dart';

class HomeBlockView extends State<HomeBlockViewController> {
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
    DataPost post = widget.data;
    return Text(post.content);
  }
}
