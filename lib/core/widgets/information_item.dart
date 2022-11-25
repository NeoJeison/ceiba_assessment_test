import 'package:flutter/material.dart';

import 'package:ceiba_assessment_test/core/widgets/text_display.dart';
import 'package:ceiba_assessment_test/core/utils/constants/styles.dart';

class InformationItem extends StatelessWidget {
  const InformationItem({ required this.icon, required this.item, Key? key }) : super(key: key);

  final IconData icon;
  final String item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Icon(icon, color: cDarkGreen),
        ),
        TextDisplay(
          message:item,
        ),
      ]
    );
  }
}