import 'package:flutter/material.dart';
import 'package:xmessage/src/models/chat.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;

  ChatPage({Key key, this.chat});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chat.title),
      ),
      body: Center(),
    );
  }
}
