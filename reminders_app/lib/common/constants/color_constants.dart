import 'dart:developer';

import 'package:flutter/material.dart';

class ColorConstants
{
  static Map<String,Color> colorMap={
    'blue':Colors.blue,
    'yellow':Colors.yellow,
    'red':Colors.red,
    'green':Colors.green,
    'pink':Colors.pink,
    'brown':Colors.brown,
    'orange':Colors.orange,
  };
  static String getColorString(Color color)
  {

    if(color ==  Color(Colors.blue.value) || color == Color(0xff2196f3))
      return 'blue';
    if(color == Colors.red)
      return 'red';
    if(color == Colors.pink)
      return 'pink';
    if(color ==  Colors.orange)
      return 'orange';
    if(color ==  Colors.yellow)
      return 'yellow';
    if(color ==  Colors.brown)
      return 'brown';
    if(color ==  Colors.green)
      return 'green';
  }
  static String setColorString(Color color)
  {

    if(color ==  Color(Colors.blue.value) || color == Color(0xff2196f3))
      return 'blue';
    if(color == Color(Colors.red.value))
      return 'red';
    if(color == Color(Colors.pink.value))
      return 'pink';
    if(color ==  Color(Colors.orange.value))
      return 'orange';
    if(color ==  Color(Colors.yellow.value))
      return 'yellow';
    if(color ==  Color(Colors.brown.value))
      return 'brown';
    if(color ==  Color(Colors.green.value))
      return 'green';
  }
}