import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewListProvider with  ChangeNotifier,DiagnosticableTreeMixin{
  Color listColor=Colors.blue;
  String name;
  bool clearButton=false;
  void setClearButton(bool value)
  {
    clearButton=value;
    log(clearButton.toString());
    notifyListeners();
  }
  void setColor(Color value)
  {
    listColor=value;
    notifyListeners();
  }
  void setName(String value)
  {
    name=value;
    log(name);
    notifyListeners();
  }
}