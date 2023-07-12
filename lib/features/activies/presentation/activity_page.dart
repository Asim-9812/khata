import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:khata_app/common/format_date_distance.dart';
import 'package:khata_app/features/activies/model/entry_master_model.dart';
import 'package:khata_app/features/activies/model/logModel.dart';
import 'package:khata_app/features/activies/service/activites_service.dart';
import 'package:khata_app/main.dart';
import '../../../common/colors.dart';


const List<String> list = [
  'Login Activity',
  'Transaction Activity',
];

var result = sessionBox.get('userReturn');
var res = jsonDecode(result);
String token = res["ptoken"];

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  late String selectedItem;
  String dropdownValue = list.first;
  Color? tileColor;

  Timer? logTimer;
  Timer? transactionTimer;
  StreamController<List<LogModel>> logStreamController =
      StreamController<List<LogModel>>.broadcast();
  StreamController<List<EntryMaster>> transactionStreamController =
      StreamController<List<EntryMaster>>.broadcast();

  @override
  void initState() {
    super.initState();
    tileColor = ColorManager.subtitleGrey;
    logTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      fetchLogActivities(logStreamController, token);
    });

    transactionTimer = Timer(const Duration(seconds: 3), () {
      fetchTransactionActivities(transactionStreamController);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorManager.primary,
              centerTitle: true,
              pinned: true,
              scrolledUnderElevation: 10.0,
              title: const Text('Activities'),
              titleTextStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              toolbarHeight: 90,
            ),
          ];
        },
        body: Column(
          children: [
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: DropdownButton(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: list.map<DropdownMenuItem<String>>(
                    (value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  // activity and transaction are the two subtype of activity page
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: DisplayBlock(
                  dropDownValue: dropdownValue,
                  logController: logStreamController,
                  transactionController: transactionStreamController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    logTimer!.cancel();
    transactionTimer!.cancel();
    logStreamController.close();
    transactionStreamController.close();
    super.dispose();
  }
}

class DisplayBlock extends StatelessWidget {
  final String dropDownValue;
  final StreamController<List<LogModel>> logController;
  final StreamController<List<EntryMaster>> transactionController;


  const DisplayBlock(
      {Key? key,
      required this.dropDownValue,
      required this.logController,
      required this.transactionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dropDownValue == 'Transaction Activity') {
      return StreamBuilder(
        stream: transactionController.stream,
        builder: (BuildContext context, AsyncSnapshot<List<EntryMaster>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Image.asset(
              "assets/gif/loading-img2.gif",
              height: 140,
              width: 140,
            ));
          } else if(snapshot.hasError){
            transactionController.close();
            return const Center(
              child: Text(
                'Could not Load Data!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final reverseIndex = snapshot.data!.length - 1 - index;
              return Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: '${snapshot.data![reverseIndex].name}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        TextSpan(
                            text: ' ${snapshot.data![index].voucherTypeName}',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black)),
                        TextSpan(
                            text: ' (${snapshot.data![index].voucherNo})',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black))
                      ]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${formatDistanceToNowStrict(snapshot.data![index].entryDate!)} ago',
                      style: TextStyle(
                          fontSize: 18, color: ColorManager.subtitleGrey),
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
          );
        },
      );

    } else {
      return StreamBuilder(
        stream: logController.stream,
        builder: (BuildContext context, AsyncSnapshot<List<LogModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Image.asset(
              "assets/gif/loading-img2.gif",
              height: 140,
              width: 140,
            ));
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final reverseIndex = snapshot.data!.length - 1 - index;
              final item = snapshot.data![reverseIndex];
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        contentPadding: EdgeInsets.zero, /// Remove the default padding
                        content: Container(
                          padding: const EdgeInsets.all(0),
                          height: 500,
                          width: 600.0,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/khata-logo.png'),
                                  fit: BoxFit.contain,
                                  opacity: 0.05
                              )
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10),)
                                ),
                                child: const Center(
                                  child: Text('Log Information',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: item.name,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                            ),
                                            TextSpan(
                                              text: ' ${(item.status == 'True') ? 'Logged In' : item.statusMessage} ${formatDistanceToNowStrict(snapshot.data![reverseIndex].logInTime!)} ago',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ],
                                      ),
                                    ),
                                    const SizedBox(height: 16,),
                                    const Text('Details',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Email: ',
                                            style: TextStyle(
                                                fontSize: 18,

                                                color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: item.email,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4,),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Contact: ',
                                            style: TextStyle(
                                                fontSize: 18,

                                                color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: item.contact,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4,),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Mac address: ',
                                            style: TextStyle(
                                                fontSize: 18,

                                                color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: item.macAddress,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4,),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'IP address: ',
                                            style: TextStyle(
                                                fontSize: 18,

                                                color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: item.ipaddress,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: snapshot.data![reverseIndex].name,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          TextSpan(
                              text: ' ${snapshot.data![reverseIndex].statusMessage}',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black))
                        ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${formatDistanceToNowStrict(snapshot.data![reverseIndex].logInTime!)} ago',
                        style: TextStyle(
                            fontSize: 18, color: ColorManager.subtitleGrey),
                      )
                    ],
                  ),
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
          );
        },
      );
    }
  }
}
