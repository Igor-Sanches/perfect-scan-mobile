import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Navigation{
  static push(Widget page, BuildContext context){
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Navigator.push(context, MaterialPageRoute<void>(builder: (_) => page));
    });
   }

  static pushReplacement(Widget page, BuildContext context){
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => page,
        ),
      );
    });
  }
}