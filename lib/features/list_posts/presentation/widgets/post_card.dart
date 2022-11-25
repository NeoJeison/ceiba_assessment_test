import 'package:flutter/material.dart';

import 'package:ceiba_assessment_test/core/utils/size_config.dart';
import 'package:ceiba_assessment_test/core/widgets/text_display.dart';
import 'package:ceiba_assessment_test/core/utils/constants/styles.dart';
import 'package:ceiba_assessment_test/features/list_posts/domain/entities/post.dart';

class PostCard extends StatelessWidget {
  const PostCard({ required this.post, Key? key}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight! * 0.015,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight! * 0.025,
          horizontal: SizeConfig.screenWidth! * 0.05
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextDisplay(
              message: post.title,
              style: const TextStyle(
                color: cDarkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            ),
            TextDisplay(message: post.body)
          ],
        ),
      )
    );
  }
}