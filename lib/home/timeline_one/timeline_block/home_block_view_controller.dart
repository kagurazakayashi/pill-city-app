import 'package:flutter/material.dart';
import 'package:pillcity/data_moudle/data_post.dart';
import 'package:pillcity/home/timeline_one/timeline_block/home_block_view.dart';

class HomeBlockViewController extends StatefulWidget {
  const HomeBlockViewController({super.key, required this.data});

  final DataPost data;

  @override
  State<HomeBlockViewController> createState() => HomeBlockView();
}
