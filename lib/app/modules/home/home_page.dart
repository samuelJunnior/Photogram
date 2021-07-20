import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:photogram/app/constants.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Photogram"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _onTabChange(_currentIndex);
  }

  void _onTabChange(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Modular.to.navigate(Constantes.Routes.HOME + Constantes.Routes.FEED);
        break;
      case 1:
        Modular.to.navigate(Constantes.Routes.HOME + Constantes.Routes.SEARCH);
        break;
      case 2:
        Modular.to
            .navigate(Constantes.Routes.HOME + Constantes.Routes.PROFILLE);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RouterOutlet(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabChange,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Perfil')
        ],
      ),
    );
  }
}
