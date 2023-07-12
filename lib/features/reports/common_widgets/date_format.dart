


String convertDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  String formattedDate =
      "${dateTime.year}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}";
  return formattedDate;
}