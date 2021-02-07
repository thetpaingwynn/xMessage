import 'chat_message.dart';

class Chat {
  String title;
  List<ChatMessage> messages;

  Chat(this.title, [this.messages]);

  String get lastMessage => messages.last?.body ?? '';
}
