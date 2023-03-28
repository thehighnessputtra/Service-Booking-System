// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  TextEditingController? controller;
  String? formNama;
  double? height;
  int? minLine;
  int? maxLine;
  bool setHigh;
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
      this.height,
      this.minLine,
      this.maxLine,
      this.setHigh = false,
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
    return SizedBox(
      height: widget.setHigh == false ? 50 : widget.height,
      child: TextFormField(
        maxLines: widget.maxLine,
        minLines: widget.minLine,
        validator: widget.validasi,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
            hintText: widget.hint,
            border: const OutlineInputBorder(),
            isDense: true,
            labelStyle: const TextStyle(color: Colors.black87),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green)),
            labelText: widget.formNama,
            helperText: widget.comment,
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }
}
