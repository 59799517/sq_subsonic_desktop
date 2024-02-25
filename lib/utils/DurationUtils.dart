import 'package:flutter/material.dart';

class DurationUtils{
  static Duration getDuration(dynamic durationParam) {
    if (durationParam is String) {
      return Duration(seconds: int.parse(durationParam));
    }
    if (durationParam is int) {
      return Duration(seconds: durationParam);
    }

    return Duration(seconds: 0);
  }
  static Duration getDuration2(dynamic durationParam) {
    if (durationParam is String) {
      return Duration(milliseconds: int.parse(durationParam));
    }
    if (durationParam is int) {
      return Duration(milliseconds: durationParam);
    }

    return Duration(milliseconds: 0);
  }
  static String formatDurationBySeconds(int format) {
    var duration = getDuration(format);
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    if (duration.inMicroseconds == 0) {
      return "0:00";
    }

    final hours = duration.inHours;
    var minutes = duration.inMinutes;
    if (minutes > 75) {
      minutes = minutes - (hours * 60);
      var seconds = duration.inSeconds - (minutes * 60);
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      var seconds = duration.inSeconds - (minutes * 60);
      return '$minutes:${twoDigits(seconds)}';
    }
  }


  static String formatDurationByMilliseconds(int format) {
    var duration = getDuration2(format);
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    if (duration.inMicroseconds == 0) {
      return "0:00";
    }

    final hours = duration.inHours;
    var minutes = duration.inMinutes;
    if (minutes > 75) {
      minutes = minutes - (hours * 60);
      var seconds = duration.inSeconds - (minutes * 60);
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      var seconds = duration.inSeconds - (minutes * 60);
      return '$minutes:${twoDigits(seconds)}';
    }
  }



  static String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    if (duration.inMicroseconds == 0) {
      return "0:00";
    }

    final hours = duration.inHours;
    var minutes = duration.inMinutes;
    if (minutes > 75) {
      minutes = minutes - (hours * 60);
      var seconds = duration.inSeconds - (minutes * 60);
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      var seconds = duration.inSeconds - (minutes * 60);
      return '$minutes:${twoDigits(seconds)}';
    }
  }

  static bool parseStarred(dynamic value) {
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  static DateTime? parseDateTime(String? value) {
    if (value != null) {
      return DateTime.tryParse(value);
    } else {
      return null;
    }
  }
}
