import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:photogram/app/constants.dart';
import 'package:photogram/app/modules/login/login_store.dart';

class ForgoutPasswordPage extends StatefulWidget {
  final String title;
  const ForgoutPasswordPage({Key? key, this.title = 'Photogram'})
      : super(key: key);
  @override
  ForgoutPasswordPageState createState() => ForgoutPasswordPageState();
}

class ForgoutPasswordPageState
    extends ModularState<ForgoutPasswordPage, LoginStore> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: ListView(
            children: <Widget>[
              Image.asset('assets/forgout_password.png'),
              Text(
                'Não tem problema!',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(fontSize: 32),
              ),
              Text(
                'Enviremos um e-mail para redefinir sua senha!',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(fontSize: 14),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Qual o seu e-mail?'),
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                child: Observer(builder: (_) {
                  if (store.loading) {
                    return Transform.scale(
                      scale: 0.5,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).buttonColor,
                      ),
                    );
                  }
                  return Text('Redefinir Senha');
                }),
                onPressed: () {
                  store
                      .resetPassword(email: _emailController.text)
                      .then((_) => {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('E-mail enviado!'),
                                    content: Text(
                                        'Siga as instruções para redefinir sua senha.'),
                                    actions: [
                                      ElevatedButton(
                                        child: Text('ok'),
                                        onPressed: () {
                                          Modular.to.pushReplacementNamed(
                                              Constantes.Routes.LOGIN);
                                        },
                                      )
                                    ],
                                  );
                                })
                          });
                },
              )
            ],
          ),
        ));
  }
}
