import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:photogram/app/constants.dart';

class ChatPage extends StatefulWidget {
  final String title;
  const ChatPage({Key? key, this.title = 'Chats'}) : super(key: key);
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _Body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Talk',
          child: Icon(
            Icons.add,
            color: Theme.of(context).primaryColorLight,
          ),
          backgroundColor: Theme.of(context).primaryColorDark,
        ));
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [_Search(), _ChatList()],
    );
  }
}

class _Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade600,
            size: 20,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.all(8),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade100)),
        ),
      ),
    );
  }
}

class _ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 16),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return ChatListState();
      },
    );
  }
}

class ChatListState extends StatefulWidget {
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatListState> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(Constantes.Routes.HOME +
            Constantes.Routes.FEED +
            Constantes.Routes.TALK);
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 23,
                    child: CircleAvatar(
                      radius: 22,
                      foregroundImage: AssetImage('assets/avatar_default.png'),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fulando da silva',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                      ],
                    )),
                  )
                ],
              ),
            ),
            Text(
              'Today',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: false ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
