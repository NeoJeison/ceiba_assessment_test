import 'package:flutter/material.dart';

class TextDisplay extends StatelessWidget {
  const TextDisplay({ required this.message, this.style, Key? key }) : super(key: key);

  final String message;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: style?? const TextStyle(
        color: Colors.black
      )
    );
  }
}