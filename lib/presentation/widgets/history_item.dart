// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import '../../constant/imports.dart';

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
          height: height * 0.09,
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).cardColor,
                child: history.up
                    ? const Icon(
                        Icons.arrow_outward_rounded,
                        color: Colors.red,
                      )
                    : Transform.rotate(
                        angle: 180 * math.pi / 180,
                        child: const Icon(
                          Icons.arrow_outward_rounded,
                          color: Color.fromARGB(255, 117, 236, 121),
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
                Text(
                  history.time.toString(),
                  style: const TextStyle(fontSize: 12),
                ),
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
