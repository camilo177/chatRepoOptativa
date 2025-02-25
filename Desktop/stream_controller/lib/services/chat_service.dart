import 'dart:async';

class ChatService {
  final List<String> _messages = [];
  final StreamController<List<String>> _chatController =
      StreamController<List<String>>.broadcast();

  Stream<List<String>> get chatStream => _chatController.stream;

  void addMessage(String message) {
    _messages.add(message);
    _chatController.add(List.from(_messages));
  }

  void dispose() {
    _chatController.close();
  }
}
