import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:khata_app/features/reports/common_widgets/date_format.dart';
import 'package:khata_app/features/reports/common_widgets/date_input_formatter.dart';

import 'package:khata_app/features/reports/statement/ledger_report/model/report_model.dart';
import 'package:khata_app/features/reports/statement/ledger_report/provider/report_provider.dart';
import 'package:khata_app/features/dashboard/presentation/home_screen.dart';
import 'package:pager/pager.dart';

import '../../../../../common/colors.dart';
import '../../../../../model/filter model/data_filter_model.dart';
import '../../../../../model/filter model/filter_any_model.dart';
import '../../../../../model/list model/get_list_model.dart';

import '../model/showModel.dart';
import '../widget/build_ledger_sub_report.dart';

class SubReportPage extends StatefulWidget {
  final List<Map<dynamic, dynamic>> dropDownList;
  final String selectedGroup;
  final String ledgerName;
  const SubReportPage({Key? key, required this.dropDownList, required this.selectedGroup, required this.ledgerName}) : super(key: key);

  @override
  State<SubReportPage> createState() => _SubReportPageState();
}

class _SubReportPageState extends State<SubReportPage> {
  TextEditingController dateFrom = TextEditingController();
  TextEditingController dateTo = TextEditingController();
  late int _currentPage;
  late int _rowPerPage;
  List<int> rowPerPageItems = [5, 10, 15, 20, 25, 50];
  late int _totalPages;


  bool? _isChecked;
  String? selectedGroupItem;
  String? selectedLedgerItem;
  String? selectedBranchItem;
  String? newSelectedLedgerItem;

