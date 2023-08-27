import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:khata_app/common/shimmer_loading.dart';
import 'package:khata_app/features/reports/common_widgets/date_input_formatter.dart';
import 'package:khata_app/features/reports/statement/customer_ledger_report/model/customer_ledger_report_model.dart';
import 'package:khata_app/features/reports/statement/customer_ledger_report/provider/customer_ledger_report_provider.dart';
import 'package:khata_app/features/reports/statement/daybook_report/model/daybook_model.dart';
import 'package:khata_app/features/reports/statement/daybook_report/model/daybook_model.dart';
import 'package:khata_app/features/reports/statement/daybook_report/model/daybook_model.dart';
import 'package:khata_app/features/reports/statement/daybook_report/provider/daybook_report_provider.dart';
import 'package:khata_app/features/reports/statement/ledger_report/provider/report_provider.dart';
import 'package:khata_app/model/filter%20model/data_filter_model.dart';
import 'package:khata_app/model/filter%20model/filter_any_model.dart';
import 'package:khata_app/model/list%20model/get_list_model.dart';
import 'package:khata_app/features/reports/statement/ledger_report/model/report_model.dart';
import 'package:khata_app/features/dashboard/presentation/home_screen.dart';
import 'package:pager/pager.dart';

import '../../../../../common/colors.dart';
import '../../../../../common/common_provider.dart';
import '../../../../../common/snackbar.dart';
import '../../../common_widgets/build_report_table.dart';
import '../widget/daybook_dataRow.dart';


class DayBookReport extends StatefulWidget {
  const DayBookReport({Key? key}) : super(key: key);

  @override
  State<DayBookReport> createState() => _DayBookReportState();
}

