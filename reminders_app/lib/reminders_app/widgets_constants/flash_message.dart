import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlashMessage extends SnackBar {
  final String type;

  FlashMessage({@required this.type})
      : super(
        //  duration: Duration(seconds: 1),
          content: Row(
            children: [
              Visibility(
                visible: type == 'Success' ? true : false,
                child: Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )),
              ),
              Visibility(
                visible: type == 'Fail' ? true : false,
                child: Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    )),
              ),
              Expanded(
                flex: 10,
                child: Text(
                  type == 'Success'
                      ? 'Success'
                      : 'Something went wrong. Please try again',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          elevation: 0,
          // backgroundColor: Colors.gre,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
}
