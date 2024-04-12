import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false); // Add listen: false if you don't want this widget to rebuild when the theme changes.
    bool isDarkMode = themeProvider.getTheme.brightness == Brightness.dark; // Use the getter method here

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListTile(
        title: const Text('Dark Mode'),
        trailing: Switch(
          value: isDarkMode,
          onChanged: (value) {
            themeProvider.toggleTheme(value);
          },
        ),
      ),
    );
  }
}
// class _SettingsScreenState extends State<SettingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//       ),
//       body: ListTile(
//         title: const Text('Dark Mode'),
//         trailing: Switch(
//           value: themeProvider._themeData == ThemeData.dark(),
//           onChanged: (value) {
//             themeProvider.toggleTheme(value);
//           },
//         ),
//       ),
//     );
//   }
// }
