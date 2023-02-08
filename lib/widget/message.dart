import 'dart:async';
import 'package:flutter/material.dart';

class ShowMessage extends StatelessWidget {
  const ShowMessage({
    Key? key,
    this.message = "Hello World",
    this.icon = const Icon(
      Icons.message,
      color: Colors.black26,
      size: 103,
    ),
  }) : super(key: key);
  final Icon icon;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: icon,
          ),
          Text(
            message,
            style: TextStyle(color: Colors.black45, fontSize: 30),
          )
        ],
      ),
    );
  }
}
