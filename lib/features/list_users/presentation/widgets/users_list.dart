import 'package:flutter/material.dart';

import 'package:ceiba_assessment_test/core/utils/size_config.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/entities/user.dart';
import 'package:ceiba_assessment_test/features/list_users/presentation/widgets/user_card.dart';

class UsersList extends StatelessWidget {
  const UsersList({ required this.users, Key? key }) : super(key: key);

  final List<User> users;

  @override
  Widget build (BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth! * 0.025
      ),
      itemCount: users.length,
      itemBuilder: (_, index) {
        return UserCard(user: users[index]);
      },
    );
  }
}