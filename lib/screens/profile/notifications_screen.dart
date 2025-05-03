import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _generalNotificationEnabled = true;
  bool _soundEnabled = false;
  bool _vibrateEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Notifications', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(92, 110, 248, 1),

        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Common',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10.0),
            _buildSettingsTile(
              title: 'General Notification',
              value: _generalNotificationEnabled,
              onChanged: (newValue) {
                setState(() => _generalNotificationEnabled = newValue);
              },
            ),
            _buildSettingsTile(
              title: 'Sound',
              value: _soundEnabled,
              onChanged: (newValue) {
                setState(() => _soundEnabled = newValue);
              },
            ),
            _buildSettingsTile(
              title: 'Vibrate',
              value: _vibrateEnabled,
              onChanged: (newValue) {
                setState(() => _vibrateEnabled = newValue);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Color.fromRGBO(92, 110, 248, 1),

      ),
    );
  }
}
