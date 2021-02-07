class ChatMessage {
  String address;
  String contact;
  String body;
  DateTime dateSent;
  bool isRead;
  ChatMessageKind kind;
  int chatId;

  bool get isReceived => kind == ChatMessageKind.Received;
}

enum ChatMessageKind {
  Sent,
  Received,
  Draft,
}
