import 'package:sms/sms.dart';
// import 'package:telephony/telephony.dart';

import 'models/chat.dart';
import 'models/chat_message.dart';

extension SSmsMessagesExtensions on List<SmsMessage> {
  List<ChatMessage> toChatMessages() {
    try {
      final messages = this.map((x) => x.toChatMessage()).toList();
      return messages;
    } catch (e) {
      print(e);
    }
    return <ChatMessage>[];
  }
}

extension SmsMessageExtensions on SmsMessage {
  ChatMessage toChatMessage() {
    return ChatMessage()
      ..chatId = this.threadId
      ..address = this.address
      ..body = this.body
      ..isRead = this.isRead
      ..kind = this.kind.toChatMessageKind()
      ..dateSent = this.dateSent;
  }
}

extension SmsMessageKindExtensions on SmsMessageKind {
  ChatMessageKind toChatMessageKind() {
    switch (this) {
      case SmsMessageKind.Sent:
        return ChatMessageKind.Sent;
      case SmsMessageKind.Received:
        return ChatMessageKind.Received;
      case SmsMessageKind.Draft:
        return ChatMessageKind.Draft;
    }
    return null;
  }
}

extension SmsThreadExtensions on SmsThread {
  Chat toChat() {
    return Chat()
      ..chatId = this.threadId
      ..address = this.address
      ..messages = this.messages.toChatMessages();
  }
}
