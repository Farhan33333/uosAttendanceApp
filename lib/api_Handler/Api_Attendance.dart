import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:uosapp/api_Handler/Models/attendnacemodel.dart';

class AttendanceApi {
  static get_attend(apiToken) async {
    var Url = 'http://attendance.klickwash.net/api/attendance/get';
    var data = {'api_token': apiToken};
    var response = await Api.execute(url: Url, data: data);
    log(response.toString());
    if (!response['error']) {
      List<Attendancemodel> display_list = <Attendancemodel>[];
      for (var attend_list in response['attendances']) {
        display_list.add(Attendancemodel(attend_list));
      }
      log(display_list.toString());
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
