import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:photogram/app/constants.dart';
import 'package:photogram/app/modules/profile/PaddingWidget_widget.dart';
import 'package:photogram/app/modules/profile/user_store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends ModularState<ProfilePage, UserStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) {
          return Text(store.user?.displayName ?? 'Sem nome');
        }),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _userHeader(),
          _UserSubHeading(store),
          _UserGalery(),
        ],
      ),
    );
  }
}

class _userHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 40,
            child: CircleAvatar(
              radius: 38,
              foregroundImage: AssetImage('assets/avatar_default.png'),
            ),
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
          ElevatedButton(
            child: Text('Editar Perfil'),
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
  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
      child: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 1,
        shrinkWrap: true,
        children: [
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
          Image.network(
            'http://lorempixel.com.br/500/400/?${DateTime.now().microsecond}',
          ),
        ],
      ),
    );
  }
}
