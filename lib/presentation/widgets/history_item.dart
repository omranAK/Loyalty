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
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        SizedBox(
          height: height * 0.07,
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).cardColor,
                child: history.up && history.operation == 'transfer' ||
                        history.operation == 'donate points' ||
                        history.operation == 'buy voucher'
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
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  history.operation.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              children: [
                Text(history.otherSideName),
                Text(history.time.toString()),
              ],
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.lightGreen,
                ),
                width: width * 0.2,
                //height: height*0.06,
                child: Center(
                  child: Text(
                    history.ammount.toString(),
                    style:
                        const TextStyle(fontSize: 28, color: AppColors.green),
                  ),
                ),
              ),
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
