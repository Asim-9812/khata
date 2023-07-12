
import 'package:flutter/material.dart';
import 'package:khata_app/common/colors.dart';
import 'package:khata_app/features/reports/Register/voucher_report/model/voucher_individual_report_model.dart';
import 'package:khata_app/features/reports/Register/voucher_report/model/voucher_report_model.dart';
import 'package:khata_app/features/reports/Register/voucher_report/presentation/voucher_report_individual.dart';

// TableCell buildTableCell(String cellText, [TextAlign? cellTxtAlign]) {
//   return TableCell(
//     child: SizedBox(
//       height: 40,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 5, right: 10),
//         child: Text(
//           cellText,
//           style: const TextStyle(
//             fontFamily: 'Ubuntu',
//             fontWeight: FontWeight.w500,
//             color: Colors.white,
//           ),
//           textAlign: cellTxtAlign,
//         ),
//       ),
//     ),
//   );
// }

DataRow buildVoucherReportDataRow({required int index, required VoucherReportModel tblData, required BuildContext context}) {
  return DataRow(
    color:
    MaterialStateProperty.resolveWith((states) => getColor(states, index)),
    cells: [
      buildDataCell(60, '${tblData.sno}', TextAlign.start, tblData.layerPosition!),
      buildDataCell(200, '${tblData.strVoucherDate}', TextAlign.start, tblData.layerPosition!),
      buildDataCell(200, '${tblData.voucherNo}', TextAlign.start, tblData.layerPosition!),
      buildDataCell(140, '${tblData.refNo}', TextAlign.start, tblData.layerPosition!),
      buildDataCell(200, '${tblData.voucherName}', TextAlign.start, tblData.layerPosition!),
      buildDataCell(200, '${tblData.strAmount}', TextAlign.end, tblData.layerPosition!),
      buildDataCell(300, '${tblData.narration}', TextAlign.end, tblData.layerPosition!),
      buildDataCell(120, '${tblData.strStatus}', TextAlign.end, tblData.layerPosition!),
      DataCell(
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VoucherReportIndividual(masterId: tblData.masterId!),
                  ),
              );
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

DataRow voucherReportDataRowDetailed({required int index, required VoucherReportModel tblData, required BuildContext context}) {
  return DataRow(
    color:
    MaterialStateProperty.resolveWith((states) => getColor(states, index)),
    cells: [
      buildDataCell(60, '${tblData.isParent! ? tblData.sno : ""}', TextAlign.start, tblData.layerPosition!),
      buildDataCell(150, '${tblData.isParent! ? tblData.strVoucherDate : ""}', TextAlign.start, tblData.layerPosition!),
      buildDataCell(200, '${tblData.isParent! ? tblData.voucherNo : ""}', TextAlign.start, tblData.layerPosition!),
      buildDataCell(120, '${tblData.isParent! ? tblData.refNo : ""}', TextAlign.start, tblData.layerPosition!),
      buildDataCell(200, '${tblData.isParent! ? tblData.voucherName : ""}', TextAlign.start, tblData.layerPosition!),
      buildDataCell(250, '${tblData.particulars}', TextAlign.start, tblData.layerPosition!),
      buildDataCell(200, '${tblData.isParent! ? tblData.strAmount : ""}', TextAlign.end, tblData.layerPosition!),
      buildDataCell(300, '${tblData.isParent! ? tblData.narration : ""}', TextAlign.end, tblData.layerPosition!),
      buildDataCell(120, '${tblData.isParent! ? tblData.strStatus : ""}', TextAlign.end, tblData.layerPosition!),
      tblData.isParent! ? DataCell(
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VoucherReportIndividual(masterId: tblData.masterId!),
                ),
              );
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
      ) : const DataCell(SizedBox()),
    ],
  );
}

DataCell buildDataCell(double cellWidth, String cellText, TextAlign cellTextAlign, int layerPosition) {
  return DataCell(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: cellWidth,
      child: layerPosition == 2 ? Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          cellText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          textAlign: cellTextAlign,
        ),
      ) : Text(
        cellText,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        textAlign: cellTextAlign,
      ),
    ),
  );
}

/// following widgets are for the Voucher individual report
DataColumn voucherReportDataColumn(double width, String colName, TextAlign alignTxt) {
  return DataColumn(
    label: Container(
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
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: Text(
          colName,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: alignTxt,
        ),
      ),
    ),
  );
}


DataRow voucherReportIndividualRow(int index, VoucherIndividualReportModel tblData) {
  return DataRow(
    color:
    MaterialStateProperty.resolveWith((states) => getColor(states, index)),
    cells: [
      buildDataCellVoucherIndividualRow(50, '${tblData.sno != "" ? tblData.sno : ""}', TextAlign.start, tblData),
      buildDataCellVoucherIndividualRow(300, '${tblData.ledgerName}', TextAlign.start, tblData),
      buildDataCellVoucherIndividualRow(150, '${tblData.sno != "" ? tblData.dr : ""}', TextAlign.start, tblData),
      buildDataCellVoucherIndividualRow(150, '${tblData.sno != "" ? tblData.cr : ""}', TextAlign.start, tblData),
      buildDataCellVoucherIndividualRow(150, '${tblData.sno != "" ? tblData.chequeNo : ""}', TextAlign.start, tblData),
      buildDataCellVoucherIndividualRow(150, '${tblData.sno != "" ? tblData.chequeDate : ""}', TextAlign.start, tblData),
      buildDataCellVoucherIndividualRow(150, '${tblData.sno != "" ? tblData.narration : ""}', TextAlign.end, tblData),
    ],
  );
}


DataCell buildDataCellVoucherIndividualRow(double cellWidth, String cellText, TextAlign cellTextAlign,  VoucherIndividualReportModel tblData) {
  return DataCell(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: cellWidth,
      child: tblData.sno == "" ? Padding(
        padding: const EdgeInsets.only(left: 18),
        child: Text(
          cellText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          textAlign: cellTextAlign,
        ),
      ) : Text(
        cellText,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        textAlign: cellTextAlign,
      ),
    ),
  );
}