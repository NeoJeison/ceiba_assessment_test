import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

import 'package:ceiba_assessment_test/features/list_posts/data/datasources/posts_remote_data_source.dart';
import 'package:ceiba_assessment_test/features/list_posts/data/models/post_model.dart';

import 'posts_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late PostsRemoteDataSource remoteDataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    remoteDataSource = PostsRemoteDataSource(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('local_posts_list.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getPostsByUser', () {
    final testPostsList = (json.decode(fixture('local_posts_list.json')) as List)
      .map((post) => PostModel.fromJson(post)).toList();
      
    test('Should return a list of posts when the response code is 200', () async {
        setUpMockHttpClientSuccess200();

        final result = await remoteDataSource.getPostsByUser(1);

        expect(result, equals(testPostsList));
      },
    );

    test('Should return an empty list of posts when the response is 404', () async {
        setUpMockHttpClientFailure404();

        final result = await remoteDataSource.getPostsByUser(1);

        expect(result, equals(List.empty()));
      },
    );
  });
}