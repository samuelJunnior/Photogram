import 'package:firebase_auth/firebase_auth.dart';
import 'package:photogram/app/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:photogram/app/constants.dart';
import 'login_page.dart';
import 'forgout_password_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore(i.get<FirebaseAuth>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => LoginPage()),
    ChildRoute(Constantes.Routes.FORGOUT_PASSWORD,
        child: (_, args) => ForgoutPasswordPage(),
        transition: TransitionType.rightToLeftWithFade)
  ];
}
