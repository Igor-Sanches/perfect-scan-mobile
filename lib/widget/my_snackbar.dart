import 'package:flutter/material.dart';

class MySnackbar{
  static void myToast(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
    // Scaffold.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(msg),
    //   ),
    // );
  }

  static void myMensage(BuildContext context, String msg){
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        //action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}