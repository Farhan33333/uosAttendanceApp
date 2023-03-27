// import 'package:dio/dio.dart';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uosapp/api_Handler/Models/loginmodel.dart';
import 'package:uosapp/api_Handler/Api_LoginInterface.dart';

class LoginService extends ILogin {
  @override
  Future<UserModel> login(String email, String password) async {
    final api = Uri.parse('https://attendance.klickwash.net/api/login');
    final data = {"email": email, "password": password};

    http.Response response = await http.post(api, body: data);

    if (response.statusCode == 200) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      final decodeResponse = jsonDecode(response.body);

      await storage.setString('TOKEN', decodeResponse['user']["api_token"]);
      await storage.setString('EMAIL', decodeResponse['user']['email']);

      return UserModel(
        email: decodeResponse['user']['email'],
        api_token: decodeResponse['user']['api_token'],
      );
    } else {
      throw Exception('Failed to authenticate user');
    }
  }

  @override
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

  @override
  logout() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final email = storage.getString('EMAIL');
    final token = storage.getString('TOKEN');
    if (email != null && token != null) {
      await storage.remove('TOKEN');
      await storage.remove('EMAIL');

      return true;
    } else {
      return false;
    }
  }
}
