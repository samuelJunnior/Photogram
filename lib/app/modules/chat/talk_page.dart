import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:photogram/app/modules/chat/chat_store.dart';

class TalkPage extends StatefulWidget {
  final dynamic friend;
  final dynamic chatId;
  TalkPage({required this.friend, required this.chatId});

  @override
  TalkPageState createState() => TalkPageState();
}

class TalkPageState extends ModularState<TalkPage, ChatStore> {
  late final TextEditingController _inputController;
  late final ScrollController _scrollController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
    _scrollController = ScrollController();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    store.getTalks(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friend['displayName']),
      ),
      body: Column(
        children: [talksWidget, inputForm],
      ),
    );
  }

  late Widget inputForm = Container(
    padding: EdgeInsets.only(left: 12, right: 12),
    color: Colors.white,
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _inputController,
            focusNode: _focusNode,
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
          width: 12,
        ),
        Transform.scale(
            scale: 0.8,
            child: FloatingActionButton(
              onPressed: () {
                store
                    .addMensagem(
                        widget.chatId, widget.friend.id, _inputController.text)
                    .then((_) => {
                          _inputController.clear(),
                          _scrollController.animateTo(
                            _scrollController.position.minScrollExtent,
                            duration: Duration(microseconds: 300),
                            curve: Curves.fastOutSlowIn,
                          )
                        });
              },
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
              backgroundColor: Theme.of(context).primaryColorDark,
              elevation: 0,
            )),
      ],
    ),
  );

  late Widget talksWidget = Expanded(
    child: Observer(
      builder: (_) {
        return StreamBuilder(
            stream: store.talksResult,
            builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                log('Erro ao carregar: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData && snapshot.data!.docs.length > 0) {
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  itemBuilder: (_, index) {
                    final message = messages[index];
                    return Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: message['sentTo'] != widget.friend.id
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (message['sentTo'] != widget.friend.id
                                ? Theme.of(context).highlightColor
                                : Theme.of(context).backgroundColor),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(message['message'],
                              style: TextStyle(fontSize: 15)),
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            });
      },
    ),
  );
}
