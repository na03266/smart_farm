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
  ///나중에 갱신 바뀐 값을 다시 불러오는 로직으로 만들어야함.
  // PageController controller = PageController();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        ///여기에 불러오는 것을 실행하는 부분을 작성
      },
    );
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }

    // controller.dispose();
    super.dispose();
  }

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
            ///누르면 이전 화면으로 이동하기
            print('pressed');
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
