import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';

part 'feed_store.g.dart';

class FeedStore = _FeedStoreBase with _$FeedStore;

abstract class _FeedStoreBase with Store {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  FirebaseStorage firebaseStorage;

  _FeedStoreBase(
      {required this.firebaseAuth,
      required this.firebaseFirestore,
      required this.firebaseStorage}) {
    firebaseAuth.userChanges().listen(_onChangeUser);
  }

  @observable
  User? user;

  @observable
  bool loading = false;

  @action
  _onChangeUser(User? user) {
    this.user = user;
  }

  @computed
  Stream<QuerySnapshot> get posts {
    return firebaseFirestore
        .collection('post')
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot> getUser(String userId) async {
    return await firebaseFirestore.doc('user/$userId').get();
  }

  @action
  Future<void> logout() async {
    return firebaseAuth.signOut();
  }

  @action
  Future<void> addStore(path) async {
    loading = true;

    final file = File(path);
    final task = await firebaseStorage
        .ref(
            '${user!.uid}/uploads/stores/store_${DateTime.now().millisecondsSinceEpoch}')
        .putFile(file);
    final url = await task.ref.getDownloadURL();

    firebaseFirestore
        .collection('store')
        .doc(DateTime.now().microsecondsSinceEpoch.toString())
        .set({
      'ownerId': user!.uid,
      'owner': user!.displayName,
      'profilePicture': url,
    });

    loading = false;
  }

  @computed
  get stores {
    return firebaseFirestore.collection('store').snapshots();
  }
}
