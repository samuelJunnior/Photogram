import 'package:flutter_modular/flutter_modular.dart';
import 'package:photogram/app/constants.dart';
import 'chat_page.dart';
import 'talk_page.dart';

class ChatModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => ChatPage()),
  ];
}
