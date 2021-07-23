import 'package:flutter_modular/flutter_modular.dart';
import 'package:photogram/app/constants.dart';
import 'package:photogram/app/modules/chat/chat_module.dart';
import 'package:photogram/app/modules/feed/feed_module.dart';

import '../profile/profile_module.dart';
import '../search/search_module.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage(), children: [
      ModuleRoute(Constantes.Routes.FEED,
          module: FeedModule(), transition: TransitionType.fadeIn),
      ModuleRoute(Constantes.Routes.SEARCH,
          module: SearchModule(), transition: TransitionType.fadeIn),
      ModuleRoute(Constantes.Routes.PROFILLE,
          module: ProfileModule(), transition: TransitionType.fadeIn),
      ModuleRoute(Constantes.Routes.CHAT,
          module: ChatModule(), transition: TransitionType.fadeIn),
    ]),
  ];
}
