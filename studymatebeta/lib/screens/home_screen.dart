import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _messages = [];
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, text);
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                hintText: "Send a message",
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0), // Reduced vertical padding
                filled: true,
                // fillColor: Colors.white,
                fillColor: const Color(0xFF4A4A4A), // Dark gray fill color for the text field
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0), // Add space between the text field and the send button
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue, // Send button background color
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send),
              // color: Colors.white,
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyMate AI'),
        backgroundColor: const Color(0xFF2F3136), // Dark header like ChatGPT
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, index) => Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF5865F2).withOpacity(0.1), // Light ChatGPT-like blue background for messages
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners for chat bubbles
                ),
                child: Text(_messages[index]),
              ),
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1.0),
          _buildTextComposer(),
        ],
      ),
      backgroundColor: const Color(0xFF36393F), // Dark background like ChatGPT
    );
  }
}