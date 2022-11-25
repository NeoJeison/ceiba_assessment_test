import 'dart:convert';

import 'package:ceiba_assessment_test/features/list_posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

import 'package:ceiba_assessment_test/core/utils/constants/api.dart';

abstract class IPostsRemoteDataSource {
  Future<List<PostModel>> getPostsByUser(int userId);
}

class PostsRemoteDataSource implements IPostsRemoteDataSource {

  final http.Client client;

  PostsRemoteDataSource({ required this.client });

  @override
  Future<List<PostModel>> getPostsByUser(int userId) async {
    
    final response = await client.get(
      Uri.parse('$baseUrl/posts?userId=$userId'),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List).map((post) => PostModel.fromJson(post)).toList();
    }

    return List.empty();
  }
  
}