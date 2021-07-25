import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photogram/app/constants.dart';
import 'package:photogram/app/modules/feed/feed_store.dart';
import 'package:photogram/app/modules/profile/ChoosePicture_widget.dart';

class FeedPage extends StatefulWidget {
  final String title;
  const FeedPage({Key? key, this.title = 'Photogram'}) : super(key: key);
  @override
  FeedPageState createState() => FeedPageState();
}

class FeedPageState extends ModularState<FeedPage, FeedStore> {
  late final ScrollController _scrollController;
  late final ImagePicker _picker;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            TextButton.icon(
                onPressed: () {
                  showBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return ChoosePictureWidget(
                            picker: _picker,
                            ctx: ctx,
                            function: store.addStore);
                      });
                },
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).buttonColor,
                ),
                label: Text(
                  'Store',
                  style: TextStyle(color: Theme.of(context).buttonColor),
                )),
            TextButton.icon(
                onPressed: () {
                  store.logout().then((_) =>
                      {Modular.to.popAndPushNamed(Constantes.Routes.LOGIN)});
                },
                icon: Icon(Icons.logout, color: Theme.of(context).buttonColor),
                label: Text(
                  'Logoff',
                  style: TextStyle(color: Theme.of(context).buttonColor),
                )),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              child: StreamBuilder(
                stream: store.stores,
                builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                  // if (snapshot.hasError) {
                  //   log('Erro ao carregar store: ${snapshot.error}');
                  //   return Text('Deu erro');
                  // }

                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return Center(child: CircularProgressIndicator());
                  // }

                  if (snapshot.hasData && snapshot.data!.docs.length > 0) {
                    final stores = snapshot.data!.docs;

                    return Container(
                      height: 120,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: stores.length,
                        itemBuilder: (context, index) {
                          final str = stores[index];
                          return Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: EdgeInsets.only(left: 12),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          child: CircleAvatar(
                                            radius: 38,
                                            foregroundImage: NetworkImage(
                                                str['profilePicture']),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(str['owner'])
                                      ],
                                    )
                                  ],
                                ),
                              ));
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
            Expanded(
                child: StreamBuilder(
              stream: store.posts,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  final posts = snapshot.data!.docs;
                  return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return Column(
                          children: [
                            FutureBuilder(
                              future: store.getUser(post['userId']),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  final user = snapshot.data!.data()
                                      as Map<String, dynamic>;
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              user['profilePicture']),
                                        ),
                                        SizedBox(width: 8),
                                        Text(user['displayName'])
                                      ],
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                            SizedBox(height: 8),
                            Image.network(post['url'],
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover),
                            SizedBox(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.favorite_border_rounded),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.chat_bubble_outline_rounded),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.share_outlined),
                                  onPressed: () {},
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.bookmark_border_rounded),
                                  onPressed: () {},
                                ),
                              ],
                            )
                          ],
                        );
                      });
                }
                return Container();
              },
            ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Modular.to
                .navigate(Constantes.Routes.HOME + Constantes.Routes.CHAT);
          },
          tooltip: 'Chat',
          child: Icon(
            Icons.chat,
            color: Theme.of(context).primaryColorLight,
          ),
          backgroundColor: Theme.of(context).primaryColorDark,
        ));
  }
}
