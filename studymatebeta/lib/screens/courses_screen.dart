import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../models/course.dart';
import '../models/document.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  CoursesScreenState createState() => CoursesScreenState();
}

class CoursesScreenState extends State<CoursesScreen> {
  List<Course> courses = [];
  Document? _courseOutline;
  final List<Document> _lectures = [];
  final List<Document> _assignments = [];
  final Map<String, List<Document>> _customFolders = {};
  final TextEditingController _courseNameController = TextEditingController();

  Future<Document?> _pickDocument(List<String> allowedExtensions) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result != null) {
      final file = result.files.first;
      return Document(
        title: file.name,
        filePath: file.path!,
        type: _getDocumentType(file.extension!),
      );
    }
    return null;
  }

  DocumentType _getDocumentType(String extension) {
    switch (extension.toLowerCase()) { // Using toLowerCase to ensure the comparison is case-insensitive
      case 'pdf':
        return DocumentType.pdf;
      case 'txt':
        return DocumentType.txt;
      case 'rtf':
        return DocumentType.rtf;
    // Add other cases for additional file types if needed
      default:
      // You can either throw an exception or handle an unsupported file type
        throw 'Unsupported file type: $extension';
    }
  }

  @override
  void dispose() {
    // Dispose the controller when the state is disposed
    _courseNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createCourse,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0, // Adjust the aspect ratio as needed
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.white, // Set the Card's background color to white
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/course_background.png', // Placeholder until you add the image
                    // fit: BoxFit.cover, // Fill entire box
                    fit: BoxFit.fitWidth, // Fit the width of the box
                    alignment: Alignment.topCenter, // Align the image to the top center
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 10.0,
                  child: Text(
                    course.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                // Add more Positioned widgets for other course details if needed.
              ],
            ),
          );
        },
      ),
      // The FAB is removed since we've moved the action to the AppBar.
    );
  }

  // This method is called when the '+' button is pressed
  void _createCourse() async {
    // Reset the state if needed
    _courseOutline = null;
    _lectures.clear();
    _assignments.clear();
    _customFolders.clear();
    // Show a dialog or modal with a form to input course details
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              TextField(
                controller: _courseNameController,
                decoration: const InputDecoration(
                  labelText: 'Course Name',
                ),
              ),
              ElevatedButton(
                child: const Text('Upload Course Outline'),
                onPressed: () async {
                  // Call _pickDocument and await the result
                  final Document? pickedDocument = await _pickDocument(['pdf', 'txt', 'rtf']);
                  if (pickedDocument != null) {
                    // If a document is picked, set it as the course outline
                    setState(() {
                      _courseOutline = pickedDocument;
                    });
                  }
                },
              ),
              // ... Add more UI elements for lectures, assignments, and custom folders
              ElevatedButton(
                child: const Text('Add Lecture Document'),
                onPressed: () async {
                  final Document? pickedDocument = await _pickDocument(['pdf', 'txt', 'rtf']);
                  if (pickedDocument != null) {
                    setState(() {
                      _lectures.add(pickedDocument);
                    });
                  }
                },
              ),
              ElevatedButton(
                child: const Text('Add Assignment Document'),
                onPressed: () async {
                  final Document? pickedDocument = await _pickDocument(['pdf', 'txt', 'rtf']);
                  if (pickedDocument != null) {
                    setState(() {
                      _assignments.add(pickedDocument);
                    });
                  }
                },
              ),
              ElevatedButton(
                child: const Text('Save Course'),
                onPressed: () {
                  if (_courseOutline == null) {
                    // Show an error or a message indicating that the course outline is required
                    return;
                  }
                  // Create the course object
                  final newCourse = Course(
                    name: _courseNameController.text,
                    courseOutline: _courseOutline!,
                    lectures: _lectures,
                    assignments: _assignments,
                    customFolders: _customFolders,
                  );
                  // Add the new course to the list and update the UI
                  setState(() {
                    courses.add(newCourse);
                  });
                  Navigator.pop(context); // Close the modal
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
