import 'package:flutter/material.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/consts/tabs.dart';
import 'package:smart_farm/screens/dash_board/dash_board_screen.dart';
import 'package:smart_farm/screens/setting_screen/setting_screen.dart';
import 'package:smart_farm/screens/unit_screens/all_unit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ///탭바 이용을 위한 컨트롤러
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: TABS.length,
      vsync: this,
    );

    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ///상단 메뉴바 부분 제외
    return SafeArea(
        child: Scaffold(
      appBar: const _AppBar(),
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            DashBoardScreen(),
            AllUnitScreen(),
            SettingScreen(),
          ]),
      bottomNavigationBar: _BottomNavBar(
        tabController: tabController,
      ),
    ));
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
        Row(
          children: [
            IconButton(
              onPressed: () {
                /// 관리자 모드 비밀번호 입력 모달,
                /// 권한 받을시 조건을 변경,
                /// 세팅화면에서 조건에따라 보여주는 화면을 바꾸도록 세팅
              },
              icon: const Icon(
                Icons.admin_panel_settings_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            const SizedBox(width: 8),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BottomNavBar extends StatefulWidget {
  final TabController tabController;

  const _BottomNavBar({
    super.key,
    required this.tabController,
  });

  @override
  State<_BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<_BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: colors[5],
      unselectedItemColor: colors[6],
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: colors[1],
      currentIndex: widget.tabController.index,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        widget.tabController.animateTo(index);
      },
      items: TABS
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(
                e.icon,
              ),
              label: e.label,
            ),
          )
          .toList(),
    );
  }
}
