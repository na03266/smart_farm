import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_farm/component/timer_modal_popup.dart';
import 'package:smart_farm/consts/colors.dart';
import 'package:smart_farm/model/timer_table.dart';

class TimerCard extends StatelessWidget {
  final int id;
  final String timerName;
  final bool selectedCard;
  final VoidCallback onTap;

  const TimerCard({
    super.key,
    required this.timerName,
    this.selectedCard = false,
    required this.onTap,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border:
              selectedCard ? Border.all(color: Colors.white, width: 2) : null,
          color: colors[1],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 16, top: 20, bottom: 20),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Text(
                    timerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                IconButton(
                    onPressed: () async {
                      await showCupertinoModalPopup<TimerTable>(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return TimerModalPopup(
                            id: id,
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
