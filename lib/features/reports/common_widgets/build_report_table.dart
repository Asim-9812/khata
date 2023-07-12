import 'package:flutter/material.dart';
import 'package:khata_app/common/colors.dart';


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
            color: Colors.white,
          ),
          textAlign: cellTxtAlign,
        ),
      ),
    ),
  );
}

DataCell buildDataCell(
    double cellWidth, String cellText, TextAlign cellTextAlign, bool isFooter,
    [Color? footerColor]) {
  return DataCell(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: cellWidth,
      color: footerColor,
      child: Text(
        cellText,
        style: TextStyle(
          color: Colors.black,
          fontWeight: isFooter ? FontWeight.bold : FontWeight.w400,
        ),
        textAlign: cellTextAlign,
      ),
    ),
  );
}

DataColumn buildDataColumn(double width, String colName, TextAlign alignTxt) {
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
