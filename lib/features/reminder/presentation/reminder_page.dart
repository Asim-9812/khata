import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_app/common/export.dart';
import 'package:khata_app/features/reminder/presentation/create_reminder.dart';
import 'package:khata_app/features/reminder/presentation/update_reminder.dart';
import 'package:khata_app/features/reminder/provider/reminder_provider.dart';
import '../model/reminder_model.dart';
import '../service/notification_service.dart';

class PersonalReminderPage extends StatefulWidget {
  const PersonalReminderPage({Key? key}) : super(key: key);

  @override
  State<PersonalReminderPage> createState() => _PersonalReminderPageState();
}

class _PersonalReminderPageState extends State<PersonalReminderPage> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.initializeNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final reminderData = ref.watch(reminderProvider);
        return Scaffold(
            backgroundColor: Colors.white,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: ColorManager.primary,
                    pinned: true,
                    snap: false,
                    floating: false,
                    expandedHeight: 160.0,
                    flexibleSpace: const FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text('Reminders'),
                    ),
                    actions: reminderData.isNotEmpty ? [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(milliseconds: 300),
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return const CreateReminderPage();
                                },
                                transitionsBuilder:
                                    (context, animation, secondaryAnimation, child) {
                                  const begin =
                                  Offset(0.0, 0.5); // Specify the starting position
                                  const end = Offset.zero; // Specify the ending position
                                  final tween = Tween(begin: begin, end: end);
                                  final curvedAnimation = CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.ease, // Apply a desired easing curve
                                  );
                                  return SlideTransition(
                                    position: tween.animate(curvedAnimation),
                                    // Use the tween animation
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        icon: const Icon(
                          Icons.add,
                          size: 28,
                          color: Colors.white,
                        )),
                      IconButton(
                        onPressed: () {
                          showSearch(
                            useRootNavigator: true,
                            context: context,
                            delegate: CustomSearchDelegate(reminderModel: reminderData),
                          );
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 28,
                          color: Colors.white,
                        )),
                      ] : [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            size: 28,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ];
              },
              body: Column(
                children: [
                 reminderData.isEmpty ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                    padding: const EdgeInsets.all(0),
                    height: 60,
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 300),
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return const CreateReminderPage();
                            },
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
                              const begin =
                              Offset(0.0, 0.5); // Specify the starting position
                              const end = Offset.zero; // Specify the ending position
                              final tween = Tween(begin: begin, end: end);
                              final curvedAnimation = CurvedAnimation(
                                parent: animation,
                                curve: Curves.ease, // Apply a desired easing curve
                              );
                              return SlideTransition(
                                position: tween.animate(curvedAnimation),
                                // Use the tween animation
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ColorManager.logoOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, size: 20,),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Write a Note',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ) :
                  Expanded(
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: reminderData.length,
                        itemBuilder: (context, index) {
                          final reminderItem = reminderData[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            child: GestureDetector(
                              onDoubleTap: () {
                                ref.read(reminderProvider.notifier).removeItem(reminderData[index]);
                              },
                              child: Dismissible(
                                key: ValueKey<int>(reminderItem.id),
                                background: Container(
                                  color: Colors.green,
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Icon(Icons.edit, color: Colors.white, size: 24,),
                                    ),
                                  ),
                                ),
                                secondaryBackground: Container(
                                  color: Colors.red,
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 16),
                                      child: Icon(Icons.delete, color: Colors.white, size: 24,),
                                    ),
                                  ),
                                ),
                                onDismissed: (direction) {
                                  ref.read(reminderProvider.notifier).removeItem(reminderItem);
                                },
                                confirmDismiss: (direction) async{
                                  if(direction == DismissDirection.startToEnd){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateReminderPage(reminder: reminderItem),));
                                    return false;
                                  }else{
                                    bool delete = true;
                                    final snackBarController = ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Deleted one reminder'),
                                        backgroundColor: ColorManager.primary,
                                        duration: const Duration(milliseconds: 700),
                                      ),
                                    );
                                    snackBarController.closed;
                                    return delete;
                                  }
                                },
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateReminderPage(reminder: reminderItem),));
                                  },
                                  title: Text(reminderItem.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            reminderItem.timeOfDay.format(context),
                                            style: const TextStyle(fontSize: 15),
                                          ),
                                          reminderItem.repeat ? Container(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 4,
                                                vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade200,
                                              borderRadius:
                                              BorderRadius.circular(3),
                                              border: Border.all(
                                                color:
                                                Colors.green.shade800,
                                                width: .5,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.repeat,
                                                  color:
                                                  Colors.green.shade800,
                                                  size: 14,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  'EveryDay',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors
                                                          .green.shade800),
                                                ),
                                              ],
                                            ),
                                          ) :
                                          const Text(''),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(reminderItem.description!)
                                    ],
                                  ),
                                  isThreeLine: true,
                                  tileColor: ColorManager.background.withOpacity(0.4),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}


class CustomSearchDelegate extends SearchDelegate {
  final List<ReminderModel> reminderModel;
  CustomSearchDelegate({required this.reminderModel});
// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<ReminderModel> matchQuery = [];
    for (var reminder in reminderModel) {
      if (reminder.title.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(reminder);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateReminderPage(reminder: result),));
          },
          title: Text(result.title),
        );
      },
    );
  }
}