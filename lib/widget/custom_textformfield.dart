// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  TextEditingController? controller;
  String? formNama;
  VoidCallback? onTap;
  bool readOnly;
  String? hint;

  CustomTextFormField(
      {super.key,
      this.controller,
      this.formNama,
      this.hint,
      this.readOnly = false,
      this.onTap});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      controller: widget.controller,
      decoration: InputDecoration(
          hintText: widget.hint,
          border: const OutlineInputBorder(),
          labelText: widget.formNama,
          labelStyle: TextStyle(color: Colors.black87),
          floatingLabelBehavior: FloatingLabelBehavior.always),
    );
  }
}
