import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../stores/chat_list_page_store.dart';
import '../mixins/list_page_feature.dart';
import 'package:xmessage/src/models/chat.dart';

import 'chat_page.dart';

class ChatListPage extends StatefulWidget {
  ChatListPage({Key key}) : super(key: key);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> with ListPageFeature {
  final _store = GetIt.instance.get<ChatListPageStore>();

  @override
  void initState() {
    progressCall(() => _store.load());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('xMessage'),
        ),
        body: Scrollbar(
          child: Observer(builder: (_) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: _store.chats.length,
              separatorBuilder: (_, index) => Divider(height: 1),
              itemBuilder: (_, index) => _chatListTile(_store.chats[index]),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.chat),
          onPressed: () {},
        ),
      ),
      inAsyncCall: inAsyncCall,
    );
  }

  ListTile _chatListTile(Chat chat) {
    return ListTile(
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {},
        child: Container(
          width: 48,
          height: 48,
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          child: CircleAvatar(
            child: Icon(Icons.account_circle, size: 38),
          ),
        ),
      ),
      title: Text(chat.title ?? ''),
      subtitle: Text(chat.lastMessage ?? '', maxLines: 1),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => ChatPage(chat: chat),
            settings: RouteSettings(name: 'chat_list_page/chat_page'),
          ),
        );
      },
    );
  }
}
