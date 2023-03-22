// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  TextEditingController? controller;
  String? formNama;
  VoidCallback? onTap;
  bool readOnly;
  String? hint;
  String? comment;
  TextInputType? keyboardType;
  FormFieldValidator<String>? validasi;

  CustomTextFormField(
      {super.key,
      this.controller,
      this.formNama,
      this.comment,
      this.keyboardType,
      this.hint,
      this.validasi,
      this.readOnly = false,
      this.onTap});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validasi,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          hintText: widget.hint,
          border: const OutlineInputBorder(),
          labelText: widget.formNama,
          labelStyle: const TextStyle(color: Colors.black87),
          helperText: widget.comment,
          floatingLabelBehavior: FloatingLabelBehavior.always),
    );
  }
}
