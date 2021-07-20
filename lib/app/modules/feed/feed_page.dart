import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:photogram/app/constants.dart';

class FeedPage extends StatefulWidget {
  final String title;
  const FeedPage({Key? key, this.title = 'FeedPage'}) : super(key: key);
  @override
  FeedPageState createState() => FeedPageState();
}

class FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.add_box_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Modular.to.pushNamed(Constantes.Routes.HOME +
                Constantes.Routes.FEED +
                Constantes.Routes.CHAT);
          },
          tooltip: 'Chat',
          child: Icon(
            Icons.chat_bubble_outline_rounded,
            color: Theme.of(context).primaryColorLight,
          ),
          backgroundColor: Theme.of(context).primaryColorDark,
        ));
  }
}
