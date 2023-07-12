import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:khata_app/common/colors.dart';
import 'package:khata_app/main.dart';
import 'package:khata_app/features/login/presentation/branch_page.dart';
import 'package:khata_app/utils/util_functions.dart';


import '../../../common/common_provider.dart';
import '../provider/auth_viewmodel.dart';
import 'package:readmore/readmore.dart';

class UserLoginView extends StatefulWidget {
  const UserLoginView({Key? key}) : super(key: key);

  @override
  State<UserLoginView> createState() => _UserLoginViewState();
}

class _UserLoginViewState extends State<UserLoginView> {

  /// creating global form key with <FormState> to save the credential in a state
  final _formKey = GlobalKey<FormState>();

  /// boolean variable to check if remember me is clicked or not
  bool _isChecked = false;

  /// boolean flag to toggle the password visible button
  bool _isVisible = true;

  /// each controller for each user input field as variable the name suggests
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();

  /// create a variable for box
  late Box box1;

  /// we want the box to be created as soon as the page is created
  /// so the create box function is called here in initState() method
  @override
  void initState() {
    super.initState();
    createOpenBox();
  }


  /// create a box with this function below
  void createOpenBox() async {
    box1 = await Hive.openBox('logindata');
    getdata();
  }

  /// gets the stored data from the box and assigns it to the controllers
  void getdata() async {
    if (box1.get('id') != null) {
      idController.text = box1.get('id');
      _isChecked = true;
      setState(() {});
    }
    if (box1.get('username') != null) {
      nameController.text = box1.get('username');
      _isChecked = true;
      setState(() {});
    }
    if (box1.get('password') != null) {
      passController.text = box1.get('password');
      _isChecked = true;
      setState(() {});
    }
  }

