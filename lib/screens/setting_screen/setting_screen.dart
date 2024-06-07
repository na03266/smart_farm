import 'package:flutter/material.dart';
import 'package:smart_farm/consts/colors.dart';

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
    return Scaffold(
      backgroundColor: colors[2],
      /// 상단 탭 메뉴
      /// 배열로 만들어서 상시로 쓸수있도록 변경
      appBar: TabBar(
        controller: tabController,
        tabs: [
          Text('1'),
          Text('2'),
          Text('3'),
        ],
      ),
      /// 탭에 해당 되는 화면
      body: TabBarView(
        controller: tabController,
        children: [
          /// 컨트롤러, 유닛, 센서 각각 추가화면 어떤 값들을 받아서 갱신이 가능하게 할지
          /// 컨트롤러 :
          /// 유닛 :
          /// 센서 :
          Text('data1'),
          Text('data2'),

          Text('data3'),
          /// 하단의 추가, 변경, 삭제 버튼 누르기
          /// 추가 : 이미 해당번호가 존재하는지, 최대갯수를 초과였는지, 추가 완료
          /// 변경 : 변경 완료 문구
          /// 삭제 : 존재하는지, 삭제 완료
        ],
      ),
    );
  }
}
