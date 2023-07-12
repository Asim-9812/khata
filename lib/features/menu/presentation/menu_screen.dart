import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khata_app/common/shimmer_loading.dart';
import 'package:khata_app/features/menu/presentation/submenu_page.dart';

import '../../../common/colors.dart';
import '../model/menu_model.dart';
import '../provider/menu_provider.dart';
import '../../dashboard/presentation/home_screen.dart';

class ReportView extends ConsumerWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    final menuData = ref.watch(menuProvider(userId));
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorManager.primary,
              centerTitle: true,
              shadowColor: Colors.black.withOpacity(0.25),
              title: const Text('Reports'),
              titleTextStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              toolbarHeight: 90,
            ),
            body: SafeArea(
              child: menuData.when(
                data: (data) {
                  List<MenuModel> mainList = <MenuModel>[];
                  List<MenuModel> homeChildList = <MenuModel>[];
                  List<MenuModel> auditChildList = <MenuModel>[];
                  List<MenuModel> reportChildList = <MenuModel>[];
                  List<MenuModel> logChildList = <MenuModel>[];
                  List<MenuModel> financialChildList = <MenuModel>[];
                  List<MenuModel> irdChildList = <MenuModel>[];
                  List<MenuModel> registerChildList = <MenuModel>[];
                  List<MenuModel> statementChildList = <MenuModel>[];
                  List<MenuModel> inventoryChildList = <MenuModel>[];

                  for (final e in data) {
                    if (e.parentID == 1) {
                      homeChildList.add(e);
                      mainList.add(e);
                    } else if (e.parentID == 4) {
                      auditChildList.add(e);
                      mainList.add(e);
                    } else if (e.parentID == 5) {
                      reportChildList.add(e);
                      mainList.add(e);
                    } else if (e.parentID == 8) {
                      logChildList.add(e);
                      mainList.add(e);
                    } else if (e.parentID == 64) {
                      financialChildList.add(e);
                    } else if (e.parentID == 69) {
                      irdChildList.add(e);
                    } else if (e.parentID == 73) {
                      registerChildList.add(e);
                    } else if (e.parentID == 82) {
                      statementChildList.add(e);
                    } else if (e.parentID == 95) {
                      inventoryChildList.add(e);
                    }
                  }

                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                ),
                        itemCount: mainList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if(mainList[index].intMenuid == 64){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubMenuView(submenu: financialChildList, menuInfo: mainList[index]),));
                              }else if(mainList[index].intMenuid == 69){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubMenuView(submenu: irdChildList, menuInfo: mainList[index]),));
                              }else if(mainList[index].intMenuid == 73){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubMenuView(submenu: registerChildList, menuInfo: mainList[index]),));
                              }else if(mainList[index].intMenuid == 82){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubMenuView(submenu: statementChildList, menuInfo: mainList[index]),));
                              }else if(mainList[index].intMenuid == 95){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubMenuView(submenu: inventoryChildList, menuInfo: mainList[index]),));
                              }else{
                                Fluttertoast.showToast(
                                  msg: 'Feature Coming Soon!!!',
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: ColorManager.primary.withOpacity(0.9),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
                            child: Container(
                                height: 90,
                                width: 50,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          offset: const Offset(1, 2),
                                          blurRadius: 1,
                                      ),
                                    ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _setMenu(mainList[index].intMenuid),
                                    Text(mainList[index].strName.trim(),
                                        style: const TextStyle(fontSize: 15),
                                        textAlign: TextAlign.center),
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
                  );

                },
                error: (error, stackTrace) => Center(child: Text('$error', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                loading: () {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const CustomShimmer(width: 50, height: 90, borderRadius: 10,);
                      },
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorManager.primary,
              centerTitle: true,
              shadowColor: Colors.black.withOpacity(0.25),
              title: const Text('Reports'),
              titleTextStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              toolbarHeight: 90,
            ),
            body: SafeArea(
              child: menuData.when(
                data: (data) {
                  List<MenuModel> mainList = <MenuModel>[];
                  List<MenuModel> homeChildList = <MenuModel>[];
                  List<MenuModel> auditChildList = <MenuModel>[];
                  List<MenuModel> reportChildList = <MenuModel>[];
                  List<MenuModel> logChildList = <MenuModel>[];
                  List<MenuModel> financialChildList = <MenuModel>[];
                  List<MenuModel> irdChildList = <MenuModel>[];
                  List<MenuModel> registerChildList = <MenuModel>[];
                  List<MenuModel> statementChildList = <MenuModel>[];
                  List<MenuModel> inventoryChildList = <MenuModel>[];

                  for (final e in data) {
                    if (e.parentID == 1) {
                      homeChildList.add(e);
                      mainList.add(e);
                    } else if (e.parentID == 4) {
                      auditChildList.add(e);
                      mainList.add(e);
                    } else if (e.parentID == 5) {
                      reportChildList.add(e);
                      mainList.add(e);
                    } else if (e.parentID == 8) {
                      logChildList.add(e);
                      mainList.add(e);
                    } else if (e.parentID == 64) {
                      financialChildList.add(e);
                    } else if (e.parentID == 69) {
                      irdChildList.add(e);
                    } else if (e.parentID == 73) {
                      registerChildList.add(e);
                    } else if (e.parentID == 82) {
                      statementChildList.add(e);
                    } else if (e.parentID == 95) {
                      inventoryChildList.add(e);
                    }
                  }

                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          mainAxisExtent: 100
                        ),
                        itemCount: mainList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if(mainList[index].intMenuid == 64){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubMenuView(submenu: financialChildList, menuInfo: mainList[index]),));
                              }else if(mainList[index].intMenuid == 69){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubMenuView(submenu: irdChildList, menuInfo: mainList[index]),));
                              }else if(mainList[index].intMenuid == 73){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubMenuView(submenu: registerChildList, menuInfo: mainList[index]),));
                              }else if(mainList[index].intMenuid == 82){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubMenuView(submenu: statementChildList, menuInfo: mainList[index]),));
                              }else if(mainList[index].intMenuid == 95){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubMenuView(submenu: inventoryChildList, menuInfo: mainList[index]),));
                              }else{
                                Fluttertoast.showToast(
                                  msg: 'Feature Coming Soon!!!',
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: ColorManager.primary.withOpacity(0.9),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
                            child: Container(
                                height: 80,
                                width: 50,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      offset: const Offset(1, 2),
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _setMenu(mainList[index].intMenuid),
                                    Text(mainList[index].strName.trim(),
                                        style: const TextStyle(fontSize: 15),
                                        textAlign: TextAlign.center),
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
                  );

                },
                error: (error, stackTrace) => Center(child: Text('$error', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                loading: () {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const CustomShimmer(width: 50, height: 90, borderRadius: 10,);
                      },
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  FaIcon _setMenu(int id) {
    if (id == 9) {
      return FaIcon(
        FontAwesomeIcons.solidCalendar,
        size: 34,
        color: ColorManager.primary,
      );
    }else if (id == 64) {
      return FaIcon(
        FontAwesomeIcons.coins,
        size: 34,
        color: ColorManager.primary,
      );
    } else if (id == 69) {
      return FaIcon(
        FontAwesomeIcons.arrowTrendUp,
        size: 34,
        color: ColorManager.primary,
      );
    } else if (id == 73) {
      return FaIcon(
        FontAwesomeIcons.cashRegister,
        size: 34,
        color: ColorManager.primary,
      );
    } else if (id == 82) {
      return FaIcon(
        FontAwesomeIcons.clipboard,
        size: 34,
        color: ColorManager.primary,
      );
    } else if (id == 95) {
      return FaIcon(
        FontAwesomeIcons.warehouse,
        size: 34,
        color: ColorManager.primary,
      );
    } else if (id == 144) {
      return FaIcon(
        FontAwesomeIcons.percent,
        size: 34,
        color: ColorManager.primary,
      );
    } else if (id == 164) {
      return FaIcon(
        FontAwesomeIcons.fileInvoiceDollar,
        size: 34,
        color: ColorManager.primary,
      );
    } else {
      return FaIcon(
        FontAwesomeIcons.arrowRightToBracket,
        size: 34,
        color: ColorManager.primary,
      );
    }
  }
}
