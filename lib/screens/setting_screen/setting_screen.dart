import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/screens/setting_screen/component/controller_setting_page.dart';
import 'package:smart_farm/screens/setting_screen/component/grid_device_setting_page.dart';
import 'package:smart_farm/screens/setting_screen/component/grid_sensor_setting_page.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24.sp,
      color: Colors.white,
    );
    return Scaffold(
      backgroundColor: colors[9],

      /// 상단 탭 메뉴
      /// 배열로 만들어서 상시로 쓸수있도록 변경
      appBar: TabBar(
        controller: tabController,
        indicatorColor: Colors.white,
        labelColor: colors[4],
        unselectedLabelColor: colors[2],
        tabs: [
          Text('Controller', style: defaultTextStyle,),
          Text('Device', style: defaultTextStyle,),
          Text('Sensor', style: defaultTextStyle,),
        ],
      ),

      /// 탭에 해당 되는 화면
      body: TabBarView(
        controller: tabController,
        children: [

          /// 컨트롤러 :
          /// 유닛 :
          /// 센서 :
          ControllerSettingPage(),

          GridDeviceSettingPage(),

          GridSensorSettingPage(),

          /// 하단의 추가, 변경, 삭제 버튼 누르기
          /// 추가 : 이미 해당번호가 존재하는지, 최대갯수를 초과였는지, 추가 완료
          /// 변경 : 변경 완료 문구
          /// 삭제 : 존재하는지, 삭제 완료
        ],
      ),
    );
  }
}
