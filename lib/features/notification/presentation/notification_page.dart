import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khata_app/common/export.dart';
import 'package:khata_app/main.dart';

import '../provider/notification_provider.dart';


class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({super.key});

  @override
  ConsumerState<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends ConsumerState<NotificationView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var result = sessionBox.get('userReturn');
    var res = jsonDecode(result);
    String token = res["ptoken"];

    final notificationData = ref.watch(notificationProvider(token));
    return OrientationBuilder(
      builder: (context, orientation) {
        if(orientation == Orientation.portrait){
          return DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: ColorManager.primary,
                  elevation: 0,
                  scrolledUnderElevation: 10.0,
                  bottom: TabBar(
                    indicatorWeight: 4,
                    indicatorColor: ColorManager.logoOrange,
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    unselectedLabelStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    tabs: const [
                      Tab(
                        text: 'General',
                      ),
                      Tab(
                        text: 'Personal',
                      ),
                    ],
                  ),
                  title: const Text(
                    'Notifications',
                  ),
                  titleTextStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  toolbarHeight: 80,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg: 'No Notifications to Search',
                            gravity: ToastGravity.CENTER,
                            backgroundColor: ColorManager.primary.withOpacity(0.9),
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          // showSearch(
                          //   context: context,
                          //   delegate: CustomSearchDelegate(),
                          // );
                        },
                        icon: const Icon(
                          CupertinoIcons.search,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
                body: TabBarView(
                  children: [
                    notificationData.when(
                      data: (data) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.separated(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final notification = data[index];
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage: AssetImage('assets/images/khata-logo.png'),
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                    ),
                                    const SizedBox(width: 15,),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                children: [
                                                  TextSpan(text: notification.description, style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.7), ))
                                                ]
                                            ),
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Icon(Icons.access_time_rounded, color: ColorManager.iconGray, size: 18,),
                                              const SizedBox(width: 5,),
                                              Text(formatDistanceToNowStrict(notification.entryDate!), style: TextStyle(fontSize: 14, color: ColorManager.subtitleGrey, fontWeight: FontWeight.w500),)
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 1.2,
                                thickness: 1,
                                color: Colors.black.withOpacity(0.25),
                              );
                            },
                          ),
                        );
                      },
                      error: (error, stackTrace) => Center(child: Text('$error'),),
                      loading: () => Center(
                          child: Image.asset(
                            "assets/gif/loading-img2.gif",
                            height: 100,
                            width: 100,
                          )),
                    ),
                    Center(
                      child: Text('No notifications!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                )),
          );
        }else{
          return DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: ColorManager.primary,
                  bottom: TabBar(
                    indicatorWeight: 4,
                    indicatorColor: ColorManager.logoOrange,
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    unselectedLabelStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    tabs: const [
                      Tab(
                        text: 'General',
                      ),
                      Tab(
                        text: 'Personal',
                      ),
                    ],
                  ),
                  title: const Text(
                    'Notifications',
                  ),
                  titleTextStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  toolbarHeight: 70,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                            msg: 'No Notifications to Search',
                            gravity: ToastGravity.CENTER,
                            backgroundColor: ColorManager.primary.withOpacity(0.9),
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          // showSearch(
                          //   context: context,
                          //   delegate: CustomSearchDelegate(),
                          // );
                        },
                        icon: const Icon(
                          CupertinoIcons.search,
                          size: 28,
                        ),
                      ),
                    )
                  ],
                ),
                body: TabBarView(
                  children: [
                    notificationData.when(
                      data: (data) {
                        return Padding(
                          padding:
                          const EdgeInsets.all(10),
                          child: ListView.separated(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final notification = data[index];
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage: AssetImage('assets/images/khata-logo.png'),
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                    ),
                                    const SizedBox(width: 15,),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                children: [
                                                  TextSpan(text: notification.description, style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.7), ))
                                                ]
                                            ),
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Icon(Icons.access_time_rounded, color: ColorManager.iconGray, size: 20,),
                                              const SizedBox(width: 5,),
                                              Text(formatDistanceToNowStrict(notification.entryDate!), style: TextStyle(fontSize: 15, color: ColorManager.subtitleGrey, fontWeight: FontWeight.w500),)
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 1.2,
                                thickness: 1,
                                color: Colors.black.withOpacity(0.25),
                              );
                            },
                          ),
                        );
                      },
                      error: (error, stackTrace) => Center(child: Text('$error'),),
                      loading: () => const CupertinoActivityIndicator(),
                    ),
                    Center(
                      child: Text('No notifications!',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding:
                    //   const EdgeInsets.all(10),
                    //   child: ListView.separated(
                    //     itemCount: 3,
                    //     itemBuilder: (context, index) {
                    //       return Container(
                    //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    //         child: Row(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             CircleAvatar(
                    //               backgroundColor: Colors.white,
                    //               radius: 30,
                    //               child: Icon(Icons.person, color: ColorManager.buttonBlue, size: 40,),
                    //             ),
                    //             const SizedBox(width: 15,),
                    //             Expanded(
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   RichText(
                    //                     text: const TextSpan(
                    //                         children: [
                    //                           TextSpan(text: 'Khata System', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),
                    //                           TextSpan(text: ' Please renew your account to be able to view the latest releast industry\'s standard update on statement and register.', style: TextStyle(fontSize: 18, color: Colors.black))
                    //                         ]
                    //                     ),
                    //                   ),
                    //                   const SizedBox(height: 5,),
                    //                   Text('Yesterday at 10:31 am', style: TextStyle(fontSize: 18, color: ColorManager.subtitleGrey),)
                    //                 ],
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //     separatorBuilder: (context, index) {
                    //       return Divider(
                    //         height: 1.2,
                    //         thickness: 1,
                    //         color: Colors.black.withOpacity(0.25),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                )),
          );
        }
      },
    );
  }
}


class CustomSearchDelegate extends SearchDelegate {
// Demo list to show querying
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

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
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () {
            query = result;
            showResults(context);
          },
          title: Text(result),
        );
      },
    );
  }
}
