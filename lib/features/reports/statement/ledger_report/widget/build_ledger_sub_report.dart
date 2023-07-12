
import 'package:flutter/material.dart';
import 'package:khata_app/common/colors.dart';
import 'package:khata_app/features/reports/statement/ledger_report/model/showModel.dart';

TableCell buildTableCell(String cellText, [TextAlign? cellTxtAlign]) {
  return TableCell(
    child: SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, right: 10),
        child: Text(
          cellText,
          style: const TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          textAlign: cellTxtAlign,
        ),
      ),
    ),
  );
}

DataRow buildLedgerSubReport(int index, ShowModal tblData, [BuildContext? context]) {
  return DataRow(
    color: MaterialStateProperty.resolveWith((states) => getColor(states, index)),
    cells: [
      buildDataCell(80, '${tblData.sno}', TextAlign.start),
      buildDataCell(200, '${tblData.voucherDate}', TextAlign.start),
      buildDataCell(200, '${tblData.voucherNo}', TextAlign.start),
      buildDataCell(200, '${tblData.refNo}', TextAlign.start),
      buildDataCell(160, '${tblData.chequeNo}', TextAlign.start),
      buildDataCell(160, '${tblData.voucherTypeName}', TextAlign.center),
      // buildDataCell(200, '${tblData.ledgerName}', TextAlign.start),
      buildDataCell(160, '${tblData.strDebit}', TextAlign.end),
      buildDataCell(160, '${tblData.strCredit}', TextAlign.end),
      buildDataCell(160, '${tblData.strBalance}', TextAlign.end),
      buildDataCell(160, '${tblData.narration}', TextAlign.start),
    ],
  );
}


DataCell buildDataCell(
    double cellWidth, String cellText, TextAlign cellTextAlign,
    [Color? footerColor]) {
  return DataCell(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: cellWidth,
      color: footerColor,
      child: Text(
        cellText,
        style: const TextStyle(
          color: Colors.black,
        ),
        textAlign: cellTextAlign,
      ),
    ),
  );
}

DataColumn buildDataColumn(double width, String colName, TextAlign alignTxt) {
  return DataColumn(
    label: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: width,
      height: 50,
      decoration: BoxDecoration(
          color: ColorManager.primary,
          border: const Border(
              right: BorderSide(
                color: Colors.white,
                width: 1,
              ),
          ),
      ),
      child: Text(
        colName,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        textAlign: alignTxt,
      ),
    ),
  );
}