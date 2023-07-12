

import 'package:flutter/material.dart';
class SnackBarUtil{

  static SnackBar customSnackBar(String message){
    return SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      elevation: 5,
      margin: const EdgeInsets.fromLTRB(40, 0, 40, 120),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: const Duration(milliseconds: 700),
      dismissDirection: DismissDirection.horizontal,
      animation: CurvedAnimation(parent: kAlwaysCompleteAnimation, curve: Curves.easeOut),
    );
  }

  static SnackBar customErrorSnackBar(String message){
    return SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      elevation: 5,
      margin: const EdgeInsets.fromLTRB(40, 0, 40, 120),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: const Duration(milliseconds: 700),
      dismissDirection: DismissDirection.horizontal,
      animation: CurvedAnimation(parent: kAlwaysCompleteAnimation, curve: Curves.easeOut),
    );
  }


}
