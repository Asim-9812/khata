import 'dart:convert';

import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khata_app/common/common_provider.dart';
import 'package:khata_app/common/shimmer_loading.dart';
import 'package:khata_app/features/dashboard/provider/dashboard_amount_provider.dart';
import 'package:khata_app/features/reminder/presentation/reminder_page.dart';
import 'package:khata_app/main.dart';

import 'package:khata_app/features/login/presentation/user_login.dart';
import 'package:khata_app/utils/util_functions.dart';

import '../../../common/colors.dart';
import '../../../model/dashboard_model.dart';
import '../../../model/list model/get_list_model.dart';

final userIdProvider = Provider<String>((ref) => userId);

String userId = "";

late MainInfoModel mainInfo;

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key,});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    var result = sessionBox.get('userReturn');
    var res = jsonDecode(result);

    String selectedBranch = branchBox.get('selectedBranch');
    int branchId = branchBox.get('selectedBranchId');
    final branchDepartmentId = branchBox.get('selectedBranchDepId');



    userId = "${res["userReturn"]["intUserId"]}-${res["ownerCompanyList"]["databaseName"]}";

    String companyName = res["ownerCompanyList"]["companyName"];
    String fiscalYear = res["fiscalYearInfo"]["fiscalYear"];


    mainInfo = MainInfoModel(
      userId: res["userReturn"]["intUserId"],
      fiscalID: res["fiscalYearInfo"]["financialYearId"],
      branchDepartmentId: branchDepartmentId,
      branchId: branchId,
      isEngOrNepaliDate: res["otherInfo"]["isEngOrNepali"],
      isMenuVerified: false,
      filterId: 0,
      refId: 0,
      mainId: 0,
      strId: '',
      dbName: res["ownerCompanyList"]["databaseName"],
      decimalPlace:res["otherInfo"]["decimalPlace"],
      startDate: res["fiscalYearInfo"]["fromDate"],
      endDate: res["fiscalYearInfo"]["toDate"],
      sessionId: res["userReturn"]["sessionId"],
    );

    MainInfoModel infoModel = MainInfoModel(
      userId: res["userReturn"]["intUserId"],
      fiscalID: res["fiscalYearInfo"]["financialYearId"],
      branchDepartmentId: branchDepartmentId,
      branchId: branchId,
      isEngOrNepaliDate: res["otherInfo"]["isEngOrNepali"],
      isMenuVerified: false,
      filterId: 0,
      refId: 0,
      mainId: 0,
      strId: '',
      dbName: res["ownerCompanyList"]["databaseName"],
      decimalPlace:res["otherInfo"]["decimalPlace"],
      startDate: res["fiscalYearInfo"]["fromDate"],
      endDate: res["fiscalYearInfo"]["toDate"],
      sessionId: res["userReturn"]["sessionId"],
      fromDate: "2023-05-31T00:00:00",
      toDate: "2023-05-31T00:00:00",
    );


    return OrientationBuilder(
      builder: (context, orientation) {
        final dashBoardType = ref.watch(dashBoardTypeProvider);
        if(orientation == Orientation.portrait){

          return Consumer(
            builder: (context, ref, child) {
              final dashData = ref.watch(dashBoardDataProvider(infoModel));
              return Scaffold(
                key: scaffoldKey,
                body: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      delegate: CustomSliverAppBarDelegate(expandedHeight: 200.0, scaffoldKey: scaffoldKey, companyName, selectedBranch, fiscalYear, false ),
                      pinned: true,
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 40,),
                    ),
                    dashBoardType == 'Financial' ? SliverToBoxAdapter(
                      child: dashData.when(
                        data: (data) {
                          return buildDashBoard(false, data);
                        },
                        error: (error, stackTrace) => Text('$error'),
                        loading: () {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40,),
                            height: 500,
                            width: double.infinity,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  height: 90,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                     CustomShimmer(width: 80, height: 80, borderRadius: 40,),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomShimmer(width: 150, height: 18, borderRadius: 5,),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            CustomShimmer(width: 80, height: 15, borderRadius: 5,),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ) : SliverToBoxAdapter(
                      child: Container(
                        height: 500,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: const Center(
                          child: Text('Feature Coming Soon!!!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ),
                    buildBody()
                  ],
                ),
                drawer: SafeArea(
                  child: Drawer(
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: ColorManager.drawerPrimary
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/khata-logo-name.png",
                                ),
                                const SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: ColorManager.drawerSecondary,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Icon(Icons.person, color: Colors.white, size: 50,),
                                      ),
                                      const SizedBox(width: 20,),
                                      const Text('Username', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),)
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                        const SizedBox(height: 10,),
                        ListTile(
                          onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalReminderPage(),));
                          },
                          title: const Text('Personal Note',
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 18,
                            ),
                          ),
                          leading: Icon(Icons.note_alt_sharp, size: 28,
                            color: ColorManager.iconGray,),
                        ),
                        ListTile(
                          onTap: (){
                            Navigator.pop(context, true);
                            Fluttertoast.showToast(
                              msg: 'Feature Coming Soon!!!',
                              gravity: ToastGravity.CENTER,
                              backgroundColor: ColorManager.primary.withOpacity(0.9),
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
                          title: const Text('POS',
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 18,
                            ),
                          ),
                          leading: Icon(Icons.point_of_sale_rounded, size: 28,
                            color: ColorManager.iconGray,),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context,true);
                           LauncherUtils.launchPolicyUrl();
                          },
                          title: const Text('Privacy Policy', style: TextStyle(
                            fontFamily: 'Ubuntu', fontSize: 18,),),
                          leading: Icon(Icons.privacy_tip_outlined, size: 28,
                            color: ColorManager.iconGray,),
                        ),
                        ListTile(
                          onTap: () {
                            sessionBox.clear();
                            branchBox.clear();
                            Navigator.pop(context,true);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UserLoginView()));
                          },
                          title: const Text('Logout', style: TextStyle(
                              fontFamily: 'Ubuntu', fontSize: 18, color: Colors.black),),
                          leading: Icon(
                            Icons.logout,
                            size: 28,
                            color: ColorManager.iconGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                extendBody: true,
              );
            },
          );
        } else{
          return Consumer(
            builder: (context, ref, child) {
              final dashData = ref.watch(dashBoardDataProvider(infoModel));
              return Scaffold(
                key: scaffoldKey,
                body: CustomScrollView(
                  slivers: [
                    SliverPersistentHeader(
                      delegate: CustomSliverAppBarDelegate(expandedHeight: 130, scaffoldKey: scaffoldKey, companyName, selectedBranch, fiscalYear, true),
                      pinned: true,
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 20,),
                    ),
                    dashBoardType == 'Financial' ? SliverToBoxAdapter(
                      child: dashData.when(
                        data: (data) {
                          return buildDashBoard(true, data);
                        },
                        error: (error, stackTrace) => Text(''
                            '$error'),
                        loading: () {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40,),
                            height: 500,
                            width: double.infinity,
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3.2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                     CustomShimmer(width: 80, height: 80, borderRadius: 40,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                         CustomShimmer(width: 150, height: 18, borderRadius: 5,),
                                          SizedBox(height: 4,),
                                          CustomShimmer(width: 80, height: 15, borderRadius: 5,),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ) : SliverToBoxAdapter(
                      child: Container(
                        height: 400,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: const Center(
                          child: Text('Feature Coming Soon!!!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ),
                    buildBody()
                  ],
                ),
                drawer: SafeArea(
                  child: Drawer(
                    child: ListView(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: ColorManager.drawerPrimary
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/khata-logo-name.png",
                                ),
                                const SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: ColorManager.drawerSecondary,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Icon(Icons.person, color: Colors.white, size: 50,),
                                      ),
                                      const SizedBox(width: 20,),
                                      const Text('Username', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),)
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                        const SizedBox(height: 10,),
                        ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalReminderPage(),));
                          },
                          title: const Text('POS', style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 18,
                          ),
                          ),
                          leading: Icon(Icons.point_of_sale_rounded, size: 28,
                            color: ColorManager.iconGray,),
                        ),
                        ListTile(
                          onTap: (){
                            Navigator.pop(context, true);
                            Fluttertoast.showToast(
                              msg: 'Feature Coming Soon!!!',
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: ColorManager.primary.withOpacity(0.9),
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
                          title: const Text('POS', style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 18,
                          ),
                          ),
                          leading: Icon(Icons.point_of_sale_rounded, size: 28,
                            color: ColorManager.iconGray,),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context,true);
                            LauncherUtils.launchPolicyUrl();
                          },
                          title: const Text('Privacy Policy', style: TextStyle(
                            fontFamily: 'Ubuntu', fontSize: 18,),),
                          leading: Icon(Icons.logout, size: 28,
                            color: ColorManager.iconGray,),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context,true);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UserLoginView()));
                          },
                          title: const Text('Logout', style: TextStyle(
                            fontFamily: 'Ubuntu', fontSize: 18,),),
                          leading: Icon(Icons.logout, size: 28,
                            color: ColorManager.iconGray,),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }


  Widget buildDashBoard(bool isLandscape, List<Map<String, dynamic>> dashData) {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 40,),
      height: 500,
      width: double.infinity,

      child: isLandscape ? GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3.2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dashModel.length,
        itemBuilder: (context, index) {
          final dashItem = dashData[index];
          final item = dashModel[index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: isLandscape ? 12 : 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(248, 248, 253, 1),
                  offset: Offset(
                    0.0,
                    0.0,
                  ),
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: isLandscape ? 35 : 40,
                  backgroundColor: const Color(0xffF8F8FE),
                  child: CircleAvatar(
                    radius: isLandscape ? 28 : 32,
                    backgroundColor: const Color(0xffE1E4FB),
                    child: Center(
                      child: Icon(
                        item.iconData,
                        color: ColorManager.primary,
                        size: isLandscape ? 40 : 46,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: isLandscape ? 10 : 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text('Rs. ', style: TextStyle(color: ColorManager.errorRed, fontFamily: 'Ubuntu',fontSize: 18,fontWeight: FontWeight.w600,),),
                        Countup(
                          begin: 0,
                          end: displayBalance(dashItem["total"]),
                          duration: const Duration(seconds: 3),
                          separator: ',',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Text(displayAmountType(dashItem["total"]),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      dashItem["nature"],
                      style: const TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff7B7E81),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ) : ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dashModel.length,
        itemBuilder: (context, index) {
          final dashItem = dashData[index];
          final item = dashModel[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(248, 248, 253, 1),
                  offset: Offset(
                    0.0,
                    0.0,
                  ),
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color(0xffF8F8FE),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xffE1E4FB),
                    child: Center(
                      child: Icon(
                        item.iconData,
                        color: ColorManager.primary,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Rs.', style: TextStyle(color: ColorManager.errorRed, fontFamily: 'Ubuntu',fontSize: 20,fontWeight: FontWeight.bold,),),
                          const SizedBox(width: 10,),
                          Countup(
                            begin: 0,
                            end: displayBalance(dashItem["total"]),
                            duration: const Duration(seconds: 2),
                            separator: ',',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Text(displayAmountType(dashItem["total"]),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        dashItem["nature"],
                        style: const TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff7B7E81),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildBody(){
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            height: 200,
          ),
          Container(
            height: 100,
          ),
        ],
      ),
    );
  }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String companyName;
  final String branchName;
  final String fiscalYear;
  final bool isLandScape;

  const CustomSliverAppBarDelegate(this.companyName, this.branchName, this.fiscalYear, this.isLandScape, {
    required this.expandedHeight,
    required this.scaffoldKey
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent,) {
    final deviceSize = MediaQuery.of(context).size;
    const size = 60;
    final top = expandedHeight - shrinkOffset - size / (isLandScape ? 3 : 2);

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        buildAppBar(shrinkOffset),
        buildBackground(shrinkOffset, context, scaffoldKey),
        Positioned(
          top: top,
          left: isLandScape ? deviceSize.width * 0.12 : 35,
          right: isLandScape ? deviceSize.width * 0.12 : 35,
          child: buildFloating(shrinkOffset),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(double shrinkOffset) => Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorManager.primary,
          title:  Text(branchName,style: TextStyle(fontSize: isLandScape ? 22 : 18),),
          toolbarHeight: isLandScape ? 50 : 90,
          actions: [
            InkWell(
              onTap: () => scaffoldKey.currentState?.openDrawer(),
              child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Image.asset('assets/icons/icon_menu-left.png', height: 36, width: 36,),
              ),
            ),
          ],
        ),
      );

  Widget buildBackground(double shrinkOffset, BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Container(
          decoration: BoxDecoration(
              color: ColorManager.primary,
            ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
            child: ListView(
              children: [
                SizedBox(
                  height: isLandScape ? 5 : 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      companyName,
                      style: TextStyle(
                          fontSize: isLandScape ? 18 : 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        height: 1.5
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                      child: SizedBox(
                        height: 36,
                        width: 36,
                        child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Image.asset('assets/icons/icon_menu-left.png', fit: BoxFit.cover,)),
                      ),
                    ),
                  ],
                ),
                 Text(branchName, style: TextStyle(fontSize: isLandScape ? 16 : 18, fontWeight: FontWeight.w500, color: Colors.white),),
                 const SizedBox(height: 5,),
                 Text(fiscalYear, style: TextStyle(fontSize: isLandScape ? 14 : 16, fontWeight: FontWeight.w400,color: Colors.white),),
              ],
            ),
          ),
        ),
      );

  Widget buildFloating(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Consumer(
          builder: (context, ref, child) {
            return Container(
              height: isLandScape ? 40: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: const Offset(1.0, 2.0),
                      blurRadius: 5.0,
                    )
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: buildButton(
                      text: 'Financial',
                      onPressed: () {
                        ref.read(dashBoardTypeProvider.notifier).changeDashboardType('Financial');
                      },
                    ),
                  ),
                  const SizedBox(width: 5,),
                  const Text(
                    '|',
                    style: TextStyle(fontSize: 30, color: Colors.grey),
                  ),
                  Expanded(
                    child: buildButton(
                      text: 'Inventory',
                      onPressed: () {
                        ref.read(dashBoardTypeProvider.notifier).changeDashboardType('Inventory');
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

  Widget buildButton({required String text, required VoidCallback onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }


  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}




/// function that checks for positive and negative integers
double displayBalance(dynamic total){
  if(total < 0){
    return total.abs().toDouble();
  }else if(total > 0){
    return total.toDouble();
  }else{
    return total.toDouble();
  }
}


String displayAmountType(dynamic total){
  if(total > 0){
    return 'Dr';
  }else if(total < 0){
    return 'Cr';
  }else{
    return '';
  }
}