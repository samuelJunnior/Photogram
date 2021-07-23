import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  FirebaseStorage firebaseStorage;

  _UserStoreBase(
      {required this.firebaseAuth,
      required this.firebaseFirestore,
      required this.firebaseStorage}) {
    firebaseAuth.userChanges().listen(_onChangeUser);
  }

  @observable
  User? user;

  @observable
  bool loading = false;

  @observable
  String? bio;

  @action
  void _listenUserdoc(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.exists) {
      bio = snapshot.data()?['bio'] as String;
    }
  }

  @action
  _onChangeUser(User? user) {
    this.user = user;

    if (user != null) {
      firebaseFirestore
          .doc('user/${user.uid}')
          .snapshots()
          .listen(_listenUserdoc);
    }
  }

  @action
  Future<void> updateProfile(
      {required String displayName, required String bio}) async {
    if (user == null) {
      return;
    }

    loading = true;

    final url = await firebaseStorage
        .ref('${user!.uid}/profilePicture.jpg')
        .getDownloadURL();

    if (url.isNotEmpty) {
      await firebaseFirestore.doc('user/${user?.uid}').set({
        'displayName': displayName,
        'bio': bio,
        'profilePicture': url,
      });
    } else {
      await firebaseFirestore.doc('user/${user?.uid}').set({
        'displayName': displayName,
        'bio': bio,
        'profilePicture': '',
      });
    }

    await firebaseAuth.currentUser?.updateDisplayName(displayName);

    loading = false;
  }

  @action
  Future<void> updateProfilePicture(String filePath) async {
    loading = true;

    final userRef =
        await firebaseFirestore.collection('user').doc(user!.uid).get();

    final file = File(filePath);
    final task = await firebaseStorage
        .ref('${user!.uid}/profilePicture.jpg')
        .putFile(file);
    final url = await task.ref.getDownloadURL();

    if (userRef.exists) {
      firebaseFirestore
          .collection('user')
          .doc(user!.uid)
          .set({'profilePicture': url}, SetOptions(merge: true));
    } else {
      firebaseFirestore
          .collection('user')
          .doc(user!.uid)
          .set({'profilePicture': url});
    }

    firebaseAuth.currentUser!.updatePhotoURL(url);

    loading = false;
  }

  @computed
  Stream<QuerySnapshot> get posts {
    return firebaseFirestore
        .collection('post')
        .where('userId', isEqualTo: firebaseAuth.currentUser!.uid)
        .orderBy('dateTime', descending: true)
        .snapshots();
  }

  @action
  Future<void> postPicture(String filePath) async {
    loading = true;

    final file = File(filePath);
    final task = await firebaseStorage
        .ref(
            '${user!.uid}/uploads/post_${DateTime.now().millisecondsSinceEpoch}')
        .putFile(file);
    final url = await task.ref.getDownloadURL();

    await firebaseFirestore.collection('post').add({
      'userId': user!.uid,
      'dateTime': DateTime.now(),
      'url': url,
    });

    loading = false;
  }
}
