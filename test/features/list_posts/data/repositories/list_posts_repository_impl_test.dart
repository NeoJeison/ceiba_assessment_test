import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ceiba_assessment_test/features/list_posts/data/models/post_model.dart';
import 'package:ceiba_assessment_test/features/list_posts/data/datasources/posts_remote_data_source.dart';
import 'package:ceiba_assessment_test/features/list_posts/data/repositories/list_posts_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'list_posts_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IPostsRemoteDataSource>()])
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late ListPostsRepository listPostsRepository;
  late MockIPostsRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockIPostsRemoteDataSource();
    listPostsRepository = ListPostsRepository(
      remoteDataSource: mockRemoteDataSource
    );
  });

  final testPostsList = (json.decode(fixture('local_posts_list.json')) as List)
    .map((post) => PostModel.fromJson(post)).toList();

  test('Should return a list of posts after api request returns a list of elements', () async {
    
    when(mockRemoteDataSource.getPostsByUser(any)).thenAnswer((_) async => testPostsList);

    final result = await listPostsRepository.getPostsByUser(1);

    verify(mockRemoteDataSource.getPostsByUser(any));
    expect(result, equals(testPostsList));
  });

  test('Should return an empty list when api request returns no elements', () async {
    
    when(mockRemoteDataSource.getPostsByUser(any)).thenAnswer((_) async => List.empty());

    final result = await listPostsRepository.getPostsByUser(1);

    verify(mockRemoteDataSource.getPostsByUser(any));
    expect(result, equals(List.empty()));
  });
}