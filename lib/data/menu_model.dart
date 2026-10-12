import 'package:flutter/material.dart';

class MenuModel {
  final IconData iconData;
  final String text;
  final Animation<Offset> animation;

  const MenuModel({
    required this.iconData,
    required this.text,
    required this.animation,
  });

  Map<String, dynamic> toJson() => {
    "iconData": iconData,
    "text": text,
    "animation": animation,
  };

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
    iconData: json['iconData'],
    text: json['text'],
    animation: json['animation'],
  );
}