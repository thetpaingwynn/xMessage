// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatPageStore on _ChatPageStoreBase, Store {
  Computed<int> _$messageCountComputed;

  @override
  int get messageCount =>
      (_$messageCountComputed ??= Computed<int>(() => super.messageCount,
              name: '_ChatPageStoreBase.messageCount'))
          .value;

  final _$chatAtom = Atom(name: '_ChatPageStoreBase.chat');

  @override
  Chat get chat {
    _$chatAtom.reportRead();
    return super.chat;
  }

  @override
  set chat(Chat value) {
    _$chatAtom.reportWrite(value, super.chat, () {
      super.chat = value;
    });
  }

  final _$messagesAtom = Atom(name: '_ChatPageStoreBase.messages');

  @override
  List<ChatMessage> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(List<ChatMessage> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  @override
  String toString() {
    return '''
chat: ${chat},
messages: ${messages},
messageCount: ${messageCount}
    ''';
  }
}
