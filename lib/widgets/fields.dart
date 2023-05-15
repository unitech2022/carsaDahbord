import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField2 extends StatelessWidget {
  final String? hint;
  final TextInputType? inputType;
  final TextEditingController? controller;

  CustomTextField2(
      { this.hint,  this.controller,  this.inputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xffF6F6F6),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        maxLines: null,
        onChanged: (value) {},
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: "pnuM",
          fontWeight: FontWeight.bold,
          color: Colors.black45,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}