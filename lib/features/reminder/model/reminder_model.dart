



import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'reminder_model.g.dart';


@HiveType(typeId: 0)
class ReminderModel extends HiveObject{
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  TimeOfDay timeOfDay;

  @HiveField(4)
  bool repeat;

  ReminderModel({
    required this.id,
    required this.title,
    this.description,
    required this.timeOfDay,
    required this.repeat,
  });


}


List<ReminderModel> reminderList = <ReminderModel>[];