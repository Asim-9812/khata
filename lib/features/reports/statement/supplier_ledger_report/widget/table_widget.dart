import 'package:flutter/material.dart';
import 'package:khata_app/common/colors.dart';
import 'package:khata_app/features/reports/statement/ledger_report/presentation/subreport.dart';
import 'package:khata_app/features/reports/statement/supplier_ledger_report/model/supplier_ledger_report_model.dart';

import '../../../common_widgets/build_report_table.dart';



DataRow buildReportDataRow(int index, SupplierLedgerModel tblData,
    final List<Map<dynamic, dynamic>> dropDownList,
    [BuildContext? context]) {
  return DataRow(
    color:
        MaterialStateProperty.resolveWith((states) => getColor(states, index)),
    cells: [
      buildDataCell(
          60, '${tblData.sno}', TextAlign.start, tblData.isPageFooter!),
      buildDataCell(
          200, '${tblData.ledgerName}', TextAlign.start, tblData.isPageFooter!),
      buildDataCell(200, '${tblData.accountGroupName}', TextAlign.start,
          tblData.isPageFooter!),
      buildDataCell(
          160, '${tblData.strOpening}', TextAlign.end, tblData.isPageFooter!),
      buildDataCell(
          160, '${tblData.strDebit}', TextAlign.end, tblData.isPageFooter!),
      buildDataCell(
          160, '${tblData.strCredit}', TextAlign.end, tblData.isPageFooter!),
      buildDataCell(
          160, '${tblData.strClosing}', TextAlign.end, tblData.isPageFooter!),
      tblData.isPageFooter == true
          ? const DataCell(SizedBox())
          : DataCell(
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context!,
                        MaterialPageRoute(
                          builder: (context) => SubReportPage(
                            ledgerName: tblData.ledgerName!,
                            selectedGroup: tblData.accountGroupName!,
                            dropDownList: dropDownList,
                          ),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.green,
                      minimumSize: const Size(30, 30)),
                  child: const Icon(
                    Icons.remove_red_eye_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
    ],
  );
}
