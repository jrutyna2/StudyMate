import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/recipes_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recipeModel = Provider.of<RecipeModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SwitchListTile(
        title: const Text('Dark Mode'),
        value: recipeModel.isDarkMode,
        onChanged: (bool value) {
          recipeModel.saveThemePreference(value);
        },
      ),
    );
  }
}