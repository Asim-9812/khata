
import 'package:flutter/material.dart';
import 'package:khata_app/features/reports/financial/trial_balance/model/trial_balance_group_model.dart';

import '../../../../../common/export.dart';



/// for the heading column of the data table
DataColumn trialBalanceColumn(double colWidth, String colName, TextAlign alignTxt) {
  return DataColumn(
    label: Container(
      height: 70,
      width: colWidth,
      decoration: BoxDecoration(
          color: ColorManager.primary,
          border: const Border(
              right: BorderSide(
                color: Colors.white,
                width: 1,
              ))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 20, right: 5),
        child: Text(
          colName,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          textAlign: alignTxt,
        ),
      ),
    ),
  );
}

/// Closing balance( debit amount and credit amount column cells)
DataColumn trialBalanceColumnRow(double colWidth, String colName, TextAlign alignTxt) {
  return DataColumn(
    label: Container(
      width: colWidth,
      height: 30,
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
        padding: const EdgeInsets.only(left: 10, top: 6, right: 10),
        child: Text(
          colName,
          style: const TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          textAlign: alignTxt,
        ),
      ),
    ),
  );
}


/// for the rows of the data table
DataRow buildTrialBalanceDataRow(int index, GroupWiseModel tblData, bool isDetailed) {
  if(isDetailed == false){
    return DataRow(
      color: MaterialStateProperty.resolveWith((states) => getColor(states, index)),
      cells: [
        buildTrialBlncDataCell(80, '${tblData.sno}', TextAlign.start, tblData.sno!),
        buildTrialBlncDataCell(250, '${tblData.accountGroupName}', TextAlign.start, tblData.sno!),
      ],
    );
  }else{
    return DataRow(
      color: MaterialStateProperty.resolveWith((states) => getColor(states, index)),
      cells: [
        buildTrialBlncDataCellDetailed(80, '${tblData.sno}', TextAlign.start, tblData.layerPosition!, tblData.isGroup!, ),
        buildTrialBlncDataCellDetailed(250, '${tblData.accountGroupName}', TextAlign.start, tblData.layerPosition!, tblData.isGroup!,),
      ],
    );
  }
}

/// Closing balance( debit amount and credit amount row cells)
DataRow buildTrialBalanceDataRow1(int index, GroupWiseModel tblData, bool isDetailed) {
  if(isDetailed == false){
    return DataRow(
      color: MaterialStateProperty.resolveWith((states) => getColor(states, index)),
      cells: [
        buildTrialBlncDataCell(200, '${tblData.sno != "" ? tblData.strDebit : ""}', TextAlign.end, tblData.sno!,),
        buildTrialBlncDataCell(200, '${tblData.strCredit}', TextAlign.end, tblData.sno!,),
      ],
    );
  }else{
    return DataRow(
      color: MaterialStateProperty.resolveWith((states) => getColor(states, index)),
      cells: [
        buildTrialBlncDataCellDetailed(200, '${tblData.strDebit}', TextAlign.end, tblData.layerPosition!, tblData.isGroup!,),
        buildTrialBlncDataCellDetailed(200, '${tblData.strCredit}', TextAlign.end, tblData.layerPosition!, tblData.isGroup!),
      ],
    );
  }
}


DataCell buildTrialBlncDataCell(double cellWidth, String cellText, TextAlign cellTextAlign, String sNum,) {
  return DataCell(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: cellWidth,
      child: Text(
        cellText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: sNum != "" ? FontWeight.w400 : FontWeight.w500,
        ),
        textAlign: cellTextAlign,
      ),
    ),
  );
}

/// if the detail checkbox is used (only works for group type for now.)
DataCell buildTrialBlncDataCellDetailed(double cellWidth, String cellText, TextAlign cellTextAlign, int layerPosition, bool isGroup) {
  return DataCell(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: cellWidth,
      child: DisplayText(cellText: cellText, layerPosition: layerPosition, cellTextAlign: cellTextAlign, isGroup: isGroup)
    ),
  );
}


class DisplayText extends StatelessWidget {
  final String cellText;
  final int layerPosition;
  final TextAlign cellTextAlign;
  final bool isGroup;
  const DisplayText({
    super.key, required this.cellText, required this.layerPosition, required this.cellTextAlign, required this.isGroup,
  });

  @override
  Widget build(BuildContext context) {

    if(layerPosition == 2){
      return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          cellText,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          textAlign: cellTextAlign,
        ),
      );
    } else if(layerPosition == 3){
      return Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Text(
          cellText,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          textAlign: cellTextAlign,
        ),
      );
    } else if(layerPosition == 4){
      return Padding(
        padding: const EdgeInsets.only(left: 35),
        child: Text(
          cellText,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          textAlign: cellTextAlign,
        ),
      );
    }else {
      return Text(
        cellText,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: isGroup ? FontWeight.bold : FontWeight.w400,
        ),
        textAlign: cellTextAlign,
      );
    }

  }
}