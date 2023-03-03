import 'dart:io';

import 'package:flutter/material.dart';

mostrarAlerta(BuildContext context, String titulo, Widget child,String btnCancel,String btnOk) {
  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:const RoundedRectangleBorder(
           borderRadius:
      BorderRadius.all(
        Radius.circular(10.0))
        ),
        title: Text(titulo),
        content: child,
        actions: [
          MaterialButton(
            elevation: 5,
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context),
            child: Text(btnCancel,style: const TextStyle(color: Colors.red),),
          ),
          MaterialButton(
            elevation: 5,
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context),
            child: Text(btnOk),
          )
        ],
      ),
    );
  }
}
