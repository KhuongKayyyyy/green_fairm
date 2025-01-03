import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/presentation/view/notification/widget/notification_item.dart';

class NotificationByDaySection extends StatefulWidget {
  const NotificationByDaySection({super.key});

  @override
  State<NotificationByDaySection> createState() =>
      _NotificationByDaySectionState();
}

class _NotificationByDaySectionState extends State<NotificationByDaySection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today, Dec 15",
            style: AppTextStyle.defaultBold(color: AppColors.primaryColor),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: FakeData.fakeNotifications.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(FakeData.fakeNotifications[index].title.toString()),
                onDismissed: (direction) {
                  setState(() {
                    FakeData.fakeNotifications.removeAt(index);
                    // _showDelelteConfirmationDialog(context, index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notification dismissed'),
                    ),
                  );
                },
                direction: DismissDirection.endToStart,
                background: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: NotificationItem(
                  notification: FakeData.fakeNotifications[index],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _showDelelteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Delete Notification"),
          content:
              const Text("Are you sure you want to delete this notification?"),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                setState(() {
                  FakeData.fakeNotifications
                      .removeAt(index); // Delete the notification
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