  List<String> group = ['All'];
  List<String> ledger = ['All'];
  List<String> upDatedLedger = ['All'];
  List<String> branchList = ['All'];



  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.grey;
    }
    return ColorManager.primary;
  }

  @override
  void initState() {
    super.initState();
    _isChecked = false;
    _currentPage = 1;
    _rowPerPage = 5;
    _totalPages = 0;
    selectedGroupItem = widget.selectedGroup;
    selectedLedgerItem = widget.ledgerName;
    selectedBranchItem = branchList.first;
    newSelectedLedgerItem = widget.ledgerName;
  }


  @override
  Widget build(BuildContext context) {

    GetListModel modelRef = GetListModel();
    modelRef.refName = 'AccountLedgerReport';
    modelRef.isSingleList = 'false';
    modelRef.singleListNameStr = '';
    modelRef.listNameId =
    "['underGroup', 'mainLedger-${1}', 'mainBranch-${2}']";
    modelRef.mainInfoModel = mainInfo;
    modelRef.conditionalValues = '';


    widget.dropDownList[0].forEach((key, value) {
      group.add(key);
    });

    widget.dropDownList[1].forEach((key, value) {
      ledger.add(key);
    });

    widget.dropDownList[2].forEach((key, value) {
      branchList.add(key);
    });

    dateFrom.text = convertDate(mainInfo.startDate!);
    dateTo.text = convertDate(mainInfo.endDate!);

    GetListModel ledgerGroupListModel = GetListModel();
    ledgerGroupListModel.refName = 'AccountLedgerReport';
    ledgerGroupListModel.isSingleList = 'true';
    ledgerGroupListModel.singleListNameStr = 'account';
    ledgerGroupListModel.listNameId = "['mainLedger-${widget.dropDownList[0][selectedGroupItem]}']";
    ledgerGroupListModel.mainInfoModel = mainInfo;
    ledgerGroupListModel.conditionalValues = '';

    /// this function returns ledgerId according to the selected item from drop down
    String getLedgerValue(String groupValue, String ledgerVal, String updateLedgerVal){
      if(groupValue == "All"){
        return 'LedgerId--${widget.dropDownList[1][selectedLedgerItem]}';
      }else if(groupValue != "All" && newSelectedLedgerItem == "All"){
        return 'LedgerId--${widget.dropDownList[1][widget.ledgerName]}';
      }else {
        return 'LedgerId--${widget.dropDownList[1][newSelectedLedgerItem]}';
      }
    }

    DataFilterModel filterModel = DataFilterModel();
    filterModel.tblName = "AccountLedgerReport--AccountLedgerReportIndividual";
    filterModel.strName = "";
    filterModel.underColumnName = null;
    filterModel.underIntID = 0;
    filterModel.columnName = null;
    filterModel.filterColumnsString = "[\"${getLedgerValue(selectedGroupItem!, selectedLedgerItem!, newSelectedLedgerItem!)}\",\"fromDate--${dateFrom.text.trim()}\",\"toDate--${dateTo.text.trim()}\",\"${selectedGroupItem == 'All' ? "accountGroupId--" : "accountGroupId--${widget.dropDownList[0][selectedGroupItem]}"}\",\"isCheck--$_isChecked\",\"${selectedBranchItem == 'All' ? "BranchId--" : "BranchId--${widget.dropDownList[2][selectedBranchItem]}"}\"]";
    filterModel.pageRowCount = _rowPerPage;
    filterModel.currentPageNumber = _currentPage;
    filterModel.strListNames = "";

    FilterAnyModel fModel = FilterAnyModel();
    fModel.dataFilterModel = filterModel;
    fModel.mainInfoModel = mainInfo;


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
        title: const Text('Ledger Details'),
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
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 380,
                  width: double.infinity,
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                DateInputFormatter(),
                                LengthLimitingTextInputFormatter(10)
                              ],
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              controller: dateFrom,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.45),
                                        width: 1,
                                      )),
                                  contentPadding: const EdgeInsets.all(10),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: ColorManager.primary,
                                        width: 1,
                                      )),
                                  floatingLabelStyle:
                                  TextStyle(color: ColorManager.primary),
                                  labelText: 'From',
                                  labelStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  alignLabelWithHint: true,
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      DateTime? pickDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),);
                                      if (pickDate != null) {
                                        dateFrom.text =
                                            DateFormat('yyyy/MM/dd').format(pickDate);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.edit_calendar,
                                      size: 30,
                                      color: ColorManager.primary,
                                    ),
                                  )),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                DateInputFormatter(),
                                LengthLimitingTextInputFormatter(10)
                              ],
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              controller: dateTo,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.45),
                                      width: 1,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: ColorManager.primary,
                                      width: 1,
                                    )),
                                floatingLabelStyle: TextStyle(
                                    color: ColorManager.primary,
                                    fontSize: 18),
                                contentPadding: const EdgeInsets.all(10),
                                labelText: 'To',
                                labelStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                                alignLabelWithHint: true,
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    DateTime? pickDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100));
                                    if (pickDate != null) {
                                      dateTo.text =
                                          DateFormat('yyyy/MM/dd').format(pickDate);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.edit_calendar,
                                    size: 30,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      buildDropdownSearch('Group',
                        group,
                        selectedGroupItem!,
                            (value){
                        setState(() {
                          selectedGroupItem = value;
                        });
                        },
                      ),
                      const Spacer(),
                      selectedGroupItem == 'All' ?
                      DropdownSearch<String>(
                        items: ledger,
                        selectedItem: widget.ledgerName,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.45),
                                  width: 2,
                                )),
                            contentPadding: const EdgeInsets.all(15),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: ColorManager.primary, width: 1)),
                            floatingLabelStyle:
                            TextStyle(color: ColorManager.primary),
                            labelText: 'Ledger',
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
                          setState(() {
                            selectedLedgerItem = value;
                          });
                        },
                      )
                      : Consumer(
                        builder: (context, ref, child) {
                          ref.read(newLedgerProvider.notifier).getLedgerItem(ledgerGroupListModel);
                          final result = ref.watch(newLedgerProvider);
                          return result.when(
                            data: (data) {
                              List<String> ledgerList = ['All'];
                              data.forEach((key,_) {
                                ledgerList.add(key);
                              });
                              return buildDropdownSearch('Ledger', ledgerList, newSelectedLedgerItem!,
                                    (value){
                                  setState(() {
                                    newSelectedLedgerItem = value;
                                  });
                                },
                              );
                            },
                            error: (error, stackTrace) => Center(child: Text('$error')),
                            loading: () => const CircularProgressIndicator(),
                          );
                        },
                      ),
                      const Spacer(),
                      buildDropdownSearch(
                          'Branch',
                          branchList,
                          selectedBranchItem!,
                            (value){
                            setState(() {
                              selectedBranchItem = value;
                            });
                            },
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool? val) {
                              setState(() {
                                _isChecked = val!;
                              });
                            },
                            checkColor: Colors.white,
                            fillColor:
                            MaterialStateProperty.resolveWith(
                                    (states) => getColor(states)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const Text(
                            'Inclusive',
                            style: TextStyle(fontSize: 18,)
                          )
                        ],
                      ),
                      const SizedBox(height: 5,),
                      Consumer(
                        builder: (context, ref, child) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.green,
                              minimumSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              ref.read(modalDataProvider.notifier).getModalTableData(fModel);
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.arrowsRotate,
                              color: Colors.white,
                              size: 25,
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 5,),
                Consumer(
                  builder: (context, ref, child) {
                    final result = ref.watch(modalDataProvider);
                    return result.when(
                      data: (data) {
                        List<ShowModal> newList = <ShowModal>[];
                        List<String> reportTotal = <String>[];
                        if(data.isNotEmpty){
                          final tableReport = ReportData.fromJson(data[2]);
                          _totalPages = tableReport.totalPages!;
                          for(var e in data[0]){
                            if(ShowModal.fromJson(e).sno != ""){
                              newList.add(ShowModal.fromJson(e));
                            }
                          }
                          data[1].forEach((key, value) {
                            reportTotal.add(value);
                          });
                        } else {
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
                                  DataTable(
                                    columns: [
                                      buildDataColumn(80, 'S.N', TextAlign.start),
                                      buildDataColumn(200, 'Date', TextAlign.start),
                                      buildDataColumn(200, 'Voucher No.', TextAlign.start),
                                      buildDataColumn(200, 'Ref. No.', TextAlign.start),
                                      buildDataColumn(160, 'Cheq. No.', TextAlign.start),
                                      buildDataColumn(160, 'Voucher Type', TextAlign.center),
                                      buildDataColumn(160, 'Debit (Dr)', TextAlign.end),
                                      buildDataColumn(160, 'Credit (Cr)', TextAlign.end),
                                      buildDataColumn(160, 'Balance', TextAlign.end),
                                      buildDataColumn(160, 'Narration', TextAlign.start),
                                      // buildDataColumn(80, 'View', TextAlign.center),
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
                        return SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const ClampingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                DataTable(
                                  columns: [
                                    buildDataColumn(80, 'S.N', TextAlign.start),
                                    buildDataColumn(200, 'Date', TextAlign.start),
                                    buildDataColumn(200, 'Voucher No.', TextAlign.start),
                                    buildDataColumn(200, 'Ref. No.', TextAlign.start),
                                    buildDataColumn(160, 'Cheq. No.', TextAlign.start),
                                    buildDataColumn(160, 'Voucher Type', TextAlign.center),
                                    // buildDataColumn(200, 'Particular', TextAlign.start),
                                    buildDataColumn(160, 'Debit (Dr)', TextAlign.end),
                                    buildDataColumn(160, 'Credit (Cr)', TextAlign.end),
                                    buildDataColumn(160, 'Balance', TextAlign.end),
                                    buildDataColumn(160, 'Narration', TextAlign.start),
                                    // buildDataColumn(80, 'View', TextAlign.center),
                                  ],
                                  rows: List.generate(newList.length, (index) => buildLedgerSubReport(index, newList[index],),),
                                  columnSpacing: 0,
                                  horizontalMargin: 0,
                                ),
                                Table(
                                  columnWidths: const <int,
                                      TableColumnWidth>{
                                    0: FixedColumnWidth(50),
                                    1: FixedColumnWidth(200),
                                    2: FixedColumnWidth(200),
                                    3: FixedColumnWidth(200),
                                    4: FixedColumnWidth(160),
                                    5: FixedColumnWidth(160),
                                    // 6: FixedColumnWidth(200),
                                    6: FixedColumnWidth(160),
                                    7: FixedColumnWidth(160),
                                    8: FixedColumnWidth(160),
                                    9: FixedColumnWidth(160),
                                    // 10: FixedColumnWidth(80),
                                  },
                                  children: [
                                    TableRow(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      children: [
                                        buildTableCell(''),
                                        buildTableCell(''),
                                        buildTableCell(''),
                                        buildTableCell(''),
                                        buildTableCell('', TextAlign.center),
                                        buildTableCell('', TextAlign.end),
                                        buildTableCell('Total', TextAlign.end),
                                        buildTableCell(reportTotal[0], TextAlign.end),
                                        buildTableCell(reportTotal[1], TextAlign.end),
                                        buildTableCell('',),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      children: [
                                        buildTableCell(''),
                                        buildTableCell(''),
                                        buildTableCell(''),
                                        buildTableCell(''),
                                        buildTableCell('', TextAlign.center),
                                        buildTableCell('', TextAlign.end),
                                        buildTableCell('Balance', TextAlign.end),
                                        buildTableCell(reportTotal[2], TextAlign.end),
                                        buildTableCell(reportTotal[3], TextAlign.end),
                                        buildTableCell('',),
                                      ],
                                    ),
                                    TableRow(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      children: [
                                        buildTableCell(''),
                                        buildTableCell(''),
                                        buildTableCell(''),
                                        buildTableCell(''),
                                        buildTableCell('', TextAlign.center),
                                        buildTableCell('', TextAlign.end),
                                        buildTableCell('Grand Total', TextAlign.end),
                                        buildTableCell(reportTotal[4], TextAlign.end),
                                        buildTableCell(reportTotal[5], TextAlign.end),
                                        buildTableCell('',),
                                      ],
                                    ),
                                  ],
                                ),
                                /// Pager package used for pagination
                                Row(
                                  children: [
                                    _totalPages != 0 ? Pager(
                                      currentItemsPerPage: _rowPerPage,
                                      currentPage: _currentPage,
                                      totalPages: _totalPages,
                                      onPageChanged: (page) {
                                        _currentPage = page;
                                        fModel.dataFilterModel!.currentPageNumber = _currentPage;
                                        ref.read(modalDataProvider.notifier).getModalTableData(fModel);
                                        /// updates current page number of filterModel, because it does not update on its own
                                      },
                                      showItemsPerPage: true,
                                      onItemsPerPageChanged: (itemsPerPage) async {
                                        _rowPerPage = itemsPerPage;
                                        _currentPage = 1;
                                        fModel.dataFilterModel!.pageRowCount = _rowPerPage;
                                        fModel.dataFilterModel!.currentPageNumber = _currentPage;
                                        ref.read(modalDataProvider.notifier).getModalTableData(fModel);
                                      },
                                      itemsPerPageList: rowPerPageItems,
                                    ) : const Text('No records to show', style: TextStyle(fontSize: 16, color: Colors.red),),
                                    const SizedBox(width: 650,),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Total Balance: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))
                                          ),
                                          TextSpan(
                                              text: reportTotal[6], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)
                                          ),
                                        ]
                                      ),
                                    ),
                                    const SizedBox(width: 80,),
                                    RichText(
                                      text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Page Balance: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))
                                            ),
                                            TextSpan(
                                                text: reportTotal[7], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black)
                                            ),
                                          ]
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      error: (error, stackTrace) => Center(child: Text('$error')),
                      loading: () => const CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(height: 5,),
              ],
            ),
          ),
        ),
      ),
    );
  }


  DropdownSearch<String> buildDropdownSearch(String fieldName, List<String> dropDownList, String selectedItem, Function(dynamic) onChanged) {
    return DropdownSearch<String>(
      items: dropDownList,
      selectedItem: selectedItem,
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500),
        dropdownSearchDecoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.45),
                width: 2,
              )),
          contentPadding: const EdgeInsets.all(15),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: ColorManager.primary, width: 1)),
          floatingLabelStyle:
          TextStyle(color: ColorManager.primary),
          labelText: fieldName,
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
      onChanged: onChanged,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}




