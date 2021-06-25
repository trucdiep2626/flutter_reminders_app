import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'create_list_state.dart';


class ListStream {
  Color listColor = Colors.blue;
  String name;
  bool clearButton = false;
  CreateListState createListState =
  CreateListState(listColor: Colors.blue, clearButton: false);

  StreamController createListController = StreamController<CreateListState>();

  Stream get createListStream => createListController.stream;

  void setClearButton(bool value) {
    clearButton = value;
    log(clearButton.toString());
    createListController.sink.add(
        createListState.update(clearButton: clearButton,listColor: listColor));
  }

  void setColor(Color value) {
    listColor = value;
    createListController.sink.add(createListState.update(
        listColor: listColor,clearButton: clearButton));
  }

  void setName(String value) {
    name = value;
    log(name);
    createListController.sink.add(createListState.update(name: name,clearButton: clearButton,listColor: listColor));
  }

  void dispose() {
    createListController.close();
  }
}