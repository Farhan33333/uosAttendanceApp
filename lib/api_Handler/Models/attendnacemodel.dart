import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Attendancemodel {
  late int id;
  late String subject_name;
  late DateTime datetime;

  Attendancemodel(attend_list) {
    this.id = attend_list['id'];
    this.subject_name = attend_list['subject_name'];
    this.datetime = DateTime.parse(attend_list['created_at']);
  }
}
