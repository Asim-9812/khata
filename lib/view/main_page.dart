import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khata_app/common/colors.dart';
import 'package:khata_app/service/update_service/update_service.dart';
import 'package:khata_app/service/update_service/update_service_impl.dart';

import '../features/activies/presentation/activity_page.dart';
import '../features/dashboard/presentation/home_screen.dart';
import '../features/menu/presentation/menu_screen.dart';
import '../features/notification/presentation/notification_page.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final UpdateService _updateService = UpdateServiceImpl();

  void _onUpdateSuccess() {
    Widget alertDialogOkButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Ok")
    );
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Update Successfully Installed"),
      content: const Text("Khata System has been updated successfully! ✔ "),
      actions: [
        alertDialogOkButton
      ],
    );
    showDialog(context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void _onUpdateFailure(String error) {
    Widget alertDialogTryAgainButton = TextButton(
        onPressed: () {
          _updateService.checkForInAppUpdate(_onUpdateSuccess, _onUpdateFailure);
          Navigator.pop(context);
        },
        child: const Text("Try Again?")
    );
    Widget alertDialogCancelButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("Dismiss"),
    );
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Update Failed To Install ❌"),
      content: Text("Khata System has failed to update because: \n $error"),
      actions: [
        alertDialogTryAgainButton,
        alertDialogCancelButton
      ],
    );
    showDialog(context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  void initState() {
    super.initState();
    _updateService.checkForInAppUpdate(_onUpdateSuccess, _onUpdateFailure);
  }


  int _currentIndex = 0;

  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {


    List<Widget> screenList = [
      const HomePageScreen(),
      const ReportView(),
      const ActivityView(),
      const NotificationView(),
    ];
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if(isExitWarning){
          Fluttertoast.showToast(
            msg: '     Press again to exit app     ',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ColorManager.primary.withOpacity(0.9),
            textColor: Colors.white,
            fontSize: 16.0,
          );
          return false;
        } else{
          // SystemNavigator.pop();     this is here as warning not to do this // only use for Android platform. for ios it will suspend the account because exit(0) is against appstore policy
          return true;
        }
      },
      child: OrientationBuilder(
        builder: (context, orientation) {
          if(orientation == Orientation.portrait){
            return Scaffold(
              body: screenList[_currentIndex],
              bottomNavigationBar: BottomNavyBar(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                containerHeight: 70,
                selectedIndex: _currentIndex,
                showElevation: true,
                itemCornerRadius: 20,
                iconSize: 26,
                curve: Curves.easeIn,
                onItemSelected: (index) => setState(() => _currentIndex = index),
                items: <BottomNavyBarItem>[
                  BottomNavyBarItem(
                    icon: const FaIcon(FontAwesomeIcons.house),
                    title: const Text('Home'),
                    activeColor: ColorManager.primary,
                    inactiveColor: ColorManager.iconGray,
                    textAlign: TextAlign.center,
                  ),
                  BottomNavyBarItem(
                    icon: const Icon(CupertinoIcons.doc_on_clipboard_fill),
                    title: const Text('Reports'),
                    activeColor: ColorManager.primary,
                    inactiveColor: ColorManager.iconGray,
                    textAlign: TextAlign.center,
                  ),
                  BottomNavyBarItem(
                    icon: const FaIcon(FontAwesomeIcons.clockRotateLeft),
                    title: const Text('Activities'),
                    activeColor: ColorManager.primary,
                    inactiveColor: ColorManager.iconGray,
                    textAlign: TextAlign.center,
                  ),
                  BottomNavyBarItem(
                    icon: const FaIcon(FontAwesomeIcons.solidBell),
                    title: const Text('Notification'),
                    activeColor: ColorManager.primary,
                    inactiveColor: ColorManager.iconGray,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }else{
            return Scaffold(
              body: screenList[_currentIndex],
              bottomNavigationBar: BottomNavyBar(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                containerHeight: 70,
                selectedIndex: _currentIndex,
                showElevation: true,
                itemCornerRadius: 10,
                iconSize: 26,
                curve: Curves.easeIn,
                onItemSelected: (index) => setState(() => _currentIndex = index),
                items: <BottomNavyBarItem>[
                  BottomNavyBarItem(
                    icon: const FaIcon(FontAwesomeIcons.house),
                    title: const Text('Home'),
                    activeColor: ColorManager.primary,
                    inactiveColor: ColorManager.iconGray,
                    textAlign: TextAlign.center,
                  ),
                  BottomNavyBarItem(
                    icon: const Icon(CupertinoIcons.doc_on_clipboard_fill),
                    title: const Text('Reports'),
                    activeColor: ColorManager.primary,
                    inactiveColor: ColorManager.iconGray,
                    textAlign: TextAlign.center,
                  ),
                  BottomNavyBarItem(
                    icon: const FaIcon(FontAwesomeIcons.clockRotateLeft),
                    title: const Text('Activities'),
                    activeColor: ColorManager.primary,
                    inactiveColor: ColorManager.iconGray,
                    textAlign: TextAlign.center,
                  ),
                  BottomNavyBarItem(
                    icon: const FaIcon(FontAwesomeIcons.solidBell),
                    title: const Text('Notification'),
                    activeColor: ColorManager.primary,
                    inactiveColor: ColorManager.iconGray,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
