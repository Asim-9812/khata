import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DisplayDateTime extends StatelessWidget {
  const DisplayDateTime({
    super.key,
    required this.selectedTime,
  });

  final TimeOfDay selectedTime;

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);

    return scheduledDate.isBefore(now) ? Text('${_formatDateString(DateTime.now().add(const Duration(days: 1)))} ${_formatTime(selectedTime)}',
      style: const TextStyle(
        fontSize: 18,
      ),
    ) : Text('${_formatDateString(DateTime.now())} ${_formatTime(selectedTime)}',
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }
}

String _formatTime(TimeOfDay time) {
  final hour = time.hourOfPeriod;
  final minute = time.minute;
  final period = time.period == DayPeriod.am ? 'am' : 'pm';

  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
}

String _formatDateString(DateTime date) {
  return '${(DateFormat.EEEE().format(date)).substring(0,3)}, ${DateFormat.d().format(date)} ${DateFormat.MMM().format(date)}';
}