  ///returns the color for each state of the checkbox
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return ColorManager.primary;
  }

  /// date time instance for the current date
  DateTime timeBackPressed = DateTime.now();

  /// about us (khata)
  final String aboutUS = "KHATA is our premium accounting software that provides a complete and intuitive solution for businesses of all sizes."
      "With KHATA, you can easily track your financial transactions, manage your accounts, and generate reports with just a few clicks."
      "Our software is designed to be user-friendly and easy to use, even for those with no prior accounting experience."
      "One of the key features of KHATA is its real-time tracking capability. You can see your financial status at any time,"
      "giving you complete control and visibility over your business. Additionally, Another advantage of KHATA is its security.";


  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async{
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
            fontSize: 18.0,
          );
          return false;
        } else{
          return true;
        }

      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: OrientationBuilder(
          builder: (context, orientation) {
            if(orientation == Orientation.portrait){
              return Scaffold(
                backgroundColor: const Color(0xffE3EEF8),
                body: Consumer(
                  builder: (context, ref, child) {
                    return SafeArea(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                          child: SizedBox.expand(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Image.asset(
                                    "assets/images/khata-logo.png",
                                    height: 140,
                                    width: 140,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                    thickness: 1,
                                    height: 2,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    'Welcome to KHATA',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff286090),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      hintColor: ColorManager.textGray,
                                      primaryColor: ColorManager.primary,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      textInputAction: TextInputAction.next,
                                      controller: idController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: ColorManager.primary),
                                        ),
                                        errorStyle: TextStyle(
                                            fontSize: 16, color: ColorManager.errorRed),
                                        isDense: true,
                                        contentPadding: const EdgeInsets.all(18),
                                        labelText: 'Company ID',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: ColorManager.textGray,
                                        ),
                                        floatingLabelStyle: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: ColorManager.primary,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Company Id is required!!';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      hintColor: ColorManager.textGray,
                                      primaryColor: ColorManager.primary,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      textInputAction: TextInputAction.next,
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: ColorManager.primary),
                                        ),
                                        errorStyle: TextStyle(
                                            fontSize: 16, color: ColorManager.errorRed),
                                        isDense: true,
                                        contentPadding: const EdgeInsets.all(18),
                                        labelText: 'User Name',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: ColorManager.textGray,
                                        ),
                                        floatingLabelStyle: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: ColorManager.primary,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Username field is required!!';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      hintColor: ColorManager.textGray,
                                      primaryColor: ColorManager.primary,
                                    ),
                                    child: TextFormField(
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      textInputAction: TextInputAction.done,
                                      obscureText: _isVisible,
                                      controller: passController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: ColorManager.primary),
                                        ),
                                        errorStyle: TextStyle(
                                            fontSize: 16, color: ColorManager.errorRed),
                                        isDense: true,
                                        contentPadding: const EdgeInsets.all(18),
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: ColorManager.textGray,
                                        ),
                                        floatingLabelStyle: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: ColorManager.primary,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _isVisible = !_isVisible;
                                              });
                                            },
                                          iconSize: 26,
                                            icon: Icon(
                                              _isVisible
                                                  ? Icons.visibility_off_rounded
                                                  : Icons.visibility_rounded,
                                              color: _isVisible
                                                  ? ColorManager.textGrey
                                                  : ColorManager.primary,
                                            ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Password field is required!!';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 1,
                                        child: Checkbox(
                                          value: _isChecked,
                                          onChanged: (value) {
                                            _isChecked = !_isChecked;
                                            removeLoginInfo();
                                            setState(() {});
                                          },
                                          checkColor: Colors.white,
                                          fillColor: MaterialStateProperty.resolveWith(
                                                  (states) => getColor(states)),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'Remember me',
                                        style: TextStyle(
                                            fontFamily: 'Ubuntu', fontSize: 18),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      final isLoad = ref.watch(loadingProvider);
                                      return ElevatedButton(
                                        onPressed: isLoad ? null : () async {
                                          final navigator = Navigator.of(context);
                                          if (_formKey.currentState!.validate()) {
                                            ref.read(loadingProvider.notifier).toggle();
                                            login();
                                            final response = await ref.read(userLoginProvider).login(
                                              databseId: idController.text.trim(),
                                              username: nameController.text.trim(),
                                              password: passController.text.trim(),
                                            );
                                            if(response == 'success'){
                                              var result = sessionBox.get('userReturn');
                                              var res = jsonDecode(result);

                                              /// getting the branches from the session Box
                                              final List<String> branches = [];
                                              for(var e in res["departmentBranches"]){
                                                branches.add(e["branchDepartment"]);
                                              }
                                              navigator.push(MaterialPageRoute(builder: (context) => BranchPage(branchList: branches),));
                                              ref.read(loadingProvider.notifier).toggle();
                                            }else{
                                              Fluttertoast.showToast(
                                                msg: response,
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0,
                                              );
                                              ref.read(loadingProvider.notifier).toggle();
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorManager.primary,
                                          minimumSize: const Size(double.infinity, 60),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: isLoad ? const Center(child: CircularProgressIndicator(color: Colors.white,))  : const Text(
                                          'Login',
                                          style: TextStyle(
                                              fontFamily: 'Ubuntu',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 50,),
                                  TextButton(
                                    onPressed: () {
                                      LauncherUtils.launchTermConditionUrl();
                                      },
                                    child: Text('Terms & Condition',
                                      style: TextStyle(
                                          color: Colors.blue.shade500,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            contentPadding: EdgeInsets.zero, // Remove the default padding
                                            content: Container(
                                              padding: const EdgeInsets.all(0),
                                              height: 500,
                                              width: 400.0,
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
                                                    child: const Text('About Us',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ListView(
                                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                                      children: [
                                                        ReadMoreText(
                                                          aboutUS,
                                                          trimLines: 5,
                                                          trimMode: TrimMode.Line,
                                                          trimCollapsedText: 'Show more',
                                                          trimExpandedText: '  Show less',
                                                          moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),
                                                        ),
                                                        const SizedBox(height: 20,),
                                                        const Text('Contact Information',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                            decoration: TextDecoration.underline,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                          child: OutlinedButton(
                                                            onPressed:() {
                                                              LauncherUtils.openMap();
                                                            },
                                                            style: OutlinedButton.styleFrom(
                                                                side: BorderSide.none,
                                                                padding: EdgeInsets.zero
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons.location_pin, color: ColorManager.logoOrange),
                                                                const SizedBox(width: 10,),
                                                                const Text('New Baneshwor, Kathmandu',
                                                                  style: TextStyle(
                                                                      color: Colors.black
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                          child: OutlinedButton(
                                                            onPressed:() {
                                                              LauncherUtils.openPhone('01-4106642');
                                                            },
                                                            style: OutlinedButton.styleFrom(
                                                                side: BorderSide.none,
                                                                padding: EdgeInsets.zero
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons.phone, color: ColorManager.logoOrange,),
                                                                const SizedBox(width: 10,),
                                                                const Text('01-4106642 / 9851112946',
                                                                  style: TextStyle(
                                                                      color: Colors.black
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                          child: OutlinedButton(
                                                            onPressed:() {
                                                              LauncherUtils.openMail();
                                                            },
                                                            style: OutlinedButton.styleFrom(
                                                                side: BorderSide.none,
                                                                padding: EdgeInsets.zero
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons.mail, color: ColorManager.logoOrange),
                                                                const SizedBox(width: 10,),
                                                                const Text('reply2search@gmail.com',
                                                                  style: TextStyle(
                                                                      color: Colors.black
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                          child: OutlinedButton(
                                                            onPressed:() {
                                                              LauncherUtils.launchKhataWeb();
                                                            },
                                                            style: OutlinedButton.styleFrom(
                                                              side: BorderSide.none,
                                                              padding: EdgeInsets.zero,
                                                            ),
                                                            child:  Row(
                                                              children: [
                                                                Icon(CupertinoIcons.globe , color: ColorManager.logoOrange),
                                                                const SizedBox(width: 10,),
                                                                const Text('https://khatasystem.com/',
                                                                  style: TextStyle(
                                                                      color: Colors.black
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.help, color: ColorManager.iconGrey, size: 26,),
                                        const SizedBox(width: 5,),
                                        Text('Help',
                                            style: TextStyle(
                                                color: Colors.blue.shade500,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                decoration: TextDecoration.underline
                                            ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }else{
              return Scaffold(
                body: Consumer(
                  builder: (context, ref, child) {
                    return SafeArea(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: width * 0.04,),
                          child: SizedBox.expand(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  SizedBox(height: height * 0.04,),
                                  const Text('Welcome to KHATA',
                                    style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff286090),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.03,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: width * 0.08, ),
                                          child: Column(
                                            children: [
                                              Theme(
                                                data: Theme.of(context).copyWith(
                                                  hintColor: ColorManager.textGray,
                                                  primaryColor: ColorManager.primary,
                                                ),
                                                child: TextFormField(
                                                  autovalidateMode:
                                                  AutovalidateMode.onUserInteraction,
                                                  controller: idController,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5),
                                                      borderSide: BorderSide(
                                                          color: ColorManager.primary),
                                                    ),
                                                    errorStyle: TextStyle(
                                                        fontSize: 16, color: ColorManager.errorRed),
                                                    isDense: true,
                                                    contentPadding: EdgeInsets.all(height * 0.03),
                                                    labelText: 'Company ID',
                                                    labelStyle: TextStyle(
                                                      fontFamily: 'Ubuntu',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: ColorManager.textGray,
                                                    ),
                                                    floatingLabelStyle: TextStyle(
                                                      fontFamily: 'Ubuntu',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: ColorManager.primary,
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Company Id is required!!';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: height * 0.025,),
                                              Theme(
                                                data: Theme.of(context).copyWith(
                                                  hintColor: ColorManager.textGray,
                                                  primaryColor: ColorManager.primary,
                                                ),
                                                child: TextFormField(
                                                  autovalidateMode:
                                                  AutovalidateMode.onUserInteraction,
                                                  controller: nameController,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5),
                                                      borderSide: BorderSide(
                                                          color: ColorManager.primary),
                                                    ),
                                                    errorStyle: TextStyle(
                                                        fontSize: 16, color: ColorManager.errorRed),
                                                    isDense: true,
                                                    contentPadding: EdgeInsets.all(height * 0.03),
                                                    labelText: 'User Name',
                                                    labelStyle: TextStyle(
                                                      fontFamily: 'Ubuntu',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: ColorManager.textGray,
                                                    ),
                                                    floatingLabelStyle: TextStyle(
                                                      fontFamily: 'Ubuntu',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: ColorManager.primary,
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Username field is required!!';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: height * 0.025,),
                                              Theme(
                                                data: Theme.of(context).copyWith(
                                                  hintColor: ColorManager.textGray,
                                                  primaryColor: ColorManager.primary,
                                                ),
                                                child: TextFormField(
                                                  autovalidateMode:
                                                  AutovalidateMode.onUserInteraction,
                                                  obscureText: true,
                                                  controller: passController,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5),
                                                      borderSide: BorderSide(
                                                          color: ColorManager.primary),
                                                    ),
                                                    errorStyle: TextStyle(
                                                        fontSize: 16, color: ColorManager.errorRed),
                                                    isDense: true,
                                                    contentPadding: EdgeInsets.all(height * 0.03),
                                                    labelText: 'Password',
                                                    labelStyle: TextStyle(
                                                      fontFamily: 'Ubuntu',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: ColorManager.textGray,
                                                    ),
                                                    floatingLabelStyle: TextStyle(
                                                      fontFamily: 'Ubuntu',
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: ColorManager.primary,
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Password field is required!!';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Transform.scale(
                                                    scale: 0.8,
                                                    child: Checkbox(
                                                      value: _isChecked,
                                                      onChanged: (value) {
                                                        _isChecked = !_isChecked;
                                                        removeLoginInfo();
                                                        setState(() {});
                                                      },
                                                      checkColor: Colors.white,
                                                      fillColor: MaterialStateProperty.resolveWith(
                                                              (states) => getColor(states)),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(3),
                                                      ),
                                                    ),
                                                  ),
                                                  const Text(
                                                    'Remember me',
                                                    style: TextStyle(
                                                        fontFamily: 'Ubuntu', fontSize: 14),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: height * 0.005,),
                                              Consumer(
                                                builder: (context, ref, child) {
                                                  final isLoad = ref.watch(loadingProvider);
                                                  return  ElevatedButton(
                                                    onPressed: isLoad ? null :  () async {
                                                      final navigator = Navigator.of(context);
                                                      if (_formKey.currentState!.validate()) {
                                                        ref.read(loadingProvider.notifier).toggle();
                                                        login();
                                                        final response = await UserLogin().login(
                                                          databseId: idController.text.trim(),
                                                          username: nameController.text.trim(),
                                                          password: passController.text.trim(),
                                                        );

                                                        if(response == 'success'){
                                                          var result = sessionBox.get('userReturn');
                                                          var res = jsonDecode(result);

                                                          /// getting the branches from the session Box
                                                          final List<String> branches = [];
                                                          for(var e in res["departmentBranches"]){
                                                            branches.add(e["branchDepartment"]);
                                                          }
                                                          navigator.push(MaterialPageRoute(builder: (context) => BranchPage(branchList: branches),));
                                                          ref.read(loadingProvider.notifier).toggle();
                                                        }else{
                                                          Fluttertoast.showToast(
                                                            msg: response,
                                                            toastLength: Toast.LENGTH_LONG,
                                                            gravity: ToastGravity.BOTTOM,
                                                            backgroundColor: Colors.red,
                                                            textColor: Colors.white,
                                                            fontSize: 16.0,
                                                          );
                                                          ref.read(loadingProvider.notifier).toggle();
                                                        }
                                                      }
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: ColorManager.primary,
                                                      minimumSize: const Size(double.infinity, 40),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      'Login',
                                                      style: TextStyle(
                                                          fontFamily: 'Ubuntu',
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: width * 0.02, right: width * 0.03, top: height * 0.02),
                                        width: 280,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              height: 250,
                                              width: 1.5,
                                            ),
                                            Image.asset(
                                              "assets/images/khata-logo.png",
                                              height: 230,
                                              width: 230,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      LauncherUtils.launchTermConditionUrl();
                                    },
                                    child: Text('Terms & Condition',
                                      style: TextStyle(
                                          color: Colors.blue.shade500,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            contentPadding: EdgeInsets.zero, // Remove the default padding
                                            content: Container(
                                              padding: const EdgeInsets.all(0),
                                              height: 500,
                                              width: 400.0,
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
                                                    child: const Text('About Us',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ListView(
                                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                                      children: [
                                                        ReadMoreText(
                                                          aboutUS,
                                                          trimLines: 5,
                                                          trimMode: TrimMode.Line,
                                                          trimCollapsedText: 'Show more',
                                                          trimExpandedText: '  Show less',
                                                          moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue),
                                                        ),
                                                        const SizedBox(height: 20,),
                                                        const Text('Contact Information',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                            decoration: TextDecoration.underline,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                          child: OutlinedButton(
                                                            onPressed:() {
                                                              LauncherUtils.openMap();
                                                            },
                                                            style: OutlinedButton.styleFrom(
                                                                side: BorderSide.none,
                                                                padding: EdgeInsets.zero
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons.location_pin, color: ColorManager.logoOrange),
                                                                const SizedBox(width: 10,),
                                                                const Text('New Baneshwor, Kathmandu',
                                                                  style: TextStyle(
                                                                      color: Colors.black
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                          child: OutlinedButton(
                                                            onPressed:() {
                                                              LauncherUtils.openPhone('01-4106642');
                                                            },
                                                            style: OutlinedButton.styleFrom(
                                                                side: BorderSide.none,
                                                                padding: EdgeInsets.zero
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons.phone, color: ColorManager.logoOrange,),
                                                                const SizedBox(width: 10,),
                                                                const Text('01-4106642 / 9851112946',
                                                                  style: TextStyle(
                                                                      color: Colors.black
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                          child: OutlinedButton(
                                                            onPressed:() {
                                                              LauncherUtils.openMail();
                                                            },
                                                            style: OutlinedButton.styleFrom(
                                                                side: BorderSide.none,
                                                                padding: EdgeInsets.zero
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons.mail, color: ColorManager.logoOrange),
                                                                const SizedBox(width: 10,),
                                                                const Text('reply2search@gmail.com',
                                                                  style: TextStyle(
                                                                      color: Colors.black
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                          child: OutlinedButton(
                                                            onPressed:() {
                                                              LauncherUtils.launchKhataWeb();
                                                            },
                                                            style: OutlinedButton.styleFrom(
                                                              side: BorderSide.none,
                                                              padding: EdgeInsets.zero,
                                                            ),
                                                            child:  Row(
                                                              children: [
                                                                Icon(CupertinoIcons.globe , color: ColorManager.logoOrange),
                                                                const SizedBox(width: 10,),
                                                                const Text('https://khatasystem.com/',
                                                                  style: TextStyle(
                                                                      color: Colors.black
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.help, color: ColorManager.iconGrey, size: 26,),
                                        const SizedBox(width: 5,),
                                        Text('Help',
                                          style: TextStyle(
                                              color: Colors.blue.shade500,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              decoration: TextDecoration.underline
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  /// adds the user info into (box) the local database (Hive)
  void login() {
    if (_isChecked) {
      box1.put('id', idController.value.text);
      box1.put('username', nameController.value.text);
      box1.put('password', passController.value.text);
    }
  }

  /// clears the box or removes the stored credentials.
  void removeLoginInfo(){
    if(!_isChecked){
      box1.clear();
    }
  }
}


