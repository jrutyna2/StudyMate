class Document {
  String title;
  String filePath;
  DocumentType type;

  Document({
    required this.title,
    required this.filePath,
    required this.type,
  });
}

enum DocumentType {
  pdf,
  txt,
  rtf, // Add any other common file extensions you need
}