import 'package:flutter/material.dart';
import 'package:loyalty_system_mobile/constant/app_colors.dart';
import 'dart:math' as math;

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.lightGray,
              child: Transform.rotate(
                  angle: 180 * math.pi / 180,
                  child: const Icon(
                    Icons.arrow_outward_rounded,
                    color: Colors.green,
                  )),
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: const Text(
              'Service 1 done by 20,000.00',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            subtitle: const Text('20 SEP 2022'),
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.lightGreen,
              ),
              width: 80,
              height: 45,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '4',
                    style: TextStyle(fontSize: 28, color: AppColors.green),
                  ),
                  Text(
                    'Points',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: AppColors.green,
        )
      ],
    );
  }
}
