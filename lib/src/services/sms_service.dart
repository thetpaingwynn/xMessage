import 'package:injectable/injectable.dart';
import 'package:sms/sms.dart';
import 'package:xmessage/src/models/chat_message.dart';

import '../models/chat.dart';
import '../extensions.dart';

@singleton
class SmsService {
  final SmsQuery _query = new SmsQuery();
  final SmsSender _sender = new SmsSender();

  Future<List<Chat>> getChats() async {
    var threads = await _query.getAllThreads;
    return threads.map((x) => x.toChat()).toList();
  }

  Future<Chat> getChat(int chatId) async {
    var threads = await _query.queryThreads([chatId], kinds: [SmsQueryKind.Draft, SmsQueryKind.Inbox, SmsQueryKind.Sent]);
    return threads.length > 0 ? threads.first.toChat() : null;
  }

  Future<List<ChatMessage>> getChatMessages(int chatId) async {
    final messages = await _query.querySms(threadId: chatId, kinds: [SmsQueryKind.Draft, SmsQueryKind.Inbox, SmsQueryKind.Sent]);
    return messages.map((x) => x.toChatMessage()).toList();
  }

  Future<ChatMessage> sendMessage(String address, String text) async {
    final message = await _sender.sendSms(SmsMessage(address, text));
    return message.toChatMessage();
  }
}
