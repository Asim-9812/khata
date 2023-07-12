
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_app/features/reminder/model/reminder_model.dart';
import 'package:khata_app/features/reminder/provider/reminder_provider.dart';
import 'package:khata_app/features/reminder/service/notification_service.dart';
import 'package:khata_app/features/reminder/widget/display_date_time.dart';
import 'package:khata_app/features/reminder/widget/snackbar.dart';


import '../../../common/colors.dart';



class CreateReminderPage extends StatefulWidget {
  const CreateReminderPage({Key? key}) : super(key: key);

  @override
  State<CreateReminderPage> createState() => _CreateReminderPageState();
}

class _CreateReminderPageState extends State<CreateReminderPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController dateFrom = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.initializeNotifications();
  }


  bool isRepeat = true;
  bool isTimeValid = false;

  final MaterialStateProperty<Icon?> thumbIcon =
  MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        )
    );
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        const Text('Title',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ColorManager.background.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                            controller: titleController,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Enter text',
                              hintStyle: TextStyle(decoration: TextDecoration.none),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text('Description',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: ColorManager.background.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                            controller: detailController,
                            maxLines: 8,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Enter detail information here',
                              hintStyle: TextStyle(decoration: TextDecoration.none),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text('Time',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 10,),
                       Row(
                         children: [
                           Container(
                             padding: const EdgeInsets.all(5),
                             height: 50,
                             width: 200,
                             decoration: BoxDecoration(
                                 color: ColorManager.background.withOpacity(0.5),
                                 borderRadius: BorderRadius.circular(10)
                             ),
                             child: Align(
                               alignment: Alignment.centerLeft,
                               child: DisplayDateTime(selectedTime: selectedTime),
                             ),
                           ),
                           const SizedBox(width: 30,),
                           Expanded(
                             child: ElevatedButton(
                               onPressed: () async {
                                 final TimeOfDay? timeOfDay = await showTimePicker(
                                   context: context,
                                   initialTime: selectedTime,
                                   initialEntryMode: TimePickerEntryMode.dial,
                                 );
                                 if(timeOfDay != null){
                                   setState(() {
                                     selectedTime = timeOfDay;
                                   });
                                 }
                               },
                               style: ElevatedButton.styleFrom(
                                   minimumSize: const Size(double.infinity, 50),
                                   textStyle: const TextStyle(
                                     fontSize: 18,
                                     fontWeight: FontWeight.w500,
                                   ),
                                   elevation: 0,
                                   backgroundColor: ColorManager.primary,
                                   shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(10)
                                   ),
                               ),
                               child: const Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Icon(Icons.more_time, size: 26, color: Colors.white,),
                                   SizedBox(width: 10,),
                                   Text('Pick Time'),
                                 ],
                               )
                             ),
                           ),
                         ],
                       ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const Text('Repeat',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 15,),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 90),
                              transitionBuilder: (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: CupertinoSwitch(
                                key: ValueKey<bool>(isRepeat),
                                value: isRepeat,
                                onChanged: (value) {
                                  setState(() {
                                    isRepeat = value; // Update the switch value
                                  });
                                },
                                activeColor: ColorManager.primary,
                                trackColor: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size(160, 50),
                          foregroundColor: Colors.black,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                          ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                        )
                      ),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Consumer(
                        builder: (context, ref, child) {
                          return ElevatedButton(
                            onPressed:  titleController.text.isEmpty ? null : () async{
                              final scaffoldMessage = ScaffoldMessenger.of(context);
                              final navigate = Navigator.of(context);
                              Random random = Random();
                              ReminderModel reminder = ReminderModel(
                                  id: random.nextInt(1000),
                                  title: titleController.text.trim(),
                                  description: detailController.text.trim(),
                                  timeOfDay: selectedTime,
                                  repeat: isRepeat
                              );
                              await ref.read(reminderProvider.notifier).addReminder(
                                  reminder
                              );
                              notificationServices.scheduleNotification(
                                reminder
                              );
                              navigate.pop(true);
                              scaffoldMessage.showSnackBar(
                                  SnackBarUtil.customSnackBar('Reminder Saved')
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                              ),
                              backgroundColor: ColorManager.primary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              disabledBackgroundColor: ColorManager.primary.withOpacity(0.5),
                              disabledForegroundColor: Colors.white.withOpacity(0.5),
                            ),
                            child: const Text('Save'),
                          );
                        },
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
  }

}





