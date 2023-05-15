import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'function_helper.dart';

class HelperFunctions {
  static HelperFunctions slt = HelperFunctions();

  notifyUser({required context, message, color, bool isNeedPop = false}) {
    return  Flushbar(
      padding: const EdgeInsets.all(30),
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.black,
      animationDuration: Duration(milliseconds: 400),
      leftBarIndicatorColor: color,
    )..show(context).whenComplete(() {
      if (isNeedPop) pop(context);
    });
  }



  showSheet(BuildContext context,child) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return child;
      },
    );
  }






}
