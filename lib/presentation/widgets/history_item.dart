// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'package:loyalty_system_mobile/data/models/point_history_model.dart';

class HistoryItem extends StatelessWidget {
  final PointHistoryModel history;
  const HistoryItem({
    Key? key,
    required this.history,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.lightGray,
              child: history.up
                  ? const Icon(
                      Icons.arrow_outward_rounded,
                      color: Colors.red,
                    )
                  : Transform.rotate(
                      angle: 180 * math.pi / 180,
                      child: const Icon(
                        Icons.arrow_outward_rounded,
                        color: Colors.green,
                      )),
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  history.operation.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(history.up ? ' to' : ' from'),
                Text(history.otherSideName)
              ],
            ),
            subtitle: Text(history.time.toString()),
            trailing: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.lightGreen,
                  ),
                  width: 80,
                  height: 40,
                  child: Center(
                    child: Text(
                      history.ammount.toString(),
                      style:
                          const TextStyle(fontSize: 28, color: AppColors.green),
                    ),
                  ),
                ),
               const  Text('Points'),
              ],
            ),
          ),
        ),
        const Divider(
          color: AppColors.green,
        )
      ],
    );
  }
}
