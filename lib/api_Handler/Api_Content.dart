import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uosapp/api_Handler/Models/contentmodel.dart';
import 'package:uosapp/api_Handler/Models/detailmodel.dart';

class CategoryApi {
  static get_cat(apiToken) async {
    var Url = 'http://tritec.store/uosattendence/public/api/subjects';
    var data = {'api_token': apiToken};
    var response = await Api.execute(url: Url, data: data);
    log(response.toString());
    if (!response['error']) {
      List<Album> display_list = <Album>[];
      for (var content_list in response['subjects']) {
        display_list.add(Album(content_list));
      }
      log(display_list.toString());
      return display_list;
    } else {
      return false;
    }
  }
}

class Content_details {
  static postApi(apiToken, s_id) async {
    var Url = 'http://tritec.store/uosattendence/public/api/content';
    var data = {'api_token': apiToken, "subject_id": s_id.toString()};
    var response = await Api.execute(url: Url, data: data);
    // final dio = Dio();
    log(response.toString());
    if (!response['error']) {
      List<Content> display_list = <Content>[];
      for (var pro_list in response['content']) {
        display_list.add(Content(pro_list));
      }
      // log(display_list.toString());
      return display_list;
    } else {
      return false;
    }
  }
}

class Api {
  static execute({url, data}) async {
    print(data);
    var result;
    Dio dio = new Dio();
    result = await dio.post(url, data: data);
    var response = jsonDecode(result.toString());
    return response;
  }
}
