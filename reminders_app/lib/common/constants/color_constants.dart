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
    log(color.toString());
    if(color ==  Color(Colors.blue.value))
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

  }
}