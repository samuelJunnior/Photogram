import 'package:flutter/material.dart';

class SearchFielWidget extends StatelessWidget {
  FocusNode focusNode;
  TextEditingController controller;

  SearchFielWidget({required this.focusNode, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).buttonColor,
          ),
          fillColor: Theme.of(context).buttonColor,
          focusColor: Theme.of(context).buttonColor,
          hoverColor: Theme.of(context).buttonColor),
      cursorColor: Theme.of(context).buttonColor,
      style: TextStyle(color: Theme.of(context).buttonColor),
    );
  }
}
