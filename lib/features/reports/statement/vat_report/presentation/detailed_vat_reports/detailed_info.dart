import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:khata_app/features/reports/statement/ledger_report/provider/report_provider.dart';
import 'package:khata_app/features/reports/statement/vat_report/model/vat_report_model.dart';
import 'package:khata_app/features/reports/statement/vat_report/provider/vat_provider.dart';
import 'package:khata_app/features/reports/statement/vat_report/widgets/vatRow.dart';
import 'package:khata_app/model/filter%20model/data_filter_model.dart';
import 'package:khata_app/model/filter%20model/filter_any_model.dart';
import 'package:khata_app/model/list%20model/get_list_model.dart';
import 'package:khata_app/features/dashboard/presentation/home_screen.dart';
import 'package:pager/pager.dart';
import '../../../../../../../common/colors.dart';
import '../../../../../../main.dart';
import '../../../../common_widgets/build_report_table.dart';


class DetailedVatReport extends StatefulWidget {
  final String branchId;
  final String dateFrom;
  final String dateTo;
  final int voucherTypeId;
  DetailedVatReport({required this.voucherTypeId,required this.branchId,required this.dateTo,required this.dateFrom});

  @override
  State<DetailedVatReport> createState() => _DetailedVatReportState();
}

class _DetailedVatReportState extends State<DetailedVatReport> {
  late int _currentPage;
  late int _rowPerPage;
  List<int> rowPerPageItems = [5, 10, 15, 20, 25, 50];
  late int _totalPages;
  late MainInfoModel2 vatReportMainInfo;

  @override
  void initState() {
    super.initState();
    _currentPage = 1;
    _rowPerPage = 10;
    _totalPages = 0;
  }

  @override
  Widget build(BuildContext context) {

    var result = sessionBox.get('userReturn');
    var res = jsonDecode(result);

    String selectedBranch = branchBox.get('selectedBranch');
    int branchId = branchBox.get('selectedBranchId');
    final branchDepartmentId = branchBox.get('selectedBranchDepId');



    userId = "${res["userReturn"]["intUserId"]}-${res["ownerCompanyList"]["databaseName"]}";

    String companyName = res["ownerCompanyList"]["companyName"];
    String fiscalYear = res["fiscalYearInfo"]["fiscalYear"];

    vatReportMainInfo = MainInfoModel2(
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
      id: widget.voucherTypeId
    );

    return Consumer(
      builder: (context, ref, child) {
        final res = ref.watch(vatReportDetailProvider);
        DataFilterModel filterModel = DataFilterModel();
        filterModel.tblName = "VatReport";
        filterModel.strName = "";
        filterModel.underColumnName = null;
        filterModel.underIntID = 0;
        filterModel.columnName = null;
        filterModel.filterColumnsString =
        "[\"${widget.branchId}\",\"${widget.dateFrom}\",\"${widget.dateTo}\"]";
        filterModel.pageRowCount = _rowPerPage;
        filterModel.currentPageNumber = _currentPage;
        filterModel.strListNames = "";

        FilterAnyModel2 fModel = FilterAnyModel2();
        fModel.dataFilterModel = filterModel;
        fModel.mainInfoModel = vatReportMainInfo;

        return WillPopScope(
          onWillPop: () async {
            ref.invalidate(vatReportDetailProvider);

            // Return true to allow the back navigation, or false to prevent it
            return true;
          },
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: ColorManager.primary,
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    ref.invalidate(vatReportDetailProvider);
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                title: const Text('Vat Report'),
                titleTextStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                toolbarHeight: 70,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black.withOpacity(0.7),
                                          ),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(
                                        child: Text(widget.dateFrom,style: const TextStyle(color: Colors.black),),),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black.withOpacity(0.7),
                                          ),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(
                                        child: Text(widget.dateTo,style: const TextStyle(color: Colors.black),),),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  ref.read(vatReportDetailProvider.notifier).getTableValues2(fModel);


                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.green,
                                  minimumSize: const Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.arrowsRotate,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        res.when(
                          data: (data) {
                            List<VatReportDetailModel> newList = <VatReportDetailModel>[];
                            List<String> reportTotal = <String>[];
                            if (data.isNotEmpty) {
                              for (var e in data) {
                                newList.add(VatReportDetailModel.fromJson(e));
                              }
                            } else {
                              return Container();
                            }

                            print(newList);
                            return SizedBox(
                              width: double.infinity,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DataTable(
                                      columns: [
                                        buildDataColumn(
                                            60, 'S.N', TextAlign.start),
                                        buildDataColumn(200, 'Invoice Date',
                                            TextAlign.start),
                                        buildDataColumn(
                                            200, 'Total Amount', TextAlign.start),
                                        buildDataColumn(
                                            160, 'Total Taxable Amount', TextAlign.end),
                                        buildDataColumn(
                                            160, 'Debit (Dr)', TextAlign.end),
                                        buildDataColumn(160, 'Credit (Cr)',
                                            TextAlign.end),
                                      ],
                                      rows: List.generate(
                                        newList.length,
                                            (index) => buildVatDetailRow(index, newList[index], context),
                                      ),
                                      columnSpacing: 0,
                                      horizontalMargin: 0,
                                    ),
                                    /// Pager package used for pagination
                                    _totalPages == 0 ? const Text('No records to show', style: TextStyle(fontSize: 16, color: Colors.red),) : Pager(
                                      currentItemsPerPage: _rowPerPage,
                                      currentPage: _currentPage,
                                      totalPages: _totalPages,
                                      onPageChanged: (page) {
                                        _currentPage = page;
                                        /// updates current page number of filterModel, because it does not update on its own
                                        fModel.dataFilterModel!.currentPageNumber = _currentPage;
                                        ref.read(vatReportProvider.notifier).getTableValues2(fModel);
                                      },
                                      showItemsPerPage: true,
                                      onItemsPerPageChanged: (itemsPerPage) {
                                        _rowPerPage = itemsPerPage;
                                        _currentPage = 1;
                                        /// updates row per page of filterModel, because it does not update on its own
                                        fModel.dataFilterModel!.pageRowCount = _rowPerPage;
                                        ref.read(tableDataProvider.notifier).getTableValues2(fModel);
                                      },
                                      itemsPerPageList: rowPerPageItems,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          error: (error, stackTrace) =>
                              Center(child: Text('$error')),
                          loading: () => const Center(
                              child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
