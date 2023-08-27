
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



class UpdateReminderPage extends StatefulWidget {
  final ReminderModel reminder;
  const UpdateReminderPage({Key? key, required this.reminder}) : super(key: key);

  @override
  State<UpdateReminderPage> createState() => _UpdateReminderPageState();
}

class _UpdateReminderPageState extends State<UpdateReminderPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController dateFrom = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();

  bool isRepeat = true;
  
  
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
  void initState() {
    super.initState();
    titleController.text = widget.reminder.title;
    detailController.text = widget.reminder.description!;
    isRepeat = widget.reminder.repeat;
    selectedTime = widget.reminder.timeOfDay;

    titleController.addListener(() {
      setState(() {

      });
    });
    detailController.addListener(() {
      setState(() {

      });
    });

  }

  bool checkIsTimeValid(TimeOfDay reminderTime, TimeOfDay selectedTime){
    return reminderTime.hour >= TimeOfDay.now().hour || reminderTime.minute >= TimeOfDay.now().minute ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final reminderItem = widget.reminder;
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
                                child: DisplayDateTime( selectedDate: selectedDate,
                                  selectedTime: selectedTime,)
                              ),
                            ),
                            const SizedBox(width: 30,),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    final DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(const Duration(days: 365)),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        selectedDate = pickedDate;
                                      });
                                    }

                                    final TimeOfDay? timeOfDay = await showTimePicker(
                                      context: context,
                                      initialTime: selectedTime,
                                      initialEntryMode: TimePickerEntryMode.dial,
                                    );
                                    if (timeOfDay != null) {
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
                                ReminderModel reminder =  ReminderModel(
                                    id: reminderItem.id,
                                    title: titleController.text.trim(),
                                    description: detailController.text.trim(),
                                    timeOfDay: selectedTime,
                                    repeat: isRepeat
                                );
                                await ref.read(reminderProvider.notifier).updateReminder(
                                   reminder
                                );
                                NotificationServices().scheduleNotification(
                                  reminder
                                );
                                scaffoldMessage.showSnackBar(
                                    SnackBarUtil.customSnackBar('Reminder Updated')
                                );
                                navigate.pop(true);
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
                              child: const Text('Update'),
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
