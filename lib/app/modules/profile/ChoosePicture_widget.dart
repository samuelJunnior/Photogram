import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photogram/app/modules/profile/user_store.dart';

class ChoosePictureWidget extends StatelessWidget {
  final ImagePicker picker;
  final BuildContext ctx;
  final Function function;

  ChoosePictureWidget(
      {required this.picker, required this.ctx, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: Row(
              children: [
                Icon(Icons.camera_alt_outlined),
                SizedBox(
                  width: 16,
                ),
                Text('Usar Camera')
              ],
            ),
            onTap: () async {
              final picturePatch = await picker.pickImage(
                source: ImageSource.camera,
                imageQuality: 50,
                maxWidth: 1920,
                maxHeight: 1200,
              );

              if (picturePatch != null) {
                function(picturePatch.path);
              }

              Navigator.of(ctx).pop();
            },
          ),
          SizedBox(
            height: 24,
          ),
          InkWell(
            child: Row(
              children: [
                Icon(Icons.photo_library_outlined),
                SizedBox(
                  width: 16,
                ),
                Text('Escolher foto na galeria.')
              ],
            ),
            onTap: () async {
              final picturePatch = await picker.pickImage(
                source: ImageSource.gallery,
                imageQuality: 50,
                maxWidth: 1920,
                maxHeight: 1200,
              );

              if (picturePatch != null) {
                function(picturePatch.path);
              }

              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
