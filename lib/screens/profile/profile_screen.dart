import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'notifications_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isNotificationOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 164, 143, 242),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(125),
              ),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 120,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => EditProfileScreen()),
                        );
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.edit, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Puerto Rico',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'youremail@domain.com | +01 234 567 89',
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Edit Profile Info
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EditProfileScreen()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.edit_note_outlined),
                        SizedBox(width: 10),
                        Text('Edit profile information'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Notifications row with navigation and text toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => NotificationsScreen()),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.notifications_none),
                            SizedBox(width: 10),
                            Text('Notifications'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isNotificationOn = !isNotificationOn;
                          });
                        },
                        child: Text(
                          isNotificationOn ? 'ONN' : 'OFF',
                          style: TextStyle(
                            color: isNotificationOn ? Colors.blue : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
