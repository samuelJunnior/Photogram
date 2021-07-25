import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStoreBase with _$ChatStore;

abstract class _ChatStoreBase with Store {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  _ChatStoreBase(
      {required this.firebaseAuth, required this.firebaseFirestore}) {
    firebaseAuth.userChanges().listen(_onChangeUser);
  }

  @observable
  User? myUser;

  @observable
  Stream<QuerySnapshot> searchResult = Stream.empty();

  @observable
  Stream<QuerySnapshot> talksResult = Stream.empty();

  @observable
  FirebaseException? error;

  @action
  _onChangeUser(User? user) {
    this.myUser = user;
  }

  @action
  Future<void> search(String query) async {
    try {
      if (query.isEmpty) {
        return;
      }
      searchResult.drain();
      searchResult = firebaseFirestore
          .collection('user')
          .where('displayName', isGreaterThanOrEqualTo: query)
          .where('displayName',
              isNotEqualTo: firebaseAuth.currentUser!.displayName)
          .orderBy('displayName')
          .snapshots();
    } on FirebaseException catch (e) {
      error = e;
      log('Erro ao salvar edição de perfil', error: e);
    }
  }

  @action
  dynamic createChat(friend) async {
    final chatSendByMe = await firebaseFirestore
        .collection('chat')
        .where('sentBy', isEqualTo: firebaseAuth.currentUser!.uid)
        .where('sentTo', isEqualTo: friend.id)
        .get();

    if (chatSendByMe.size > 0) {
      return chatSendByMe.docs.last.id;
    }

    final chatSendByFriend = await firebaseFirestore
        .collection('chat')
        .where('sentTo', isEqualTo: firebaseAuth.currentUser!.uid)
        .where('sentBy', isEqualTo: friend.id)
        .get();

    if (chatSendByFriend.size > 0) {
      return chatSendByFriend.docs.last.id;
    }

    final newChat = firebaseFirestore.collection('chat').doc();

    newChat.set({
      'owners': [
        firebaseAuth.currentUser!.uid,
        friend.id,
      ],
      'sentBy': firebaseAuth.currentUser!.uid,
      'sentTo': friend.id,
      'nameSentBy': firebaseAuth.currentUser!.displayName,
      'avatarSentBy': firebaseAuth.currentUser!.photoURL ??
          'https://w7.pngwing.com/pngs/924/980/png-transparent-windows-live-messenger-msn-microsoft-messenger-service-return-code-messenger-icon-sphere-avatar-windows-live.png',
      'nameSentTo': friend['displayName'],
      'avatarSentTo': friend['profilePicture'] ??
          'https://w7.pngwing.com/pngs/924/980/png-transparent-windows-live-messenger-msn-microsoft-messenger-service-return-code-messenger-icon-sphere-avatar-windows-live.png',
    });

    return newChat.id;
  }

  @computed
  get talksAll {
    final sentBy = firebaseFirestore
        .collection('chat')
        .where('owners', arrayContainsAny: [firebaseAuth.currentUser!.uid])
        .orderBy('dateLastMessage', descending: true)
        .snapshots();

    return sentBy;
  }

  @action
  Future<void> getTalks(chatId) async {
    try {
      talksResult.drain();
      talksResult = firebaseFirestore
          .collection('chat')
          .doc(chatId)
          .collection('messages')
          .orderBy('dateTime', descending: true)
          .snapshots();
    } on FirebaseException catch (e) {
      error = e;
      log('Erro ao buscar conversas', error: e);
    }
  }

  @action
  Future<void> addMensagem(chatId, friendId, text) async {
    try {
      final chatRef = firebaseFirestore.collection('chat').doc(chatId);

      final dateMessage = DateTime.now();
      chatRef.collection('messages').add({
        'sentBy': firebaseAuth.currentUser!.uid,
        'sentTo': friendId,
        'message': text,
        'dateTime': dateMessage,
      });

      chatRef.set({'dateLastMessage': dateMessage, 'lastMessage': text},
          SetOptions(merge: true));
    } on FirebaseException catch (e) {
      error = e;
      log('Erro ao buscar conversas', error: e);
    }
  }

  @action
  findFriend(friendId) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .doc(friendId)
        .get();
  }
}
