import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:photogram/app/constants.dart';
import 'package:photogram/app/modules/chat/chat_store.dart';
import 'package:photogram/app/modules/chat/talk_page.dart';
import 'package:photogram/app/modules/search/searchFiel_widget.dart';

class ChatPage extends StatefulWidget {
  final String title;
  const ChatPage({Key? key, this.title = 'Conversas'}) : super(key: key);
  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends ModularState<ChatPage, ChatStore> {
  bool _searching = false;
  late FocusNode _focusNode;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      final query = _searchController.text;
      store.search(query);
    });
  }

  late Widget searchingWidget = Observer(
    builder: (_) {
      return StreamBuilder(
        stream: store.searchResult,
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            log('Erro ao carregar: ${snapshot.error}');
            return Text('Deu erro');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData && snapshot.data!.docs.length > 0) {
            if (_searchController.text.length == 0) {
              return Container();
            }
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, index) {
                final user = users[index];
                return GestureDetector(
                  onTap: () {
                    store.createChat(user).then((chatId) => {
                          _searchController.clear(),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TalkPage(
                                chatId: chatId,
                                friend: user,
                              ),
                            ),
                          )
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(user['profilePicture']),
                        ),
                        SizedBox(width: 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user['displayName']),
                            Text(user['bio'])
                          ],
                        )
                      ],
                    ),
                  ),
                );
                ;
              },
            );
          }
          return Container();
        },
      );
    },
  );

  late Widget talksWidget = Observer(builder: (_) {
    return StreamBuilder(
      stream: store.talks,
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          log('Erro ao carregar talks: ${snapshot.error}');
          return Text('Deu erro');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data!.docs.length > 0) {
          final talks = snapshot.data!.docs;
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: talks.length,
            itemBuilder: (_, index) {
              final talk = talks[index];
              return GestureDetector(
                  onTap: () async {
                    final friend = await store.findFriend(
                        talk['sentBy'] == store.myUser!.uid
                            ? talk['sentTo']
                            : talk['sentBy']);

                    if (friend == null) {
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TalkPage(
                          chatId: talk.id,
                          friend: friend,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 28,
                            foregroundImage: NetworkImage(
                                talk['sentBy'] == store.myUser!.uid
                                    ? talk['avatarSentTo']
                                    : talk['avatarSentBy'])),
                        Container(
                          padding: EdgeInsets.only(left: 8),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  talk['sentBy'] == store.myUser!.uid
                                      ? talk['nameSentTo']
                                      : talk['nameSentBy'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(talk['lastMessage'],
                                    style: TextStyle(fontSize: 14))
                              ]),
                        ),
                        SizedBox(
                          width: 120,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(DateFormat('dd/mm/yyyy')
                                  .format(talk['dateLastMessage'].toDate())),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(DateFormat('kk:mm')
                                  .format(talk['dateLastMessage'].toDate())),
                            )
                          ],
                        )
                      ],
                    ),
                  ));
            },
          );
        }

        return Container();
      },
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searching
            ? SearchFielWidget(
                focusNode: _focusNode, controller: _searchController)
            : Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(_searching ? Icons.close : Icons.add),
            onPressed: () {
              setState(() {
                _searching = !_searching;
              });
              _focusNode.requestFocus();
            },
          )
        ],
      ),
      body: _searching
          ? searchingWidget
          : Container(
              padding: EdgeInsets.only(top: 5),
              child: talksWidget,
            ),
    );
  }
}
