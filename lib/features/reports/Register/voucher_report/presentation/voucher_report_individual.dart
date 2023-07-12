import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_app/features/dashboard/presentation/home_screen.dart';
import 'package:khata_app/features/reports/Register/voucher_report/model/voucher_individual_report_model.dart';
import 'package:khata_app/features/reports/Register/voucher_report/provider/voucher_individual_report_provider.dart';
import 'package:khata_app/features/reports/Register/voucher_report/widget/tbl_widgets.dart';
import 'package:khata_app/model/filter%20model/data_filter_model.dart';
import 'package:khata_app/model/filter%20model/filter_any_model.dart';

import '../../../../../common/export.dart';



class VoucherReportIndividual extends StatelessWidget {
  final int masterId;
  const VoucherReportIndividual({Key? key, required this.masterId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DataFilterModel filterModel = DataFilterModel();
    filterModel.tblName = "VoucherReport--VoucherReportIndividualDetail";
    filterModel.strName = "";
    filterModel.underColumnName = null;
    filterModel.underIntID = 0;
    filterModel.columnName = null;
    filterModel.filterColumnsString = "[\"MasterId--$masterId\"]";
    filterModel.pageRowCount = 10;
    filterModel.currentPageNumber = 1;
    filterModel.strListNames = "";

    FilterAnyModel fModel = FilterAnyModel();
    fModel.dataFilterModel = filterModel;
    fModel.mainInfoModel = mainInfo;

    return Consumer(
      builder: (context, ref, child){
        final voucherData = ref.watch(voucherIndividualReportProvider(fModel));
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.primary,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 28,
                color: Colors.white,
              ),
            ),
            title: const Text('Purchase Details'),
            titleTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            toolbarHeight: 70,
          ),
          body: voucherData.when(data: (data) {
            List<VoucherIndividualReportModel> tableData = <VoucherIndividualReportModel>[];
            if (data.isNotEmpty) {
              for (var e in data[0]) {
                tableData.add(VoucherIndividualReportModel.fromJson(e));
              }
            }else{
              return Container(
                width: double.infinity,
                color: Colors.blue.shade50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: const TextSpan(
                                children: [
                                  TextSpan(text: 'Voucher No.:  ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)),
                                  TextSpan(text: '', style: TextStyle(fontSize: 16, color: Colors.black )),
                                ]
                            ),
                          ),
                          RichText(
                            text: const TextSpan(
                                children: [
                                  TextSpan(text: 'Date: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
                                  TextSpan(text: '', style: TextStyle(fontSize: 16, color: Colors.black)),
                                ]
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30,),
                      DataTable(
                        columns: [
                          voucherReportDataColumn(80, 'S.N', TextAlign.start),
                          voucherReportDataColumn(200, 'Account Ledger', TextAlign.start),
                          voucherReportDataColumn(150, 'Dr Amt.', TextAlign.start),
                          voucherReportDataColumn(150, 'Cr Amt.', TextAlign.start),
                          voucherReportDataColumn(150, 'Cheq. No.', TextAlign.start),
                          voucherReportDataColumn(150, 'Cheq. Date', TextAlign.start),
                          voucherReportDataColumn(150, 'Narration', TextAlign.start),
                        ],
                        rows: const [],
                        columnSpacing: 0,
                        horizontalMargin: 0,
                      ),
                    ],
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            children: [
                              const TextSpan(text: 'Voucher No.:  ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)),
                              TextSpan(text: '${data[1]["voucherNo"]}', style: const TextStyle(fontSize: 16, color: Colors.black )),
                            ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            children: [
                              const TextSpan(text: 'Date: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
                              TextSpan(text: '${data[1]["voucherDate"]}', style: const TextStyle(fontSize: 16, color: Colors.black)),
                            ]
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8,),
                  RichText(
                    text: TextSpan(
                        children: [
                          const TextSpan(text: 'Ref No.:  ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                          TextSpan(text: '${data[1]["refNo"]}', style: const TextStyle(fontSize: 16, color: Colors.black )),
                        ]
                    ),
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(
                    width: double.infinity,
                    child:  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      child: DataTable(
                        columns: [
                          voucherReportDataColumn(50, 'S.N', TextAlign.start),
                          voucherReportDataColumn(300, 'Account Ledger', TextAlign.start),
                          voucherReportDataColumn(150, 'Dr Amt.', TextAlign.start),
                          voucherReportDataColumn(150, 'Cr Amt.', TextAlign.start),
                          voucherReportDataColumn(150, 'Cheq. No.', TextAlign.start),
                          voucherReportDataColumn(150, 'Cheq. Date', TextAlign.start),
                          voucherReportDataColumn(150, 'Narration', TextAlign.start),
                        ],
                        rows: List.generate(tableData.length,  (index) => voucherReportIndividualRow(index, tableData[index])),
                        columnSpacing: 0,
                        horizontalMargin: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Divider(thickness: 1.5,),
                  const SizedBox(height: 20,),
                  RichText(
                    text: TextSpan(
                        children: [
                          const TextSpan(text: 'Narration:  ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                          TextSpan(text: '${data[1]["narration"]}', style: const TextStyle(fontSize: 16, color: Colors.black )),
                        ]
                    ),
                  ),
                  const SizedBox(height: 10,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     RichText(
                       text: TextSpan(
                           children: [
                             const TextSpan(text: 'Dr: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                             TextSpan(text: '${data[1]["drSum"]}', style: const TextStyle(fontSize: 16, color: Colors.black)),
                           ]
                       ),
                     ),
                     RichText(
                       text: TextSpan(
                           children: [
                             const TextSpan(text: 'Cr: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
                             TextSpan(text: '${data[1]["crSum"]}', style: const TextStyle(fontSize: 16, color: Colors.black)),
                           ]
                       ),
                     )
                   ],
                 )
                ],
              ),
            );
          },
            error: (error, stackTrace) => Center(child: Text('$error'),),
            loading: () => Center(
                child: Image.asset("assets/gif/loading-img2.gif", height: 120, width: 120,)
            ),
          ),
        );
      }
    );

  }
}
