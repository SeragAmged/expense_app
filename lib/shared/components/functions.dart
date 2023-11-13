import 'package:flutter/material.dart';

extension ToStringDateTime on DateTime {
  String convertToString() => convertDateTimeToString(this);
}

String convertDateTimeToString(DateTime dateTime) {
  //convert date time --> ddmmyyyy
  var day = dateTime.day.toString().length == 1
      ? "0${dateTime.day}"
      : dateTime.day.toString();
  var month = dateTime.month.toString().length == 1
      ? "0${dateTime.month}"
      : dateTime.month.toString();

  var year = dateTime.year.toString();

  return "$day-$month-$year"; //--> ddmmyyyy
}

void navigateTo(context, pageTo) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => pageTo),
  );
}

void navigateToWithReplacement(context, pageTo) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => pageTo,
    ),
    (Route<dynamic> route) => false,
  );
}



// void logOut(context) {
//   CacheHelper.removeData(key: 'token').then(
//     (value) {
//       if (value) navigateToWithReplacement(context, const Placeholder());
//     },
//   );
// }
