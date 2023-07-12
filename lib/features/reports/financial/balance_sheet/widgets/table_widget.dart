
import 'package:flutter/material.dart';
import 'package:khata_app/common/colors.dart';
import 'package:khata_app/features/reports/financial/balance_sheet/model/balance_sheet_model.dart';


DataRow buildBalanceSheetDataRow(int index, BalanceSheetReportModel tblData, final List<Map<dynamic, dynamic>> dropDownList, [BuildContext? context]) {
  return DataRow(
    color: MaterialStateProperty.resolveWith((states) => getColor(states, index)),
    cells: [
      buildDataCell(250, '${tblData.accountGroupName}', TextAlign.start, tblData.layerPosition!, tblData.nature!),
      buildDataCell(200, '${((tblData.layerPosition == 1 && tblData.nature != "Total" )|| tblData.layerPosition == 2) ? "" : tblData.strCredit}', TextAlign.end, tblData.layerPosition!, tblData.nature!),
      buildDataCell(200, '${tblData.accountGroupName2}', TextAlign.start, tblData.layerPosition!, tblData.nature!),
      buildDataCell(160, '${(tblData.layerPosition == 1 || tblData.layerPosition == 2) ? tblData.strCredit : tblData.strDebit}', TextAlign.end, tblData.layerPosition!, tblData.nature!),
    ],
  );
}

DataCell buildDataCell(
    double cellWidth, String cellText, TextAlign cellTextAlign, int layerPosition, String nature) {
  return DataCell(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: cellWidth,
      decoration: BoxDecoration(
        color: nature == 'Total' ? ColorManager.primary : Colors.transparent,
      ),
      child: layerPosition != 2 ? Text(
        cellText,
        style: TextStyle(
          color: nature == 'Total' ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textAlign: cellTextAlign,
      ) : Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          cellText,
          style: const TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic
          ),
          textAlign: cellTextAlign,
        ),
      ),
    ),
  );
}