class _DayBookReportState extends State<DayBookReport> {
  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();
  late int _currentPage;
  late int _rowPerPage;
  List<int> rowPerPageItems = [5, 10, 15, 20, 25, 50];
  late int _totalPages;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _currentPage = 1;
    _rowPerPage = 10;
    _totalPages = 0;
  }

  @override
  Widget build(BuildContext context) {
    GetListModel modelRef = GetListModel();
    modelRef.refName = 'AccountLedgerReport';
    modelRef.isSingleList = 'false';
    modelRef.singleListNameStr = '';
    modelRef.listNameId = "['underGroup', 'mainLedger-${1}', 'mainBranch-${2}']";
    modelRef.mainInfoModel = mainInfo;
    modelRef.conditionalValues = '';

    return Consumer(
      builder: (context, ref, child) {
        final outCome = ref.watch(listProvider(modelRef));
        final res = ref.watch(dayBookProvider);
        return WillPopScope(
          onWillPop: () async {
            ref.invalidate(dayBookProvider);

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
                    ref.invalidate(dayBookProvider);
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                title: const Text('Day Book Report'),
                titleTextStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                toolbarHeight: 70,
              ),
              body: outCome.when(
                data: (data) {
                  List<Map<dynamic, dynamic>> allList = [];

                  for (var e in data) {
                    allList.add(e);
                  }

                  List<String> groups = ['All'];
                  List<String> ledgers = ['All'];
                  List<String> branches = ['All'];

                  data[0].forEach((key, _) {
                    groups.add(key);
                  });
                  data[1].forEach((key, _) {
                    ledgers.add(key);
                  });
                  data[2].forEach((key, _) {
                    branches.add(key);
                  });

                  String groupItem = groups[0];
                  String ledgerItem = ledgers[0];
                  String branchItem = branches[0];

                  final groupItemData = ref.watch(itemProvider).item;

                  final ledgerItemData = ref.watch(itemProvider).ledgerItem;
                  final updatedLedgerItemData = ref.watch(itemProvider).updateLedgerItem;

                  final branchItemData = ref.watch(itemProvider).branchItem;

                  GetListModel ledgerGroupListModel = GetListModel();
                  ledgerGroupListModel.refName = 'AccountLedgerReport';
                  ledgerGroupListModel.isSingleList = 'true';
                  ledgerGroupListModel.singleListNameStr = 'account';
                  ledgerGroupListModel.listNameId =
                  "['mainLedger-${data[0][groupItemData]}']";
                  ledgerGroupListModel.mainInfoModel = mainInfo;
                  ledgerGroupListModel.conditionalValues = '';

                  /// this function returns 'accountGroudId--' as required by the api and selected item
                  String groupValue(String val) {
                    if (val == "All") {
                      return 'accountGroudId--';
                    } else {
                      return 'accountGroudId--${data[0][groupItemData]}';
                    }
                  }

                  /// this function returns ledgerId according to the selected item from drop down
                  String getLedgerValue(String groupValue, String ledgerVal,
                      String updateLedgerVal) {
                    if (groupValue == "All" && ledgerVal == "All") {
                      return 'LedgerId--0';
                    } else if (groupValue == "All" && ledgerVal != "All") {
                      return 'LedgerId--${data[1][ledgerItemData]}';
                    } else if (groupValue != "All" && updateLedgerVal == "All") {
                      return 'LedgerId--0';
                    } else {
                      return 'LedgerId--${data[1][updatedLedgerItemData]}';
                    }

                  }

                  String getBranchValue(String branchVal) {
                    if (branchVal == "All") {
                      return 'BranchId--0';
                    } else {
                      return 'BranchId--${data[2][branchItemData]}';
                    }
                  }

                  String getCurrentDate(TextEditingController txt) {
                    if (txt.text.isEmpty) {
                      return 'currentDate--';
                    } else {
                      return 'currentDate--${txt.text.trim()}';
                    }
                  }

                  groupValue(groupItemData);
                  String isDetailed = _isChecked ? 'true' : 'false';
                  DataFilterModel filterModel = DataFilterModel();
                  filterModel.tblName = "DayBookReport";
                  filterModel.strName = "";
                  filterModel.underColumnName = null;
                  filterModel.underIntID = 0;
                  filterModel.columnName = null;
                  filterModel.filterColumnsString =
                  "[\"${getBranchValue(branchItemData)}\",\"${getCurrentDate(dateFrom)}\",\"voucherType--[\\\"3\\\",\\\"4\\\",\\\"5\\\",\\\"6\\\",\\\"7\\\",\\\"8\\\",\\\"9\\\",\\\"10\\\",\\\"11\\\",\\\"12\\\",\\\"13\\\",\\\"14\\\",\\\"15\\\",\\\"16\\\",\\\"17\\\",\\\"18\\\",\\\"19\\\",\\\"20\\\",\\\"21\\\",\\\"22\\\",\\\"23\\\",\\\"24\\\",\\\"25\\\",\\\"26\\\",\\\"27\\\",\\\"28\\\",\\\"29\\\",\\\"30\\\",\\\"31\\\",\\\"32\\\"]\",\"${getLedgerValue(groupItemData, ledgerItemData, updatedLedgerItemData)}\",\"isDetailed--$isDetailed\"]";
                  filterModel.pageRowCount = _rowPerPage;
                  filterModel.currentPageNumber = _currentPage;
                  filterModel.strListNames = "";

                  FilterAnyModel fModel = FilterAnyModel();
                  fModel.dataFilterModel = filterModel;
                  fModel.mainInfoModel = mainInfo;


                  return SafeArea(
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
                                  TextField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly,
                                      DateInputFormatter(),
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    controller: dateFrom,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.45),
                                              width: 1,
                                            )),
                                        contentPadding:
                                        const EdgeInsets.all(10),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: ColorManager.primary,
                                              width: 1,
                                            )),
                                        floatingLabelStyle: TextStyle(
                                            color: ColorManager.primary),
                                        labelText: 'Current Date',
                                        labelStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        alignLabelWithHint: true,
                                        suffixIcon: IconButton(
                                          onPressed: () async {
                                            DateTime? pickDate =
                                            await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime.now(),
                                            );
                                            if (pickDate != null) {
                                              setState(() {
                                                dateFrom.text =
                                                    DateFormat('yyyy/MM/dd')
                                                        .format(pickDate);
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.edit_calendar,
                                            size: 30,
                                            color: ColorManager.primary,
                                          ),
                                        )),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  DropdownSearch<String>(
                                    items: ledgers,
                                    selectedItem: ledgerItem,
                                    dropdownDecoratorProps:
                                    DropDownDecoratorProps(
                                      baseStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                      dropdownSearchDecoration:
                                      InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.45),
                                              width: 2,
                                            )),
                                        contentPadding:
                                        const EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: ColorManager.primary,
                                                width: 1)),
                                        floatingLabelStyle: TextStyle(
                                            color: ColorManager.primary),
                                        labelText: 'Ledger',
                                        labelStyle:
                                        const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    popupProps: const PopupProps.menu(
                                      showSearchBox: true,
                                      fit: FlexFit.loose,
                                      constraints:
                                      BoxConstraints(maxHeight: 250),
                                      showSelectedItems: true,
                                      searchFieldProps: TextFieldProps(
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    onChanged: (dynamic value) {
                                      ref
                                          .read(itemProvider)
                                          .updateLedger(value);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  DropdownSearch<String>(
                                    items: branches,
                                    selectedItem: branchItem,
                                    dropdownDecoratorProps:
                                    DropDownDecoratorProps(
                                      baseStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                      dropdownSearchDecoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color:
                                              Colors.black.withOpacity(0.45),
                                              width: 2,
                                            )),
                                        contentPadding: const EdgeInsets.all(15),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: ColorManager.primary,
                                                width: 1)),
                                        floatingLabelStyle: TextStyle(
                                            color: ColorManager.primary),
                                        labelText: 'Branch',
                                        labelStyle: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    popupProps: const PopupProps.menu(
                                      showSearchBox: true,
                                      fit: FlexFit.loose,
                                      constraints: BoxConstraints(maxHeight: 250),
                                      showSelectedItems: true,
                                      searchFieldProps: TextFieldProps(
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    onChanged: (dynamic value) {
                                      ref.read(itemProvider).updateBranch(value);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            _isChecked =!_isChecked;
                                          });
                                        },
                                        checkColor: Colors.white,
                                        fillColor:
                                        MaterialStateProperty.resolveWith(
                                                (states) =>
                                                getCheckBoxColor(states)),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                      const Text('Detailed',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if(dateFrom.text.isEmpty){
                                        final scaffoldMessage = ScaffoldMessenger.of(context);
                                        scaffoldMessage.showSnackBar(
                                          SnackbarUtil.showFailureSnackbar(
                                            message: 'Please pick a date',
                                            duration: const Duration(milliseconds: 1400),
                                          ),
                                        );
                                      }else{
                                        ref.read(dayBookProvider.notifier).getTableValues(fModel);
                                      }


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
                                if(_isChecked == false){
                                  List<DayBookModel> newList = <DayBookModel>[];
                                  if (data.isNotEmpty) {
                                    final tableReport = ReportData.fromJson(data[1]);
                                    _totalPages = tableReport.totalPages!;
                                    for (var e in data[0]) {
                                      newList.add(DayBookModel.fromJson(e));
                                    }
                                  } else {
                                    return Container();
                                  }
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
                                              buildDataColumn(200, 'Voucher No.',
                                                  TextAlign.start),
                                              buildDataColumn(
                                                  200, 'Ref No', TextAlign.start),
                                              buildDataColumn(
                                                  160, 'Voucher Type', TextAlign.end),
                                              buildDataColumn(
                                                  160, 'Amount', TextAlign.end),
                                              buildDataColumn(160, 'Narration',
                                                  TextAlign.end),
                                            ],
                                            rows: List.generate(
                                              newList.length,
                                                  (index) => buildDayBookReportRow(index, newList[index], allList, context),
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
                                              ref.read(dayBookProvider.notifier).getTableValues(fModel);
                                            },
                                            showItemsPerPage: true,
                                            onItemsPerPageChanged: (itemsPerPage) {
                                              _rowPerPage = itemsPerPage;
                                              _currentPage = 1;
                                              /// updates row per page of filterModel, because it does not update on its own
                                              fModel.dataFilterModel!.pageRowCount = _rowPerPage;
                                              ref.read(tableDataProvider.notifier).getTableValues(fModel);
                                            },
                                            itemsPerPageList: rowPerPageItems,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                else{
                                  List<DayBookDetailedModel> newList = <DayBookDetailedModel>[];
                                  if (data.isNotEmpty) {
                                    final tableReport = ReportData.fromJson(data[1]);
                                    _totalPages = tableReport.totalPages!;
                                    for (var e in data[0]) {
                                      newList.add(DayBookDetailedModel.fromJson(e));
                                    }
                                  } else {
                                    return Container();
                                  }
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
                                              buildDataColumn(200, 'Voucher No.',
                                                  TextAlign.start),
                                              buildDataColumn(
                                                  200, 'Ref No', TextAlign.start),
                                              buildDataColumn(
                                                  160, 'Cheque No', TextAlign.end),
                                              buildDataColumn(
                                                  160, 'Voucher Type', TextAlign.end),
                                              buildDataColumn(160, 'Particular',
                                                  TextAlign.end),
                                              buildDataColumn(160, 'Dr',
                                                  TextAlign.end),
                                              buildDataColumn(160, 'Cr',
                                                  TextAlign.end),
                                              buildDataColumn(200, 'Narration',
                                                  TextAlign.end)
                                            ],
                                            rows: List.generate(
                                              newList.length,
                                                  (index) => buildDayBookDetailedReportRow(index, newList[index], allList, context),
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
                                              ref.read(dayBookProvider.notifier).getTableValues(fModel);
                                            },
                                            showItemsPerPage: true,
                                            onItemsPerPageChanged: (itemsPerPage) {
                                              _rowPerPage = itemsPerPage;
                                              _currentPage = 1;
                                              /// updates row per page of filterModel, because it does not update on its own
                                              fModel.dataFilterModel!.pageRowCount = _rowPerPage;
                                              ref.read(tableDataProvider.notifier).getTableValues(fModel);
                                            },
                                            itemsPerPageList: rowPerPageItems,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }


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
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Text('$error'),
                ),
                loading: () {
                  return const Padding(
                    padding: EdgeInsets.only(right: 20, left: 20, top: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: CustomShimmer(width: double.infinity, height: 50, borderRadius: 10,)),
                              SizedBox(width: 10,),
                              Expanded(child: CustomShimmer(width: double.infinity, height: 50, borderRadius: 10,)),
                            ],
                          ),
                          SizedBox(height: 18,),
                          CustomShimmer(width: double.infinity, height: 50, borderRadius: 10,),
                          SizedBox(height: 18,),
                          CustomShimmer(width: double.infinity, height: 50, borderRadius: 10,),
                          SizedBox(height: 18,),
                          CustomShimmer(width: double.infinity, height: 50, borderRadius: 10,),
                          SizedBox(height: 18,),
                          CustomShimmer(width: 180, height: 50, borderRadius: 10,),
                          SizedBox(height: 40,),
                          Row(
                            children: [
                              Expanded(child: CustomShimmer(width: 40, height: 50,)),
                              SizedBox(width: 1,),
                              Expanded(child: CustomShimmer(width: 180, height: 50,)),
                              SizedBox(width: 1,),
                              Expanded(child: CustomShimmer(width: 120, height: 50,)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