List<String> getLedgerList(BuildContext context, groupItemVal){
  List<String> ledgerList = ['All'];

  Consumer(
      builder: (context, ref, child) {
        final result = ref.watch(newLedgerProvider);
        return result.when(
            data: (data) {
              data.forEach((key,_) {
                ledgerList.add(key);
              });
              return const Text('');
            },
            error: (error, stackTrace) => Center(child: Text('$error')),
            loading: () => const CircularProgressIndicator(),
        );
      },
  );

  return ledgerList;
}

class TestDynamicFunction{
  PaginatedDataTable getTable(List<dynamic> response, List<String> colName, BuildContext context, List<Map<dynamic, dynamic>> dropDownList ){
    List<ShowModal> newList = <ShowModal>[];
    List<String> total = <String>[];
    if(response.isNotEmpty){
      for(var e in response[0]){
        newList.add(ShowModal.fromJson(e));
      }
      response[1].forEach((key, value) {
        total.add(value);
      });
    }
    return PaginatedDataTable(
        columns: colName.map((e) => DataColumn(label: Text(e))).toList(),
        source: MyNewDataSource(newList, total, context, dropDownList),
    );
  }
}

class MyNewDataSource extends DataTableSource {
  final List<ShowModal> data;
  final List<String> totals;
  final BuildContext context;
  final List<Map<dynamic, dynamic>> dropDownList;

