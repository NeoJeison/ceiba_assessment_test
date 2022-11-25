import 'package:flutter/material.dart';

import 'package:ceiba_assessment_test/core/utils/size_config.dart';
import 'package:ceiba_assessment_test/core/widgets/text_display.dart';
import 'package:ceiba_assessment_test/core/utils/constants/styles.dart';
import 'package:ceiba_assessment_test/core/widgets/information_item.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/entities/user.dart';
import 'package:ceiba_assessment_test/features/list_posts/presentation/views/list_posts_view.dart';

class UserCard extends StatelessWidget {
  const UserCard({ required this.user, Key? key }) : super(key: key);

  final User user;

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
              message: user.name,
              style: const TextStyle(
                color: cDarkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            ),
            InformationItem(icon: Icons.phone, item: user.phone),
            InformationItem(icon: Icons.email, item: user.email),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ListPostsView.routeName, arguments: user);
                },
                child: const TextDisplay(
                  message: 'VER PUBLICACIONES',
                  style: TextStyle(
                    color: cDarkGreen,
                    fontWeight: FontWeight.bold,
                  ),
                )
              )
            )
          ],
        ),
      )
    );
  }
}