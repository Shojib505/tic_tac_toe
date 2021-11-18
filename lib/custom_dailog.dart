import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget{
  final title;
  final content;
  final VoidCallback callback;
  final actionText;

  CustomDialog(this.title,this.content,this.callback,[this.actionText='Reset']);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        ElevatedButton(
            onPressed: callback, 
            child: Text(actionText))
      ],
    );
  }
  
  
  
}