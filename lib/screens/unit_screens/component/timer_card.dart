import 'package:flutter/material.dart';
import 'package:smart_farm/consts/colors.dart';


class TimerCard extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;
  final String content;
  final bool selectedCard;
  final VoidCallback onTap;

  const TimerCard({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.content,
    this.selectedCard = false, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: selectedCard ? Border.all(color: Colors.white, width: 2) : null,
          color: colors[1],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 16, top: 20, bottom: 20),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Text(
                    content,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      print('tap');
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
