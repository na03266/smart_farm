import 'package:flutter/material.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/screens/dash_board/component/custom_progress_indicator.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors[2],
        body: Row(
          children: [
            Expanded(
              child: _Mid(),
              flex: 3,
            ),
            Expanded(
              child: _Right(),
            ),
          ],
        ));
  }
}

/// 온도 0
/// 습도 1
/// 대기압 2
/// 이산화탄소 3
/// 토양 온도
/// 토양 습도
/// 전기 전도도 ec
/// ph 산성도
/// 조도

class _Left extends StatelessWidget {
  const _Left({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _Mid extends StatelessWidget {
  const _Mid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _Right extends StatelessWidget {
  const _Right({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 9,
      itemBuilder: (BuildContext context, int index) {
        return CustomProgressIndicator(index: index);
      },
    );
  }
}
