import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tukdak/controller/NavController.dart';
import 'package:tukdak/models/notification_model.dart';
import 'package:tukdak/screens/mainScreen.dart';
import '../config/services/property.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NotifyAlert extends StatelessWidget {
  static const String route = '/notify_alert';
  final NavBarController navControll = Get.put(NavBarController());
  final List<NotificationModel> notifications;

  NotifyAlert({required this.notifications});

  List<int> coloredIndices = [0, 2, 4];

  Future<List<NotificationModel>> fetchNotificationsFromServer() async {
    final token = await secureStorage.read(key: 'auth_token');
    final url = Uri.parse('http://18.143.209.45/notification');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      List<dynamic> data = json.decode(response.body);

      List<NotificationModel> serverNotifications = data.map((item) {
        return NotificationModel(
          title: item['title'],
          body: item['description'],
          imageUrl: item['image'],
          time: DateTime.parse(item['createdAt']),
        );
      }).toList();

      return serverNotifications;
    } else {
      print('Failed to load notifications. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load notifications');
    }
  }

  void _navigateToMainScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            navControll.goToTab(0);
            _navigateToMainScreen(context);
          },
        ),
        title: const Text('Notifications', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Container(height: 16),
          Expanded(
            child: FutureBuilder<List<NotificationModel>>(
              future: fetchNotificationsFromServer(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<NotificationModel> serverNotifications = snapshot.data!;
                  List<NotificationModel> combinedNotifications = [...serverNotifications, ...notifications];
                  return ListView.builder(
                    itemCount: combinedNotifications.length,
                    itemBuilder: (context, index) {
                      var notification = combinedNotifications[index];
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
                          // combinedNotifications.removeAt(index);
                        },
                        child: Container(
                          color: coloredIndices.contains(index)
                              ? Color(0xFFF2F2F2)
                              : Colors.white,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(notification.imageUrl),
                            ),
                            title: Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                notification.title,
                                style: TextStyle(
                                  fontWeight: coloredIndices.contains(index)
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: coloredIndices.contains(index)
                                      ? Colors.black
                                      : null,
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
                                      fontWeight: coloredIndices.contains(index)
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: coloredIndices.contains(index)
                                          ? Colors.black
                                          : null,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    '${notification.time}',
                                    style: TextStyle(
                                      color: coloredIndices.contains(index)
                                          ? Colors.black45
                                          : null,
                                      fontSize: 12,
                                      fontWeight: coloredIndices.contains(index)
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
