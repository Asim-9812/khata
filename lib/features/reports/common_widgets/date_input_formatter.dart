import 'package:flutter/services.dart';


/// the following class extends the TextInputFormatter class and is used to give the "/" sign between the digit just like image format eg. "02/17/2023"
class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    /// Get the new value of the text field as a string
    final newValueString = newValue.text;

    /// Initialize an empty string to hold the formatted value
    String valueToReturn = '';

    /// Loop through each character in the new value string
    /// If the character is not a slash, add it to the formatted value
    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') {
        valueToReturn += newValueString[i];
      }

      /// Get the index of the next non-zero character
      var nonZeroIndex = i + 1;

      /// Check if the formatted value already contains a slash
      final contains = valueToReturn.contains(RegExp(r'/'));

      /// Insert a slash after every second digit, but only if there isn't already a slash
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }

      /// Insert a slash after the second and fifth digit
      if (valueToReturn.length == 4 || valueToReturn.length == 7) {
        valueToReturn += '/';
      }
    }

    /// Return the new TextEditingValue with the formatted value and selection position
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}