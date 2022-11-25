import 'package:flutter/material.dart';

import 'package:ceiba_assessment_test/core/utils/size_config.dart';
import 'package:ceiba_assessment_test/features/list_posts/domain/entities/post.dart';
import 'package:ceiba_assessment_test/features/list_posts/presentation/widgets/post_card.dart';

class PostsList extends StatelessWidget {
  const PostsList({ required this.posts, Key? key }) : super(key: key);
  
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth! * 0.025
      ),
      itemCount: posts.length,
      itemBuilder: (_, index) {
        return PostCard(post: posts[index]);
      },
    );
  }
}