import 'package:another_flushbar/flushbar.dart';
import 'package:evening_stat/utilis/constants.dart';
import 'package:flutter/material.dart';




Future mySuccessSnackBar(BuildContext ctx, IconData icon, String message){
  return Flushbar(
    titleColor: Colors.white,
    margin: const EdgeInsets.only(left: 24.0, right: 24.0, top: 47.0),
    borderRadius: BorderRadius.circular(5.0),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    backgroundColor: primaryLightColor,
    boxShadows: const [BoxShadow(color: Colors.grey, offset: Offset(0.0, 4.0), blurRadius: 3.0)],
    // backgroundGradient: kPrimaryGradientColor,
    isDismissible: false,
    duration: const Duration(seconds: 3),
    icon: Icon(
      icon,
      color: Colors.white,
    ),
    progressIndicatorBackgroundColor: Colors.blueGrey,
    messageText: Text(
      message,
      style: const TextStyle(fontFamily: 'CircularStd',fontSize: 14.0, color: Colors.white),
    ),
  ).show(ctx);
}



Future mySnackBar(BuildContext ctx, IconData icon, String message){
  return Flushbar(
    titleColor: Colors.white,
    margin: const EdgeInsets.only(left: 24.0, right: 24.0, top: 47.0),
    borderRadius: BorderRadius.circular(5.0),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    backgroundColor: Colors.red,
    boxShadows: const [BoxShadow(color: Colors.grey, offset: Offset(0.0, 4.0), blurRadius: 3.0)],
    backgroundGradient: primaryGradient,
    isDismissible: false,
    duration: const Duration(seconds: 3),
    icon: Icon(
      icon,
      color: Colors.white,
    ),
    progressIndicatorBackgroundColor: Colors.blueGrey,
    messageText: Text(
      message,
      style: const TextStyle(fontSize: 14.0, color: whiteColor),
    ),
  ).show(ctx);
}

