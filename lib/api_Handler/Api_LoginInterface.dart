import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:uosapp/api_Handler/Models/loginmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ILogin {
  login(String email, String password) async {
    log(email);
    log(password);
    final api = 'http://tritec.store/uosattendence/public/api//login';
    final data = {"email": email, "password": password};
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    if (response.statusCode == 200) {
      final body = response.data;
      // return UserModel(email: email, api_token: body['api_token']);
      return UserModel(email: email, api_token: body['user']['api_token']);
    } else {
      return null;
    }
  }

  getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final token = storage.getString('TOKEN');
    final email = storage.getString('EMAIL');
    if (token != null && email != null) {
      return UserModel(email: email, api_token: token);
    } else {
      return null;
    }
  }

  home(String text, String text2) {}
}

Future<bool> logout() async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  return true;
}
