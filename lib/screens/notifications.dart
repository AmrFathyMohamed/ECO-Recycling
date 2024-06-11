import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

// Constants and Widgets imports
import '../constants/Theme.dart';
import '../widgets/navbar.dart';
import '../widgets/drawer.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadUserId(); // Load user ID and fetch notifications
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userid'); // Retrieve user ID from SharedPreferences

    if (userId != null && userId.isNotEmpty) {
      _fetchNotifications(userId); // Fetch notifications using retrieved user ID
    } else {
      // Handle case where user ID is not found in SharedPreferences
      print('User ID not found or empty');
    }
  }

  Future<void> _fetchNotifications(String userId) async {
    try {
      // Adjust the URL as per your backend setup
      var url = Uri.parse('http://192.168.1.5/ECO/Eco-skydah/Admin%20Dashboard/FlutterNotifications.php');
      var response = await http.post(url, body: {'userid': userId});

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == 'success') {
          List<dynamic> notificationList = data['notifications'];
          setState(() {
            notifications = notificationList
                .map((json) => NotificationModel.fromJson(json))
                .toList();
          });
        } else {
          // Handle error response
          print('Failed to load notifications: ${data['message']}');
        }
      } else {
        // Handle HTTP error
        print('Failed to load notifications: ${response.statusCode}');
      }
    } catch (e) {
      // Handle other errors
      print('Error loading notifications: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const Navbar(
        title: "Notifications",
        transparent: false,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: const ArgonDrawer(currentPage: "Notifications"),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/recycling-garbage2.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SafeArea(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationItem(notification: notifications[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green, // Example background color
          child: Icon(notification.icon, color: Colors.white),
        ),
        title: Text(
          notification.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(notification.description),
            const SizedBox(height: 5),
            Text(
              notification.time,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        onTap: notification.onPressed,
      ),
    );
  }
}
class NotificationModel {
  final String title;
  final String description;
  final IconData icon;
  final String time;
  final VoidCallback onPressed;

  NotificationModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.time,
    required this.onPressed,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['textnotfication'], // Corrected field name based on database schema
      description: json['textnotfication'], // Replace with actual description
      icon: Icons.notifications, // Example icon, replace as needed
      time: json['created_at'],
      onPressed: () {
        // Handle onPressed action as needed
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Notifications(),
  ));
}
