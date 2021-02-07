import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../models/chat.dart';
import '../models/chat_message.dart';
import '../services/sms_service.dart';

part 'chat_page_store.g.dart';

@injectable
class ChatPageStore = _ChatPageStoreBase with _$ChatPageStore;

abstract class _ChatPageStoreBase with Store {
  final SmsService _smsService;

  @observable
  Chat chat = Chat();

  @observable
  List<ChatMessage> messages = <ChatMessage>[];

  @computed
  int get messageCount => messages?.length;

  _ChatPageStoreBase(this._smsService);

  Future load(int chatId) async {
    this.chat = await _smsService.getChat(chatId);
    this.messages = chat.messages;
  }

  Future send(String text) async {
    await _smsService.sendMessage(chat.address, text);
    this.messages = await _smsService.getChatMessages(chat.chatId);
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
