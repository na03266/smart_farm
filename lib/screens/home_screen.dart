import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/screens/nav_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    ///상단 메뉴바 부분 제외
    return SafeArea(
      child: Scaffold(
        appBar: const _AppBar(),
        body: NavScreen(),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: colors[2],
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Icon(
            Icons.home,
            size: 35,
            color: Colors.white,
          ),
          Text(' Smart Farm', style: textTheme.displayMedium),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
