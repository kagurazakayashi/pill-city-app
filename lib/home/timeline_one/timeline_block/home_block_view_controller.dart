import 'package:flutter/material.dart';
import 'package:pill_city/data_moudle/data_post.dart';
import 'package:pill_city/home/timeline_one/timeline_block/home_block_view.dart';

class HomeBlockViewController extends StatefulWidget {
  const HomeBlockViewController({Key? key, required this.data})
      : super(key: key);

  final DataPost data;

  @override
  State<HomeBlockViewController> createState() => HomeBlockView();
}
