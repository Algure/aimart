
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

const kNavTextStyle =  TextStyle(color: Colors.white);

void uShowOkNotification(String text){
  showSimpleNotification(
      Text(text, style: kNavTextStyle,),
      background: Colors.green);
}

void uShowErrorNotification(String text){
  showSimpleNotification(
      Text(text, style: kNavTextStyle,),
      leading:Icon(Icons.warning, color:Colors.white),
      background: Colors.red);
}
