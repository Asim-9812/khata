
import 'package:flutter/material.dart';
import 'package:khata_app/features/reports/financial/trial_balance/model/trial_balance_ledger_model.dart';

import '../../../../../common/export.dart';


/// for the rows of the data table (S.NO and Particular)
DataRow trialBalanceLedgerRow(int index, LedgerWiseModel tblData,) {
  return DataRow(
    color: MaterialStateProperty.resolveWith((states) => getColor(states, index)),
    cells: [
      buildTrialBlncDataCell(80, '${tblData.sno}', TextAlign.start, tblData.sno!),
      buildTrialBlncDataCell(270, '${tblData.sno != "" ? tblData.accountGroupName : (tblData.ledgerName?.trim())}', TextAlign.start, tblData.sno!),
    ],
  );
}

/// Debit amount and Credit amount rows
DataRow trialBalanceClosingBalanceRow(int index, LedgerWiseModel tblData) {
  return DataRow(
    color: MaterialStateProperty.resolveWith((states) => getColor(states, index)),
    cells: [
      buildTrialBlncDataCell(200, '${tblData.strDebit}', TextAlign.end, tblData.sno!,),
      buildTrialBlncDataCell(200, '${tblData.strCredit}', TextAlign.end, tblData.sno!,),
    ],
  );
}

/// Opening rows
DataRow trialBalanceOpeningRow(int index, LedgerWiseModel tblData) {
  return DataRow(
    color: MaterialStateProperty.resolveWith((states) => getColor(states, index)),
    cells: [
      buildTrialBlncDataCell(180, '${tblData.strOpening}', TextAlign.start, tblData.sno!,),
    ],
  );
}

/// Closing rows
DataRow trialBalanceClosingRow(int index, LedgerWiseModel tblData) {
  return DataRow(
    color: MaterialStateProperty.resolveWith((states) => getColor(states, index)),
    cells: [
      buildTrialBlncDataCell(180, '${tblData.strClosing}', TextAlign.end, tblData.sno!,),
    ],
  );
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
          fontWeight: sNum != "" ? FontWeight.w400 : FontWeight.w600,
        ),
        textAlign: cellTextAlign,
      ),
    ),
  );
}
