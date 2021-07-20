import 'package:flutter/material.dart';

class TalkPage extends StatefulWidget {
  final String title;
  const TalkPage({Key? key, this.title = 'TalkPage'}) : super(key: key);
  @override
  TalkPageState createState() => TalkPageState();
}

class TalkPageState extends State<TalkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _Body());
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(child: _TalkList()),
          Align(
            alignment: Alignment.bottomLeft,
            child: _FildMensager(),
          )
        ],
      ),
    );
  }
}

class _TalkList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return Container(
          padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
          child: Align(
            alignment: index % 2 == 0 ? Alignment.topLeft : Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (index % 2 == 0
                    ? Theme.of(context).highlightColor
                    : Theme.of(context).backgroundColor),
              ),
              padding: EdgeInsets.all(16),
              child: Text('Teste Mensagem', style: TextStyle(fontSize: 15)),
            ),
          ),
        );
      },
    );
  }
}

class _FildMensager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              maxLength: 500,
              minLines: 1,
              maxLines: 50,
              decoration: InputDecoration(
                  hintText: "Envie sua mensage...",
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Transform.scale(
            scale: 0.8,
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
              backgroundColor: Theme.of(context).primaryColorDark,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
