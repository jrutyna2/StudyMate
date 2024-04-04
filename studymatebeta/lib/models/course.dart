import 'document.dart';

class Course {
  String name;
  Document courseOutline;
  List<Document> lectures;
  List<Document> assignments;
  Map<String, List<Document>> customFolders;

  Course({
    required this.name,
    required this.courseOutline,
    this.lectures = const [],
    this.assignments = const [],
    Map<String, List<Document>>? customFolders,
  }) : customFolders = customFolders ?? {};

  void addLecture(Document lecture) {
    lectures.add(lecture);
  }

  void addAssignment(Document assignment) {
    assignments.add(assignment);
  }

  void addCustomFolder(String folderName) {
    customFolders[folderName] = [];
  }

  void addFileToFolder(String folderName, Document file) {
    final folder = customFolders[folderName];
    if (folder != null) {
      folder.add(file);
    } else {
      // Handle the error or create a new folder
    }
  }
}