import 'package:telephony/telephony.dart';

import 'models/chat_message.dart';

extension ChatMessageExtensions on SmsMessage {
  ChatMessage toChatMessage() {
    return ChatMessage()
      ..address = this.address
      ..body = this.body
      ..dateSent = this.dateSent;
  }
}

extension ChatMessagesExtensions on List<SmsMessage> {
  List<ChatMessage> toChatMessages() {
    try {
      final messages = this.map((x) => x.toChatMessage()).toList();
      messages.sort((a, b) => (a.dateSent ?? 0).compareTo((b.dateSent ?? 0)));
      return messages;
    } catch (e) {
      print(e);
    }
    return <ChatMessage>[];
  }
}
