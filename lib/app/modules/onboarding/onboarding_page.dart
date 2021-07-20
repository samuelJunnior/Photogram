import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:photogram/app/constants.dart';
import 'package:photogram/app/modules/onboarding/onboarding_store.dart';

class OnboardingPage extends StatefulWidget {
  final String title;
  const OnboardingPage({Key? key, this.title = 'Photogram'}) : super(key: key);
  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState
    extends ModularState<OnboardingPage, OnboardingStore> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          children: [
            _OnboardingItem(
              image: AssetImage('assets/selfie.png'),
              text: 'Tire uma selfie!',
            ),
            _OnboardingItem(
              image: AssetImage('assets/sharing.png'),
              text: 'Compartilhe com seus amigos!',
            ),
            _OnboardingItem(
              image: AssetImage('assets/post.png'),
              text: 'Faça posts!',
            ),
            _OnboardingItem(
              image: AssetImage('assets/comment.png'),
              text: 'Comente!',
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    child: Text('Cadastre-se'),
                    onPressed: () {
                      store.markOnboardingDone();
                      Modular.to
                          .pushReplacementNamed(Constantes.Routes.REGISTER);
                    },
                  ),
                  TextButton(
                    child: Text('Já tem cadastro?'),
                    onPressed: () {
                      store.markOnboardingDone();
                      Modular.to.pushReplacementNamed(Constantes.Routes.LOGIN);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _OnboardingItem extends StatelessWidget {
  final ImageProvider image;
  final String text;
  final Widget? child;

  _OnboardingItem({required this.image, required this.text, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: MediaQuery.of(context).padding.bottom + 96),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: Image(
            image: image,
            fit: BoxFit.fitWidth,
          )),
          SizedBox(
            height: 32,
          ),
          Flexible(
              child: Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          )),
          child ??
              SizedBox.fromSize(
                size: Size.zero,
              )
        ],
      ),
    );
  }
}
