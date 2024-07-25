// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import '../../constant/imports.dart';
class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  const NotificationItem({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor,
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
        ),
        height: height * 0.1,
        child: ListTile(
          leading: Transform(
            transform: Matrix4.identity()..translate(0.0, -18.0),
            child: Image.asset(
              'assets/images/logo.png',
              color: Theme.of(context).badgeTheme.backgroundColor,
            ),
          ),
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                notification.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: Column(
            children: [
              Text(notification.body),
            ],
          ),
          trailing: Text(
            DateFormat('yyyy-MM-dd').format(
              notification.created_at,
            ),
          ),
        ),
      ),
    );
  }
}
