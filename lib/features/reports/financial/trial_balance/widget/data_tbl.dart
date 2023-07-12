

import 'package:flutter/material.dart';

TableCell trialTblCell(String cellText, [TextAlign? cellTxtAlign]) {
  return TableCell(
    child: Container(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      height: 40,
      child: Text(
        cellText,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        textAlign: cellTxtAlign,
      ),
    ),
  );
}
