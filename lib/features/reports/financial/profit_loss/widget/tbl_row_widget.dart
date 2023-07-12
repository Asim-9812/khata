
import 'package:flutter/material.dart';
import 'package:khata_app/common/colors.dart';
import 'package:khata_app/features/reports/financial/profit_loss/model/pl_report_model.dart';


DataRow buildProfitLossRow(int index, PLReportModel tblData) {
  return DataRow(
    color: MaterialStateProperty.resolveWith((states) => getColor(states, index)),
    cells: [
      buildDataCell(250, '${tblData.accountGroupName}', tblData.nature!),
      buildDataCell(160, '${tblData.strDebit}', tblData.nature!),
      buildDataCell(250, '${tblData.accountGroupName2}', tblData.nature!),
      buildDataCell(160, '${tblData.strCredit}', tblData.nature!),
    ],
  );
}

DataCell buildDataCell(
    double cellWidth, String cellText, String nature) {
  return DataCell(
    Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: cellWidth,
      decoration: BoxDecoration(
        color: nature == 'Total' ? ColorManager.primary : Colors.transparent,
      ),
      child: Text(
        cellText,
        style: TextStyle(
            fontSize: nature == "Total" ? 16 : 15,
            color: nature == "Total" ? Colors.white : Colors.black,
          fontWeight: nature == "Total" ? FontWeight.bold : FontWeight.w500
        ),
        textAlign: TextAlign.start,
      ),
    ),
  );
}
