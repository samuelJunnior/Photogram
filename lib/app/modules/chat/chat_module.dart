import 'package:firebase_auth/firebase_auth.dart';
import 'package:photogram/app/constants.dart';
import 'package:photogram/app/modules/chat/chat_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photogram/app/modules/chat/chat_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'chat_page.dart';
import 'talk_page.dart';

class ChatModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ChatStore(
        firebaseAuth: i.get<FirebaseAuth>(),
        firebaseFirestore: i.get<FirebaseFirestore>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => ChatPage()),
  ];
}
