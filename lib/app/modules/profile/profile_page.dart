import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:photogram/app/constants.dart';
import 'package:photogram/app/modules/profile/ChoosePicture_widget.dart';
import 'package:photogram/app/modules/profile/PaddingWidget_widget.dart';
import 'package:photogram/app/modules/profile/user_store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends ModularState<ProfilePage, UserStore> {
  late final ImagePicker _picker;

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Observer(builder: (_) {
            return Text(store.user?.displayName ?? 'Sem nome');
          }),
          actions: [
            Observer(builder: (_) {
              if (store.loading) {
                return Container(
                  child: Center(
                    child: Transform.scale(
                      scale: 0.5,
                      child: CircularProgressIndicator(
                          color: Theme.of(context).buttonColor),
                    ),
                  ),
                );
              }

              return IconButton(
                icon: Icon(Icons.add_box_outlined),
                onPressed: () {
                  showBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return ChoosePictureWidget(
                            picker: _picker,
                            ctx: ctx,
                            function: store.postPicture);
                      });
                },
              );
            })
          ],
        ),
        body: ListView(
          children: <Widget>[
            _UserHeader(store),
            _UserSubHeading(store),
            _UserGalery(store),
          ],
        ));
  }
}

class _UserHeader extends StatelessWidget {
  UserStore store;
  _UserHeader(this.store);

  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 39,
            child: Observer(builder: (_) {
              if (store.user != null && store.user!.photoURL != null) {
                return CircleAvatar(
                  radius: 38,
                  foregroundImage: NetworkImage(store.user!.photoURL!),
                );
              }

              return CircleAvatar(
                radius: 38,
                foregroundImage: AssetImage('assets/avatar_default.png'),
              );
            }),
          ),
          Column(
            children: [
              Text('100', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Publicações')
            ],
          ),
          Column(
            children: [
              Text('200', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Seguidores'),
            ],
          ),
          Column(
            children: [
              Text('300', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Seguindo'),
            ],
          )
        ],
      ),
    );
  }
}

class _UserSubHeading extends StatelessWidget {
  UserStore store;

  _UserSubHeading(this.store);

  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Observer(
            builder: (_) {
              return Text(store.user?.displayName ?? 'Sem nome',
                  style: TextStyle(fontWeight: FontWeight.bold));
            },
          ),
          Observer(
            builder: (_) {
              return Text(store.bio ?? '');
            },
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.edit),
            label: Text('Editar Perfil'),
            onPressed: () {
              Modular.to.pushNamed('.${Constantes.Routes.EDIT_PROFILA}');
            },
          )
        ],
      ),
    );
  }
}

class _UserGalery extends StatelessWidget {
  final UserStore store;
  _UserGalery(this.store);

  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
        child: StreamBuilder(
      stream: store.posts,
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          log('Erro ao carregar post: ${snapshot.error}');
          return Text('Deu erro');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data!.docs.length > 0) {
          final posts = snapshot.data!.docs;
          return GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1,
              shrinkWrap: true,
              children: posts.map((post) {
                final data = post.data() as Map<String, dynamic>;
                return Image.network(data['url'] as String, fit: BoxFit.cover);
              }).toList());
        }

        return Container();
      },
    ));
  }
}
