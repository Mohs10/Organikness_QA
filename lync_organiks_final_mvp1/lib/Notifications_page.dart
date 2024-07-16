import 'package:flutter/material.dart';
import 'package:new_project1/Buyer_homepage.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF84C86D),
          title: Center(child: Text("Notifications")), // Center the title
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomePage()),
              // );
            },
          ),
        ),
        body: NotificationsList(),
      ),
    );
  }
}

class NotificationsList extends StatefulWidget {
  @override
  _NotificationsListState createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  String selectedFilter = "All"; // Initially selected filter

  List<Map<String, String>> notifications = [
    {
      "title": "New Message",
      "content": "You have a new message from John Doe.",
      "time": "2 hours ago",
    },
    {
      "title": "Reminder",
      "content": "Don't forget your appointment at 3 PM.",
      "time": "3 hours ago",
    },
    {
      "title": "Discount Offer",
      "content": "Get 20% off on your next purchase.",
      "time": "Yesterday",
    },
    // Add more notifications as needed
  ];

  List<Map<String, String>> getFilteredNotifications() {
    if (selectedFilter == "All") {
      return notifications;
    } else {
      return notifications.where((notification) => notification["title"] == "New").toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter Options
        Container(
          color: Colors.grey[100],
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilterOption(
                title: "All",
                selected: selectedFilter == "All",
                onPressed: () {
                  setState(() {
                    selectedFilter = "All";
                  });
                },
              ),
              FilterOption(
                title: "New",
                selected: selectedFilter == "New",
                onPressed: () {
                  setState(() {
                    selectedFilter = "New";
                  });
                },
              ),
            ],
          ),
        ),

        // Notifications
        Expanded(
          child: ListView(
            children: getFilteredNotifications().map((notification) {
              return NotificationItem(
                title: notification["title"]!,
                content: notification["content"]!,
                time: notification["time"]!,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class FilterOption extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onPressed;

  FilterOption({required this.title, required this.selected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
          color: selected ? Color(0xFF84C86D) : Colors.white,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String content;
  final String time;

  NotificationItem({
    required this.title,
    required this.content,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(content),
      trailing: Text(time),
    );
  }
}
