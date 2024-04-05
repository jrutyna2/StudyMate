import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_courses_model.dart';
import '../models/course.dart';
import '../services/course_service.dart';
import 'courses_grid_screen.dart';

class StartUpPage extends StatefulWidget {
  const StartUpPage({super.key});

  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _positionAnimation;
  List<Course> _courses = []; //
  CourseService? courseService;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller!);
    _positionAnimation = Tween(begin: const Offset(0, 0.25), end: Offset.zero).animate(_controller!);

    _controller!.forward();

    // Load courses and update favorites after build
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadAndSetFavorites());
    // Correctly load the courses using CourseService from the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final courseService = Provider.of<CourseService>(context, listen: false);
      courseService.loadCourses().then((loadedCourses) {
        if (mounted) {
          setState(() {
            _courses = loadedCourses;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _loadAndSetFavorites() async {
    // Here, we can access the Provider context safely
    final courseService = Provider.of<CourseService>(context, listen: false);
    List<Course> courses = await courseService.loadCourses();
    final favoritesModel = Provider.of<FavoriteCoursesModel>(context, listen: false);
    // Assume FavoriteCoursesModel has a method to set favorites from loaded courses
    favoritesModel.setFavorites(courses.where((course) => course.isFavorite).toList());
  }

  void _onSignIn() {
    _controller!.reverse().then((value) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CoursesGridScreen()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _opacityAnimation!,
        child: SlideTransition(
          position: _positionAnimation!,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Course App',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onSignIn,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // foreground
                  ),
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
