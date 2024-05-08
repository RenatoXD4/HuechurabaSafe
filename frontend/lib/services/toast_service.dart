import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ToastService{
  
  static toastService(String mensaje, Color? backgroundColor){
      Fluttertoast.showToast(
          msg: mensaje,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: backgroundColor,
          textColor: Colors.white,
          fontSize: 16.0
      );
  }

}