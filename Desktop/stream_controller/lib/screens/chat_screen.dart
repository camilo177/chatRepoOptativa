import 'package:flutter/material.dart';
import '../services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  
  @override
  void dispose() {
    _chatService.dispose();
    super.dispose();
  }
  
  void _sendUserMessage() {
    _chatService.addMessage(
        "User: Hello at ${DateTime.now().toLocal().toIso8601String()}");
  }
  
  void _sendSystemMessage() {
    _chatService.addMessage(
        "System: Message at ${DateTime.now().toLocal().toIso8601String()}");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Real Time"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<String>>(
              stream: _chatService.chatStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(messages[index]),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _sendUserMessage,
                  child: Text("Send User Message"),
                ),
                ElevatedButton(
                  onPressed: _sendSystemMessage,
                  child: Text("Send System Message"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
