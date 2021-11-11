import 'package:auctionbd/const/app_colours.dart';
import 'package:flutter/material.dart';

Widget myTextField(String hintText, keyBoardType, controller) {
  return TextField(
    keyboardType: keyBoardType,
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
          color: AppColours.deep_purple,
        ),
      ),
    ),
  );
}
