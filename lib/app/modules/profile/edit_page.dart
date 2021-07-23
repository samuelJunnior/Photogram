import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:photogram/app/constants.dart';
import 'package:photogram/app/modules/profile/ChoosePicture_widget.dart';
import 'package:photogram/app/modules/profile/PaddingWidget_widget.dart';
import 'package:photogram/app/modules/profile/user_store.dart';

class EditPage extends StatefulWidget {
  final String title;
  const EditPage({Key? key, this.title = 'EditPage'}) : super(key: key);
  @override
  EditPageState createState() => EditPageState();
}

class EditPageState extends ModularState<EditPage, UserStore> {
  late final TextEditingController _nameController;
  late final FocusNode _nameFocusNode;

  late final TextEditingController _bioController;
  late final FocusNode _bioFocusNode;

  late final ImagePicker _imagePicker;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: store.user?.displayName);
    _nameFocusNode = FocusNode();

    _bioController = TextEditingController(text: store.bio ?? '');
    _bioFocusNode = FocusNode();

    _imagePicker = ImagePicker();

    reaction((_) => store.user, (_) {
      _nameController.text = store.user?.displayName ?? '';
    });

    reaction((_) => store.bio, (_) {
      _bioController.text = store.bio ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Observer(builder: (_) {
            if (store.loading) {
              return Container(
                padding: EdgeInsets.only(right: 12),
                child: Transform.scale(
                  scale: 0.5,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).buttonColor,
                  ),
                ),
              );
            }

            return IconButton(
              icon: Icon(Icons.save_rounded),
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  store
                      .updateProfile(
                          displayName: _nameController.text,
                          bio: _bioController.text)
                      .then((_) => Navigator.of(context).pop());
                }
              },
            );
          })
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 24,
          ),
          CircleAvatar(
            radius: 39,
            child: Observer(builder: (_) {
              if (store.user!.photoURL != null &&
                  store.user!.photoURL!.isNotEmpty) {
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
          TextButton(
            child: Text(
              'Editar foto de perfil.',
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return ChoosePictureWidget(
                        picker: _imagePicker,
                        ctx: ctx,
                        function: store.updateProfilePicture);
                  });
            },
          ),
          _EditFild(
              label: 'Nome: ',
              maxLength: 50,
              focusNode: _nameFocusNode,
              controller: _nameController),
          _EditFild(
            label: 'Bio: ',
            maxLength: 100,
            focusNode: _bioFocusNode,
            controller: _bioController,
          )
        ],
      ),
    );
  }
}

class _EditFild extends StatelessWidget {
  String label;
  int maxLength;
  FocusNode focusNode;
  TextEditingController controller;

  _EditFild(
      {required this.label,
      required this.focusNode,
      required this.controller,
      required this.maxLength});

  @override
  Widget build(BuildContext context) => PaddingWidget(
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
              child: Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Flexible(
              child: TextFormField(
                controller: controller,
                focusNode: focusNode,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                maxLength: maxLength,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      );
}
