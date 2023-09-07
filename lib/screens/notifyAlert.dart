import 'package:flutter/material.dart';
import 'package:tukdak/models/notification_model.dart';

class NotifyAlert extends StatelessWidget {
  final List<NotificationModel> notifications;

  NotifyAlert({required this.notifications});

  // Create a list of indices for notifications that should have a different background color
  List<int> coloredIndices = [0, 2, 4]; // Indices to have a different color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set white background color
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Arrow icon with black color
          onPressed: () {
            // Navigate to the homepage
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        title: Text('Notifications', style: TextStyle(color: Colors.black)), // Set title color to black
      ),
      body: Column(
        children: [
          Container(
            height: 16,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                var notification = notifications[index];

                return Dismissible(
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
                    color: coloredIndices.contains(index) ? Color(0xFFF2F2F2) : Colors.white,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      leading: Icon(notification.icon),
                      title: Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: coloredIndices.contains(index) ? FontWeight.bold : FontWeight.normal,
                            color: coloredIndices.contains(index) ? Colors.black : null,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              notification.body,
                              style: TextStyle(
                                fontWeight: coloredIndices.contains(index) ? FontWeight.bold : FontWeight.normal,
                                color: coloredIndices.contains(index) ? Colors.black : null,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              '${notification.time}',
                              style: TextStyle(
                                color: coloredIndices.contains(index) ? Colors.black45 : null,
                                fontSize: 12,
                                fontWeight: coloredIndices.contains(index) ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}