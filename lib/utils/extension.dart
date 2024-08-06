import 'package:intl/intl.dart';

extension ExtString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(r"^.{8,}$");
    return passwordRegExp.hasMatch(this);
  }
}

extension DateUtils on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }

  String getFormattedDate({required bool textMode}) {
    if (isToday) {
      if (textMode) {
        return 'Today';
      }
      final dateFormat = DateFormat.jm();
      return dateFormat.format(this).toLowerCase();
    }
    if (isYesterday) {
      if (textMode) {
        return 'Yesterday';
      }
      final dateFormat = DateFormat.jm();
      return dateFormat.format(this).toLowerCase();
    }
    final now = DateTime.now();
    if (year != now.year) {
      final dateFormat = DateFormat.yMMMd();
      return dateFormat.format(this);
    }
    final dateFormat = DateFormat.MMMd();
    return dateFormat.format(this);
  }

  String getTimeOnly() {
    final dateFormat = DateFormat.jm();
    return dateFormat.format(this).toLowerCase();
  }
}
