


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khata_app/features/reminder/model/reminder_model.dart';
import 'package:khata_app/main.dart';


final reminderProvider = StateNotifierProvider<ReminderProvider, List<ReminderModel>>((ref) => ReminderProvider(ref.watch(boxB)));

class ReminderProvider extends StateNotifier<List<ReminderModel>>{
  ReminderProvider(super.state);

  Future<String> addReminder(ReminderModel reminder) async{
    if(state.isEmpty){
      final newReminderItem = ReminderModel(
        id: reminder.id,
        title: reminder.title,
        description: reminder.description,
        timeOfDay: reminder.timeOfDay,
        repeat: reminder.repeat
      );
      Hive.box<ReminderModel>('ReminderBox').add(newReminderItem);
      state = [newReminderItem];
      return 'success';
    }else{
      final reminderItem = state.firstWhere((element) => element.id == reminder.id, orElse: () {
        return ReminderModel(id: 0, title: 'no data', repeat: false, timeOfDay: TimeOfDay.now());
      },);
      if(reminderItem.title ==  'no data'){
        final newReminderItem = ReminderModel(
            id: reminder.id,
            title: reminder.title,
            description: reminder.description,
            timeOfDay: reminder.timeOfDay,
            repeat: reminder.repeat
        );
        Hive.box<ReminderModel>('ReminderBox').add(newReminderItem);
        state = [...state, newReminderItem];
        return 'success';
      }else{
        return 'fail';
      }
    }
  }

  Future<String> updateReminder(ReminderModel reminder) async{
    ReminderModel reminderItem = ReminderModel(
        id: reminder.id,
        title: reminder.title,
        description: reminder.description,
        timeOfDay: reminder.timeOfDay,
        repeat: reminder.repeat
    );

    Hive.box<ReminderModel>('ReminderBox').put(reminder.id, reminderItem);

    state = state.map((e) {
      if(e.id == reminderItem.id){
        return reminderItem;
      }
      return e;
    }).toList();

    return 'success';
  }

  void removeItem(ReminderModel reminderItem) {
    reminderItem.delete();
    state.remove(reminderItem);
    state = [...state];
  }

}