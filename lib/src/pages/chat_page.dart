import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../stores/chat_page_store.dart';
import '../mixins/basic_page_feature.dart';
import '../models/chat_message.dart';

class ChatPage extends StatefulWidget {
  final int chatId;

  ChatPage({Key key, this.chatId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with BasicPageFeature {
  final key = new GlobalKey<ScaffoldState>();
  final _store = GetIt.instance.get<ChatPageStore>();
  final _messageTxtCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    progressCall(() => _store.load(widget.chatId));
  }

  @override
  void dispose() {
    _messageTxtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(_store.chat?.address ?? ''),
      ),
      body: ModalProgressHUD(
        child: RefreshIndicator(
          onRefresh: () => _store.load(widget.chatId),
          child: Scrollbar(
            child: Column(
              children: [
                // _addressBar(context),
                Expanded(
                  child: Observer(builder: (_) {
                    return ListView.builder(
                      reverse: true,
                      itemCount: _store.messageCount,
                      itemBuilder: (context, index) => _messageTile(context, _store.messages[index]),
                    );
                  }),
                ),
                _messageComposer(context),
              ],
            ),
          ),
        ),
        inAsyncCall: inAsyncCall,
      ),
    );
  }

  Widget _addressBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
      padding: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _messageTxtCtrl,
              keyboardType: TextInputType.multiline,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration.collapsed(
                hintText: '',
              ),
            ),
          ),
          SizedBox(
            width: 38,
            height: 38,
            child: FlatButton(
              padding: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Icon(Icons.send),
              onPressed: () async {
                await _store.send(_messageTxtCtrl.text);
                _messageTxtCtrl.clear();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageComposer(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
      padding: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _messageTxtCtrl,
              keyboardType: TextInputType.multiline,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration.collapsed(
                hintText: '',
              ),
            ),
          ),
          SizedBox(
            width: 38,
            height: 38,
            child: FlatButton(
              padding: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Icon(Icons.send),
              onPressed: () async {
                await _store.send(_messageTxtCtrl.text);
                _messageTxtCtrl.clear();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageTile(BuildContext context, ChatMessage message) {
    return Container(
      margin: message.isReceived ? EdgeInsets.only(left: 8, right: 80, top: 8, bottom: 8) : EdgeInsets.only(left: 80, right: 8, top: 8, bottom: 8),
      child: Material(
        elevation: 1,
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: InkWell(
          onDoubleTap: () {
            _store.copyToClipboard(message.body);
            showMessage(key.currentState, 'Copied to clipboard');
          },
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: Text(message.body),
          ),
        ),
      ),
    );
  }
}
