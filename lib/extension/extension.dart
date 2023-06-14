
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}


extension StringDate on String {
  static String toDate(String serverDate,String format){
    var date = DateTime.parse(serverDate);
    return DateFormat(format).format(date);
  }



  static String toDateServer(String serverDate,String format){
    if(serverDate.isEmpty){
      return "";
    }
    var date = DateTime.parse(serverDate);
    DateTime localDatetime = DateTime.now();
    var timezoneOffset = localDatetime.timeZoneOffset;
    var timeDiff = Duration(hours: timezoneOffset.inHours, minutes: timezoneOffset.inMinutes % 60);
    date = date.add(timeDiff);

    // DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ").parse(serverDate);
    // var inputDate = DateTime.parse(parseDate.toString());
    // var outputFormat = DateFormat(format);
    // var outputDate = outputFormat.format(inputDate);
    return formatISODate(date,format);
  }

  static DateTime formatStringDate(String? dateTime, {String? format}) {
    try {
      if (format?.isNotEmpty == true) {
        var sdf = DateFormat(format);
        return sdf.parse(dateTime!);
      } else {
        var sdf = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ");
        return sdf.parse(dateTime!);
      }
    } catch (error) {}
    return DateTime.now();
  }

  static String formatISODate(DateTime? dateTime, String format) {
    try {
      if(dateTime == null){
        return "";
      }
      var sdf = DateFormat(format);
      return sdf.format(dateTime);
    } catch (error) {}
    return '';
  }
}


extension StringUtils on String{
  static String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-1095476231683472/6484175386';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-1095476231683472/3788680544';
    }
    return "";
  }
}

