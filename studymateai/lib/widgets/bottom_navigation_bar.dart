import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  CustomBottomNavigationBarState createState() => CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black26,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school), // Changed to 'book' for direct relevance to courses
          label: 'Courses',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.brain, color: Colors.purple, size: 40), // Special feature
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule), // Changed to 'schedule', assuming it covers planning aspects like Portfolio
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.purple,
      onTap: widget.onItemSelected,
      type: BottomNavigationBarType.fixed,
    );
  }
}
