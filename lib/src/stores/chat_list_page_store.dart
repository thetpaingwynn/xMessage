import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:telephony/telephony.dart';
import 'package:collection/collection.dart';

import '../models/chat.dart';
import '../extensions.dart';

part 'chat_list_page_store.g.dart';

@injectable
class ChatListPageStore = _ChatListPageStoreBase with _$ChatListPageStore;

abstract class _ChatListPageStoreBase with Store {
  final Telephony telephony = Telephony.instance;

  @observable
  List<Chat> chats = List<Chat>();

  Future load() async {
    final messages = await telephony.getInboxSms();
    chats = groupBy(messages, (x) => x.address).map((k, v) => MapEntry(k, Chat(k, v.toChatMessages()))).values.toList();
  }
}
