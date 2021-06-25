import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReminderProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String title;
  String notes;
  String list = 'Reminders';
  var details;

  void setDetails(var value) {
    details = value;
    notifyListeners();
  }

  void setList(String value) {
    list = value;
    notifyListeners();
  }

  void test() {
    //log(allReminder.length.toString()+'@@@@@@@@@@@@');
  }

  void setTitle(String value) {
    title = value;
    //  log(MyLists.length.toString());
    log(title);
    notifyListeners();
  }

  void setNote(String value) {
    notes = value;
    log(notes);
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
