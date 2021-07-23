// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatStore on _ChatStoreBase, Store {
  Computed<Stream<QuerySnapshot<Object?>>>? _$talksComputed;

  @override
  Stream<QuerySnapshot<Object?>> get talks => (_$talksComputed ??=
          Computed<Stream<QuerySnapshot<Object?>>>(() => super.talks,
              name: '_ChatStoreBase.talks'))
      .value;

  final _$myUserAtom = Atom(name: '_ChatStoreBase.myUser');

  @override
  User? get myUser {
    _$myUserAtom.reportRead();
    return super.myUser;
  }

  @override
  set myUser(User? value) {
    _$myUserAtom.reportWrite(value, super.myUser, () {
      super.myUser = value;
    });
  }

  final _$searchResultAtom = Atom(name: '_ChatStoreBase.searchResult');

  @override
  Stream<QuerySnapshot<Object?>> get searchResult {
    _$searchResultAtom.reportRead();
    return super.searchResult;
  }

  @override
  set searchResult(Stream<QuerySnapshot<Object?>> value) {
    _$searchResultAtom.reportWrite(value, super.searchResult, () {
      super.searchResult = value;
    });
  }

  final _$talksResultAtom = Atom(name: '_ChatStoreBase.talksResult');

  @override
  Stream<QuerySnapshot<Object?>> get talksResult {
    _$talksResultAtom.reportRead();
    return super.talksResult;
  }

  @override
  set talksResult(Stream<QuerySnapshot<Object?>> value) {
    _$talksResultAtom.reportWrite(value, super.talksResult, () {
      super.talksResult = value;
    });
  }

  final _$errorAtom = Atom(name: '_ChatStoreBase.error');

  @override
  FirebaseException? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(FirebaseException? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$searchAsyncAction = AsyncAction('_ChatStoreBase.search');

  @override
  Future<void> search(String query) {
    return _$searchAsyncAction.run(() => super.search(query));
  }

  final _$createChatAsyncAction = AsyncAction('_ChatStoreBase.createChat');

  @override
  Future createChat(dynamic friend) {
    return _$createChatAsyncAction.run(() => super.createChat(friend));
  }

  final _$getTalksAsyncAction = AsyncAction('_ChatStoreBase.getTalks');

  @override
  Future<void> getTalks(dynamic chatId) {
    return _$getTalksAsyncAction.run(() => super.getTalks(chatId));
  }

  final _$addMensagemAsyncAction = AsyncAction('_ChatStoreBase.addMensagem');

  @override
  Future<void> addMensagem(dynamic chatId, dynamic friendId, dynamic text) {
    return _$addMensagemAsyncAction
        .run(() => super.addMensagem(chatId, friendId, text));
  }

  final _$findFriendAsyncAction = AsyncAction('_ChatStoreBase.findFriend');

  @override
  Future findFriend(dynamic friendId) {
    return _$findFriendAsyncAction.run(() => super.findFriend(friendId));
  }

  final _$_ChatStoreBaseActionController =
      ActionController(name: '_ChatStoreBase');

  @override
  dynamic _onChangeUser(User? user) {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase._onChangeUser');
    try {
      return super._onChangeUser(user);
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
myUser: ${myUser},
searchResult: ${searchResult},
talksResult: ${talksResult},
error: ${error},
talks: ${talks}
    ''';
  }
}
