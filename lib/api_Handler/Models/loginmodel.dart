import 'package:flutter/material.dart';

class UserModel {
  final int? id;
  final String email;
  final String api_token;

  UserModel({this.id, required this.email, required this.api_token});
}
