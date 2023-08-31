import 'package:flutter/material.dart';
import 'package:tukdak/models/notification_model.dart';

class NotifyAlert extends StatelessWidget {
  final List<NotificationModel> notifications;

  NotifyAlert({required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          var notification = notifications[index];

          return Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Dismissible(
              key: Key(notification.title),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                // Handle delete action here
                // You can remove the notification from the list
                // or perform any other necessary action.
                // notifications.removeAt(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFAAC7D7),
                  borderRadius: BorderRadius.circular(25), // Apply the rounded corner to all sides
                ),
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  leading: Icon(notification.icon),
                  title: Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      notification.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(notification.body),
                      ),
                      SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          '${notification.time}',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}




