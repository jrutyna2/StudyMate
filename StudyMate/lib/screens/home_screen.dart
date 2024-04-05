import 'package:flutter/material.dart';
import '/widgets/home_drawer.dart';
import '/widgets/bottom_navigation_bar.dart';
import '/widgets/feature_card.dart';
// Add any additional imports for new widgets you create

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add navigation logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Welcome!'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: const HomeDrawer(),
      body: ListView(
        children: const <Widget>[
          // Welcome Header
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Hello! Ready to learn something new today?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Quick Access Buttons/Card Widgets here
          QuickAccessCard(title: 'Join a Course'),
          QuickAccessCard(title: 'My Schedule'),

          StudyTipsCard(), // Add the Study Tips Card
          LearningPrinciplesCard(), // Add the Learning Principles Card
          // Recommended Courses Carousel
          // CourseRecommendationCarousel(),
          // // Progress Tracker
          // ProgressTrackerWidget(),
          // // Community Highlights
          // CommunityHighlightCard(),
          // // Motivational Quote or Tip of the Day
          // QuoteOfTheDayCard(),
          // // Quick Links to Support/FAQ
          // SupportFAQCard(),
          // ... Other widgets or features
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}

// Example Placeholder Widgets
class QuickAccessCard extends StatelessWidget {
  final String title;
  const QuickAccessCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Placeholder for quick access cards
    return Card(
      child: ListTile(
        title: Text(title),
        onTap: () {}, // Implement navigation logic
      ),
    );
  }
}
// Continue creating placeholder widgets or implement actual widgets for the other sections...
class LearningPrinciplesCard extends StatelessWidget {
  const LearningPrinciplesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.school, color: Colors.purple),
        title: Text('Principles of Effective Learning'),
        subtitle: Text('Explore the core principles that can make your study time more productive.'),
        onTap: () {
          // TODO: Implement navigation to Learning Principles details screen
        },
      ),
    );
  }
}

class StudyTipsCard extends StatelessWidget {
  const StudyTipsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.lightbulb_outline, color: Colors.amber),
        title: Text('Daily Study Tip'),
        subtitle: Text('Discover how to improve your learning process.'),
        onTap: () {
          // TODO: Implement navigation to Study Tips details screen
        },
      ),
    );
  }
}
