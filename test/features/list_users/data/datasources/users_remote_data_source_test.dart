import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'users_remote_data_source_test.mocks.dart';

import 'package:ceiba_assessment_test/features/list_users/data/models/user_model.dart';
import 'package:ceiba_assessment_test/features/list_users/data/datasources/users_remote_data_source.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late UsersRemoteDataSource remoteDataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    remoteDataSource = UsersRemoteDataSource(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('local_users_list.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getUsersList', () {
    final testUsersList = (json.decode(fixture('local_users_list.json')) as List)
      .map((user) => UserModel.fromJson(user)).toList();
      
    test('Should return a list of users when the response code is 200', () async {
        setUpMockHttpClientSuccess200();

        final result = await remoteDataSource.getUsersList();

        expect(result, equals(testUsersList));
      },
    );

    test('Should return an empty list of users when the response is 404', () async {
        setUpMockHttpClientFailure404();

        final result = await remoteDataSource.getUsersList();

        expect(result, equals(List.empty()));
      },
    );
  });
}