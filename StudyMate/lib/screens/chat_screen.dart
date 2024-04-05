import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  // List to simulate a chat log
  final List<Map<String, String>> messages = [
    {
      "sender": "AI",
      "text": "Hello! 👋 I'm your friendly chatbot. How can I assist you today?",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Special Features"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          // Chat messages
          ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              bool isSentByAI = message["sender"] == "AI";
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: isSentByAI ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: isSentByAI ? Colors.grey.shade200 : Colors.deepPurple.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message["text"]!,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSentByAI ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // Input field
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  FloatingActionButton(
                    onPressed: () {
                      // Placeholder for send button action
                      print("Message sending functionality will be implemented.");
                    },
                    child: Icon(Icons.send),
                    backgroundColor: Colors.deepPurple,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
