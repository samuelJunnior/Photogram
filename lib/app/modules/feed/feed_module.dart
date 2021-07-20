import 'package:flutter_modular/flutter_modular.dart';
import 'package:photogram/app/constants.dart';
import 'package:photogram/app/modules/chat/chat_page.dart';
import 'feed_page.dart';
import '../chat/chat_module.dart';
import '../chat/talk_page.dart';

class FeedModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => FeedPage(),
    ),
    ChildRoute(Constantes.Routes.CHAT,
        child: (_, args) => ChatPage(), transition: TransitionType.rightToLeft),
    ChildRoute(Constantes.Routes.TALK,
        child: (_, args) => TalkPage(), transition: TransitionType.rightToLeft),
  ];
}
