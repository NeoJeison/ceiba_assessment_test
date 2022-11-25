import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:ceiba_assessment_test/core/utils/constants/api.dart';
import 'package:ceiba_assessment_test/features/list_users/data/models/user_model.dart';

abstract class IUsersRemoteDataSource {
  Future<List<UserModel>> getUsersList();
}

class UsersRemoteDataSource implements IUsersRemoteDataSource {

  final http.Client client;

  UsersRemoteDataSource({ required this.client });

  @override
  Future<List<UserModel>> getUsersList() async {
    
    final response = await client.get(
      Uri.parse('$baseUrl/users'),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List).map((user) => UserModel.fromJson(user)).toList();
    }

    return List.empty();
  }
  
}