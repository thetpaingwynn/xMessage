import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../services/sms_service.dart';
import '../models/chat.dart';

part 'chat_list_page_store.g.dart';

@injectable
class ChatListPageStore = _ChatListPageStoreBase with _$ChatListPageStore;

abstract class _ChatListPageStoreBase with Store {
  final SmsService _smsService;

  @observable
  List<Chat> chats = List<Chat>();

  _ChatListPageStoreBase(this._smsService);

  Future load() async {
    chats = await _smsService.getChats();
  }
}
