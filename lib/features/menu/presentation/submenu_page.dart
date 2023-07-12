import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khata_app/features/reports/Register/voucher_report/presentation/voucher_report.dart';
import 'package:khata_app/features/reports/financial/balance_sheet/presentation/balance_sheet_report.dart';
import 'package:khata_app/features/reports/financial/profit_loss/presentation/profit_loss_report.dart';
import 'package:khata_app/features/reports/financial/trial_balance/presentation/trial_balance_report.dart';
import 'package:khata_app/features/reports/statement/customer_ledger_report/presentation/customer_ledger_report.dart';

import '../../../common/colors.dart';
import '../../reports/statement/ledger_report/presentation/report_page.dart';
import '../../reports/statement/supplier_ledger_report/presentation/supplier_ledger_report.dart';
import '../model/menu_model.dart';


class SubMenuView extends StatelessWidget {
  const SubMenuView({Key? key, required this.submenu, required this.menuInfo}) : super(key: key);
  final MenuModel menuInfo;
  final List<MenuModel> submenu;
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if(orientation == Orientation.portrait){
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorManager.primary,
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 28,)
              ),
              title: Text(menuInfo.strName.trim()),
              titleTextStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              toolbarHeight: 90,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 110
                      ),
                      itemCount: submenu.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if(submenu[index].intMenuid == 85){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReportPageView()));
                            }else if(submenu[index].intMenuid == 87){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerLedgerReport()));
                            } else if(submenu[index].intMenuid == 88){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SupplierLedgerReport()));
                            }else if(submenu[index].intMenuid == 67){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const BalanceSheetReportPage(),));
                            } else if(submenu[index].intMenuid == 66){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const TrialBalanceReport(),));
                            }else if(submenu[index].intMenuid == 65){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfitLossReport()));
                            } else if(submenu[index].intMenuid == 151){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const VoucherReportPage()));
                            }else{
                              Fluttertoast.showToast(
                                msg: 'Feature Coming Soon!!!',
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: ColorManager.primary.withOpacity(0.9),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          },
                          child: Container(
                              width: 50,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color(0xfff7f7f7),
                                      width: 1.2,
                                      strokeAlign: BorderSide.strokeAlignInside
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _subMenuIcon(submenu[index].intMenuid),
                                  Text(submenu[index].strName.trim(), textAlign: TextAlign.center),
                                ],
                              )
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }else{
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorManager.primary,
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 28,)
              ),
              title: Text(menuInfo.strName.trim()),
              titleTextStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              toolbarHeight: 90,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 110
                        ),
                        itemCount: submenu.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if(submenu[index].intMenuid == 85){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReportPageView()));
                              }else if(submenu[index].intMenuid == 87){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerLedgerReport()));
                              }else if(submenu[index].intMenuid == 88){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SupplierLedgerReport()));
                              }else if(submenu[index].intMenuid == 67){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const BalanceSheetReportPage(),));
                              } else if(submenu[index].intMenuid == 66){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const TrialBalanceReport(),));
                              }else if(submenu[index].intMenuid == 65){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfitLossReport()));
                              }
                              else{
                                Fluttertoast.showToast(
                                  msg: 'Feature Coming Soon!!!',
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: ColorManager.primary.withOpacity(0.9),
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
                            child: Container(
                                width: 50,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: const Color(0xfff7f7f7),
                                        width: 1.2,
                                        strokeAlign: BorderSide.strokeAlignInside
                                    )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _subMenuIcon(submenu[index].intMenuid),
                                    Text(submenu[index].strName.trim(), textAlign: TextAlign.center),
                                  ],
                                )
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }


  FaIcon _subMenuIcon(int id){
    int menuId = id;

    switch(menuId){
      case 65:
        return FaIcon(FontAwesomeIcons.chartLine, size: 34, color: ColorManager.menuIcon,);
      case 66:
        return FaIcon(FontAwesomeIcons.sackDollar, size: 34, color: ColorManager.menuIcon,);
      case 67:
        return FaIcon(FontAwesomeIcons.moneyBillTrendUp, size: 34, color: ColorManager.menuIcon);
      case 70:
        return FaIcon(FontAwesomeIcons.barsProgress, size: 34, color: ColorManager.menuIcon);
      case 71:
        return FaIcon(FontAwesomeIcons.fileLines, size: 34, color: ColorManager.menuIcon);
      case 72:
        return FaIcon(FontAwesomeIcons.fileInvoice, size: 34, color: ColorManager.menuIcon);
      case 151:
        return FaIcon(FontAwesomeIcons.fileImport, size: 34, color: ColorManager.menuIcon);
      case 160:
        return FaIcon(FontAwesomeIcons.fileWaveform, size: 34, color: ColorManager.menuIcon);
      case 161:
        return FaIcon(FontAwesomeIcons.fileExport, size: 34, color: ColorManager.menuIcon);
      case 162:
        return FaIcon(FontAwesomeIcons.fileArrowDown, size: 34, color: ColorManager.menuIcon);
      case 74:
        return FaIcon(FontAwesomeIcons.book, size: 34, color: ColorManager.menuIcon);
      case 75:
        return FaIcon(FontAwesomeIcons.filePen, size: 34, color: ColorManager.menuIcon);
      case 76:
        return FaIcon(FontAwesomeIcons.receipt, size: 34, color: ColorManager.menuIcon);
      case 77:
        return FaIcon(FontAwesomeIcons.creditCard, size: 34, color: ColorManager.menuIcon);
      case 78:
        return FaIcon(FontAwesomeIcons.moneyCheck, size: 34, color: ColorManager.menuIcon);
      case 79:
        return FaIcon(FontAwesomeIcons.moneyCheckDollar, size: 34, color: ColorManager.menuIcon);
      case 80:
        return FaIcon(FontAwesomeIcons.fileCirclePlus, size: 34, color: ColorManager.menuIcon);
      case 81:
        return FaIcon(FontAwesomeIcons.rightLeft, size: 34, color: ColorManager.menuIcon);
      case 216:
        return FaIcon(FontAwesomeIcons.fileExcel, size: 34, color: ColorManager.menuIcon);
      case 85:
        return FaIcon(FontAwesomeIcons.bookOpenReader, size: 34, color: ColorManager.menuIcon);
      case 86:
        return FaIcon(FontAwesomeIcons.peopleGroup, size: 34, color: ColorManager.menuIcon);
      case 83:
        return FaIcon(FontAwesomeIcons.bookJournalWhills, size: 34, color: ColorManager.menuIcon);
      case 84:
        return FaIcon(FontAwesomeIcons.buildingColumns, size: 34, color: ColorManager.menuIcon);
      case 87:
        return FaIcon(FontAwesomeIcons.fileInvoice, size: 34, color: ColorManager.menuIcon);
      case 88:
        return FaIcon(FontAwesomeIcons.boxesPacking, size: 34, color: ColorManager.menuIcon);
      case 89:
        return FaIcon(FontAwesomeIcons.chartColumn, size: 34, color: ColorManager.menuIcon);
      case 90:
        return FaIcon(FontAwesomeIcons.chartArea, size: 34, color: ColorManager.menuIcon);
      case 91:
        return FaIcon(FontAwesomeIcons.filePrescription, size: 34, color: ColorManager.menuIcon);
      case 92:
        return FaIcon(FontAwesomeIcons.bagShopping, size: 34, color: ColorManager.menuIcon);
      case 93:
        return FaIcon(FontAwesomeIcons.file, size: 34, color: ColorManager.menuIcon);
      case 94:
        return FaIcon(FontAwesomeIcons.fileCircleCheck, size: 34, color: ColorManager.menuIcon);
      case 163:
        return FaIcon(FontAwesomeIcons.moneyBillWave, size: 34, color: ColorManager.menuIcon);
      case 96:
        return FaIcon(FontAwesomeIcons.boxesStacked, size: 34, color: ColorManager.menuIcon);
      case 97:
        return FaIcon(FontAwesomeIcons.cartFlatbed, size: 34, color: ColorManager.menuIcon);
      case 98:
        return FaIcon(FontAwesomeIcons.boxesPacking, size: 34, color: ColorManager.menuIcon);
      case 99:
        return FaIcon(FontAwesomeIcons.productHunt, size: 34, color: ColorManager.menuIcon);
      case 100:
        return FaIcon(FontAwesomeIcons.clock, size: 34, color: ColorManager.menuIcon);
      case 101:
        return FaIcon(FontAwesomeIcons.inbox, size: 34, color: ColorManager.menuIcon);
      case 158:
        return FaIcon(FontAwesomeIcons.boxOpen, size: 34, color: ColorManager.menuIcon);
      default:
        return FaIcon(FontAwesomeIcons.adn, size: 34, color: ColorManager.menuIcon);
    }

  }


}
