import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(value: false, onChanged: (value) {}),
          ),
          ListTile(
            title: const Text('Privacy Settings'),
            onTap: () {
              // Navigate to privacy settings
            },
          ),
          ListTile(
            title: const Text('Notification Settings'),
            onTap: () {
              // Navigate to notification settings
            },
          ),
        ],
      ),
    );
  }
}
