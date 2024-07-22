import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/provider/data_provider.dart';
import 'package:smart_farm/screens/unit_screens/component/each_unit_control_modal_popup.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UnitCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool condition;
  final UnitCardColor selectedTheme;
  final VoidCallback onPressed;
  final OnToggle? onToggle;
  final int isAuto;
  final List<int> setChannel;

  const UnitCard({
    super.key,
    required this.label,
    required this.icon,
    required this.condition,
    required this.selectedTheme,
    required this.onPressed,
    required this.onToggle,
    required this.isAuto,
    required this.setChannel,
  });

  @override
  State<UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<UnitCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: widget.selectedTheme.bg,
      ),
      height: 0.5.sh - 50.h, // 화면 높이의 절반에서 50 logical pixels를 뺀 값
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w, top: 8.h),
            child: _CardTop(
              icon: widget.icon,
              isOnTheme: widget.selectedTheme,
              condition: widget.condition,
              onPressed: widget.onPressed,
              label: widget.label,
              setChannels: widget.setChannel,
            ),
          ),
          _CardLabel(label: widget.label, isOnTheme: widget.selectedTheme),
          SizedBox(height: 8.h),
          widget.setChannel.length > 1
              ? _EachControlButton(
            isOnTheme: widget.selectedTheme,
            setChannel: widget.setChannel,
          )
              : SizedBox(height: 50.h),
          _IsAutoButton(
            isOnTheme: widget.selectedTheme,
            isAuto: widget.isAuto,
            onToggle: widget.onToggle,
          ),
        ],
      ),
    );
  }}

class _CardTop extends StatefulWidget {
  final String label;
  final IconData icon;
  final UnitCardColor isOnTheme;
  final bool condition;
  final VoidCallback? onPressed; // 변경된 상태를 상위 위젯으로 전달할 콜백 함수
  final List<int> setChannels;

  const _CardTop({
    super.key,
    required this.icon,
    required this.isOnTheme,
    required this.condition,
    required this.onPressed,
    required this.label,
    required this.setChannels,
  });

  @override
  State<_CardTop> createState() => _CardTopState();
}

class _CardTopState extends State<_CardTop> {
  @override
  Widget build(BuildContext context) {
    int type = GetIt.I<DataProvider>()
        .setupData!
        .setDevice[widget.setChannels[0]]
        .unitType;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          widget.icon,
          size: 48.sp,
          color: widget.isOnTheme.icon,
        ),
        TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: widget.isOnTheme.onOff),
          child: Text(
            type == 1
                ? widget.condition
                ? '열림'
                : '닫힘'
                : widget.condition
                ? '켜짐'
                : '꺼짐',
            style: TextStyle(
              color: widget.isOnTheme.onOffFont,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
        )
      ],
    );
  }}

class _CardLabel extends StatelessWidget {
  final String label;
  final UnitCardColor isOnTheme;

  const _CardLabel({super.key, required this.label, required this.isOnTheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        top: 4.h,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 25.sp,
          fontWeight: FontWeight.w700,
          color: isOnTheme.labelFont,
        ),
      ),
    );
  }}

class _EachControlButton extends StatelessWidget {
  final UnitCardColor isOnTheme;
  final List<int> setChannel;

  const _EachControlButton({
    super.key,
    required this.isOnTheme,
    required this.setChannel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 30.w),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isOnTheme.timeControl,
          ),
          onPressed: () async {
            await showCupertinoModalPopup(
              barrierDismissible: true,
              context: context,
              builder: (_) {
                return EachUnitControlModalPopup(setChannel: setChannel);
              },
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.settings_input_component_outlined,
                color: Colors.white,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                '개별 제어',
                style: TextStyle(
                  color: isOnTheme.timeControlFont,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }}

class _IsAutoButton extends StatelessWidget {
  final UnitCardColor isOnTheme;
  final OnToggle? onToggle;
  final int isAuto;

  const _IsAutoButton({
    super.key,
    required this.isOnTheme,
    required this.onToggle,
    required this.isAuto,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 8.w),
        ToggleSwitch(
          minWidth: 80.w,
          borderColor: const [Colors.black],
          borderWidth: 0.4,
          cornerRadius: 20.r,
          activeBgColors: [
            [isOnTheme.manual],
            [isOnTheme.manual]
          ],
          activeFgColor: Colors.white,
          inactiveBgColor: isOnTheme.auto,
          inactiveFgColor: isOnTheme.autoFont,
          initialLabelIndex: isAuto,
          totalSwitches: 2,
          labels: const ['수동', '자동'],
          radiusStyle: true,
          onToggle: onToggle,
        ),
      ],
    );
  }}
