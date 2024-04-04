import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class DocumentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Document'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );

            if (result != null) {
              PlatformFile file = result.files.first;

              // Now you can use the file to read its bytes or upload somewhere
              // For example: File file = File(result.files.single.path);

              // Show confirmation or handle the file...
            } else {
              // User canceled the picker
            }
          },
          child: const Text('Upload PDF'),
        ),
      ),
    );
  }
}