  MyNewDataSource(this.data, this.totals, this.context, this.dropDownList);

  @override
  DataRow? getRow(int index) {
    if(index < data.length){
      final record = data;
      return DataRow(
        cells: [
          DataCell(SizedBox(width: 50, child: Center(child: Text(record[index].sno.toString())))),
          DataCell(SizedBox(width: 200, child: Text(record[index].voucherDate.toString(), ))),
          DataCell(SizedBox(width: 200, child: Text(record[index].voucherNo.toString(), ))),
          DataCell(SizedBox(width: 200, child: Text(record[index].refNo.toString(),))),
          DataCell(SizedBox(width: 120, child: Text(record[index].chequeNo.toString(), textAlign: TextAlign.right,))),
          DataCell(SizedBox(width: 120, child: Text(record[index].voucherTypeName.toString(), textAlign: TextAlign.right))),
          DataCell(SizedBox(width: 120, child: Text(record[index].ledgerName.toString(), textAlign: TextAlign.right))),
          DataCell(SizedBox(width: 120, child: Text(record[index].strDebit.toString(), textAlign: TextAlign.right))),
          DataCell(SizedBox(width: 120, child: Text(record[index].strCredit.toString(), textAlign: TextAlign.right))),
          DataCell(SizedBox(width: 120, child: Text(record[index].strBalance.toString(), textAlign: TextAlign.right))),
          DataCell(SizedBox(width: 120, child: Text(record[index].narration.toString(), textAlign: TextAlign.right))),
          DataCell(
            Center(
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.green,
                    minimumSize: const Size(30, 30)
                ),
                child: const Icon(Icons.remove_red_eye_rounded,  color: Colors.white,),
              ),
            ),
          ),
        ],
      );
    }else if(index == data.length && totals.isNotEmpty){
      return DataRow(cells: [
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(SizedBox(width: 200, child: Text('Total', style: TextStyle(fontWeight: FontWeight.w600),))),
        const DataCell(Text('')),
        const DataCell(Text('')),
        DataCell(SizedBox(width: 120, child: Text(totals[0], style: const TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.right,))),
        DataCell(SizedBox(width: 120, child: Text(totals[1], style: const TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.right))),
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(Text('')),
      ]);
    }else if(index == 9 && totals.isNotEmpty){
      return DataRow(cells: [
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(SizedBox(width: 200, child: Text('Balance', style: TextStyle(fontWeight: FontWeight.w600),))),
        const DataCell(Text('')),
        const DataCell(Text('')),
        DataCell(SizedBox(width: 120, child: Text(totals[2], style: const TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.right,))),
        DataCell(SizedBox(width: 120, child: Text(totals[3], style: const TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.right))),
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(Text('')),
      ]);
    }else if(index == data.length + 2 && totals.isNotEmpty){
      return DataRow(cells: [
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(SizedBox(width: 200, child: Text('Balance', style: TextStyle(fontWeight: FontWeight.w600),))),
        const DataCell(Text('')),
        const DataCell(Text('')),
        DataCell(SizedBox(width: 120, child: Text(totals[4], style: const TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.right,))),
        DataCell(SizedBox(width: 120, child: Text(totals[5], style: const TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.right))),
        const DataCell(Text('')),
        const DataCell(Text('')),
        const DataCell(Text('')),
      ]);
    } else{
      return null;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length + (totals.isNotEmpty ? 1 : 0);

  @override
  int get selectedRowCount => 0;
}