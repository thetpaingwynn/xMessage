import 'chat_message.dart';

class Chat {
  int chatId;
  String address;
  List<ChatMessage> messages = <ChatMessage>[];

  String get lastMessage => messages.first?.body ?? '';
}
