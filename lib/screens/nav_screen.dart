import 'package:flutter/material.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/consts/tabs.dart';
import 'package:smart_farm/screens/dash_board/dash_board_screen.dart';
import 'package:smart_farm/screens/setting_screen/setting_screen.dart';
import 'package:smart_farm/screens/unit_screens/all_unit_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<NavScreen>
    with TickerProviderStateMixin {
  ///탭바 이용을 위한 컨트롤러
  late final TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: TABS.length,
      vsync: this,
    );
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///화면
      body:TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          DashBoardScreen(),
          AllUnitScreen(),
          SettingScreen(),
        ]
      ),

      ///NavBar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: colors[5],
        unselectedItemColor: colors[6],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: colors[1],
        currentIndex: controller.index,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          controller.animateTo(index);
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
      ),
    );
  }
}
