import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/favorite_recipes_model.dart';
import 'models/theme_provider.dart';
import 'screens/start_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData? _themeData; // Make it nullable

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool('dark_theme') ?? false;
    setState(() {
      _themeData = isDark ? ThemeData.dark() : ThemeData.light();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_themeData == null) {
      // Show a loading indicator while the theme is loading
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      // Once the theme is loaded, build the MaterialApp with the theme
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FavoriteRecipesModel()),
          ChangeNotifierProvider(create: (context) => ThemeProvider(_themeData!)),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return MaterialApp(
              title: 'Exercise 13',
              theme: themeProvider.getTheme,
              home: const StartUpPage(),
            );
          },
        ),
      );
    }
  }
}
