import 'package:flutter/material.dart';


// creating a new class and from here we create Color objects which gives colors and can be accessed anywhere inside the code
class ColorManager {
  static Color primary = HexColor.fromHex("#1B7492");
  static Color titleBlue = HexColor.fromHex("#1B7492");
  static Color textGray = HexColor.fromHex("#899097");
  static Color iconGray = HexColor.fromHex("#000000").withOpacity(0.6);
  static Color green = HexColor.fromHex("#198754");
  static Color yellow = HexColor.fromHex("#ffc107");
  static Color background = HexColor.fromHex("#E3EEF8");
  static Color errorRed = HexColor.fromHex("#DC3545");
  static Color textBlack = HexColor.fromHex("#212529");
  static Color drawerPrimary = HexColor.fromHex("#0F5061");
  static Color drawerSecondary = HexColor.fromHex("#0A3642");
  static Color drawerTertiary = HexColor.fromHex("#062229");
  static Color logoOrange = HexColor.fromHex("#FD872A");
  static Color iconGrey = HexColor.fromHex('#000000').withOpacity(0.6);
  static Color subtitleGrey = HexColor.fromHex('#838589');
  static Color greenNotification = HexColor.fromHex('#F6FBF9');
  static Color menuIcon = HexColor.fromHex('#1B7492');
  static Color textGrey = HexColor.fromHex('##646864');
}

// this is a function which takes the string value of hex and formats it into hexadecimal value
extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', ''); // replacing # with ' '
    if (hexColorString.length == 6) {
      // if the length is equal to 6
      hexColorString =
          "FF" + hexColorString; // then add FF in front to make it 8
    }
    return Color(int.parse(hexColorString,
        radix:
            16)); // return the Color object with the parsed hexValue with base 16 which is of Hexadecimal
  }
}


///returns the color for each row according to its index
Color getColor(Set<MaterialState> states, int index) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (index % 2 == 0) {
    return Colors.grey.shade200;
  }else{
    return Colors.white;
  }
}

/// material color for checkbox
Color getCheckBoxColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.grey;
  }
  return ColorManager.primary;
}