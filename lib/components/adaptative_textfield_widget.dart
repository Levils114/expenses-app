import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextfieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final void Function(String) onSubmit;

  AdaptativeTextfieldWidget({
    this.label,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CupertinoTextField(
              controller: controller,
              onSubmitted: onSubmit,
              placeholder: label,
              focusNode: focusNode,
              keyboardType: keyboardType,
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            decoration: InputDecoration(labelText: label),
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            onSubmitted: onSubmit,
          ));
  }
}
