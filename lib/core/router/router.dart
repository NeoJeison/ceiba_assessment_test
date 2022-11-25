

import 'package:ceiba_assessment_test/features/list_posts/presentation/views/list_posts_view.dart';
import 'package:ceiba_assessment_test/features/list_users/presentation/views/list_users_view.dart';
import 'package:flutter/material.dart';

class AppRouter {

  final Map<String, WidgetBuilder> routes = {
    ListUsersView.routeName: (context) => const ListUsersView(),
    ListPostsView.routeName: (context) => const ListPostsView()
  };

}