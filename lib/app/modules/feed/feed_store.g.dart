// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedStore on _FeedStoreBase, Store {
  Computed<Stream<QuerySnapshot<Object?>>>? _$postsComputed;

  @override
  Stream<QuerySnapshot<Object?>> get posts => (_$postsComputed ??=
          Computed<Stream<QuerySnapshot<Object?>>>(() => super.posts,
              name: '_FeedStoreBase.posts'))
      .value;
  Computed<dynamic>? _$storesComputed;

  @override
  dynamic get stores => (_$storesComputed ??=
          Computed<dynamic>(() => super.stores, name: '_FeedStoreBase.stores'))
      .value;

  final _$userAtom = Atom(name: '_FeedStoreBase.user');

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

  final _$loadingAtom = Atom(name: '_FeedStoreBase.loading');

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

  final _$logoutAsyncAction = AsyncAction('_FeedStoreBase.logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$addStoreAsyncAction = AsyncAction('_FeedStoreBase.addStore');

  @override
  Future<void> addStore(dynamic path) {
    return _$addStoreAsyncAction.run(() => super.addStore(path));
  }

  final _$_FeedStoreBaseActionController =
      ActionController(name: '_FeedStoreBase');

  @override
  dynamic _onChangeUser(User? user) {
    final _$actionInfo = _$_FeedStoreBaseActionController.startAction(
        name: '_FeedStoreBase._onChangeUser');
    try {
      return super._onChangeUser(user);
    } finally {
      _$_FeedStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
loading: ${loading},
posts: ${posts},
stores: ${stores}
    ''';
  }
}
