// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStoreBase, Store {
  Computed<Stream<QuerySnapshot<Object?>>>? _$postsComputed;

  @override
  Stream<QuerySnapshot<Object?>> get posts => (_$postsComputed ??=
          Computed<Stream<QuerySnapshot<Object?>>>(() => super.posts,
              name: '_UserStoreBase.posts'))
      .value;

  final _$userAtom = Atom(name: '_UserStoreBase.user');

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$loadingAtom = Atom(name: '_UserStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$bioAtom = Atom(name: '_UserStoreBase.bio');

  @override
  String? get bio {
    _$bioAtom.reportRead();
    return super.bio;
  }

  @override
  set bio(String? value) {
    _$bioAtom.reportWrite(value, super.bio, () {
      super.bio = value;
    });
  }

  final _$updateProfileAsyncAction =
      AsyncAction('_UserStoreBase.updateProfile');

  @override
  Future<void> updateProfile(
      {required String displayName, required String bio}) {
    return _$updateProfileAsyncAction
        .run(() => super.updateProfile(displayName: displayName, bio: bio));
  }

  final _$updateProfilePictureAsyncAction =
      AsyncAction('_UserStoreBase.updateProfilePicture');

  @override
  Future<void> updateProfilePicture(String filePath) {
    return _$updateProfilePictureAsyncAction
        .run(() => super.updateProfilePicture(filePath));
  }

  final _$postPictureAsyncAction = AsyncAction('_UserStoreBase.postPicture');

  @override
  Future<void> postPicture(String filePath) {
    return _$postPictureAsyncAction.run(() => super.postPicture(filePath));
  }

  final _$_UserStoreBaseActionController =
      ActionController(name: '_UserStoreBase');

  @override
  void _listenUserdoc(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase._listenUserdoc');
    try {
      return super._listenUserdoc(snapshot);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _onChangeUser(User? user) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase._onChangeUser');
    try {
      return super._onChangeUser(user);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
loading: ${loading},
bio: ${bio},
posts: ${posts}
    ''';
  }
}
