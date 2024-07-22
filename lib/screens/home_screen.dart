import 'package:flutter/material.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/consts/tabs.dart';
import 'package:smart_farm/screens/dash_board/dash_board_screen.dart';
import 'package:smart_farm/screens/setting_screen/setting_screen.dart';
import 'package:smart_farm/screens/unit_screens/all_unit_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {

   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ///탭바 이용을 위한 컨트롤러
  late final TabController tabController;

  bool isMaster = false;

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
    return Scaffold(
          appBar: _AppBar(onPressed: onMasterPressed),
          body: TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: tabController,
      children: const [
        DashBoardScreen(),
        AllUnitScreen(),
        SettingScreen(),
      ]),
          bottomNavigationBar: _BottomNavBar(
    tabController: tabController,
          ),
        );
  }
  onMasterPressed () {
    /// 관리자 모드 비밀번호 입력 모달,
    /// 권한 받을시 조건을 변경,
    /// 세팅화면에서 조건에따라 보여주는 화면을 바꾸도록 세팅
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  const _AppBar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: colors[2],
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            Icons.home,
            size: 35.sp,
            color: Colors.white,
          ),
          Text(
            ' Smart Farm',
            style: textTheme.displayMedium?.copyWith(fontSize: 25.sp),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.admin_panel_settings_outlined,
                color: Colors.white,
                size: 35.sp,
              ),
            ),
            SizedBox(width: 8.w),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
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
            size: 24.sp,
          ),
          label: e.label,
        ),
      )
          .toList(),
      selectedFontSize: 12.sp,
      unselectedFontSize: 12.sp,
    );
  }
}