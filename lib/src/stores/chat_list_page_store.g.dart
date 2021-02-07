// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatListPageStore on _ChatListPageStoreBase, Store {
  final _$chatsAtom = Atom(name: '_ChatListPageStoreBase.chats');

  @override
  List<Chat> get chats {
    _$chatsAtom.reportRead();
    return super.chats;
  }

  @override
  set chats(List<Chat> value) {
    _$chatsAtom.reportWrite(value, super.chats, () {
      super.chats = value;
    });
  }

  @override
  String toString() {
    return '''
chats: ${chats}
    ''';
  }
}
