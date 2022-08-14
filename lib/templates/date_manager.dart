const String dateManagerText = '''import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String dateFormat = 'yyyy-MM-dd';
const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
const String humanReadableDateFormat = 'dd MMM yyyy';
const String humanReadableDateFormatShort = 'dd.MM.yy';
const String humanReadableDateTimeFormat = 'dd MMM yyyy H:mm';

DateTime parseDateTime(String raw, {bool toLocal = true}) {
  final DateTime dateTime = DateFormat(dateTimeFormat).parseUtc(raw);
  if (toLocal) {
    return dateTime.toLocal();
  }

  return dateTime;
}

DateTime parseDate(String raw) {
  return DateFormat(dateFormat).parseUtc(raw.substring(0, 10));
}

String formatDateTime(
  DateTime dateTime, {
  bool toUtc = true,
  bool humanReadable = false,
  bool short = false,
  bool withTime = true,
  String? customFormat,
}) {
  DateTime _dateTime = dateTime;
  if (toUtc) {
    _dateTime = dateTime.toUtc();
  }

  String format = dateTimeFormat;
  if (humanReadable && withTime) {
    format = humanReadableDateTimeFormat;
  } else if (humanReadable && short) {
    format = humanReadableDateFormatShort;
  } else if (humanReadable) {
    format = humanReadableDateFormat;
  } else if (!withTime) {
    format = dateFormat;
  }

  if (customFormat != null) {
    format = customFormat;
  }

  return DateFormat(format, 'ru').format(_dateTime);
}

DateTime dateToDayStart(DateTime date) {
  return DateTime(
    date.year,
    date.month,
    date.day,
  );
}

TimeOfDay parseTimeOfDay(String time) {
  final int hour = int.parse(time.substring(0, 2));
  final int minute = int.parse(time.substring(3, 5));

  return TimeOfDay(hour: hour, minute: minute);
}

String getDateName(DateTime dateTime) {
  final DateTime target = dateToDayStart(dateTime);

  DateTime now = dateToDayStart(DateTime.now());
  if (dateTime.isUtc) {
    now = now.toUtc();
  }

  final Duration diff = target.difference(now);
  final int days = diff.inDays;
  if (days == 0) {
    return 'Сегодня';
  }

  if (days == 1) {
    return 'Завтра';
  }

  if (days == 2) {
    return 'Послезавтра';
  }

  if (days == -1) {
    return 'Вчера';
  }

  if (days == -2) {
    return 'Позавчера';
  }

  if (days > 7 || days < 7) {
    return formatDateTime(
      dateTime,
      humanReadable: true,
      withTime: false,
      toUtc: false,
    );
  }

  return [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье',
  ][dateTime.weekday - 1];
}

class DatePeriod {
  final DateTime startDate;
  final DateTime endDate;

  DatePeriod(this.startDate, this.endDate);

  DatePeriod.fromJson(Map json)
      : startDate = parseDate(json['start_date']),
        endDate = parseDate(json['end_date']);

  bool isBetween(DateTime dateTime) {
    return (dateTime.isAfter(startDate) || dateTime == startDate) &&
        (dateTime.isBefore(endDate) || dateTime == endDate);
  }
}

class DateTimePeriod extends DatePeriod {
  DateTimePeriod.fromJson(Map json)
      : super(parseDateTime(json['start_date']), parseDateTime(json['end_date']));
}
''';