
import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ceiba_assessment_test/features/list_posts/data/models/post_model.dart';
import 'package:ceiba_assessment_test/features/list_posts/domain/use_cases/get_posts_by_user.dart';
import 'package:ceiba_assessment_test/features/list_posts/domain/repositories/list_posts_repository.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'get_posts_by_user_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IListPostsRepository>()])
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late GetPostsByUser getPostsByUser;
  late MockIListPostsRepository mockListPostsRepository;

  setUp(() {
    mockListPostsRepository = MockIListPostsRepository();
    getPostsByUser = GetPostsByUser(
      listPostsRepository: mockListPostsRepository
    );
  });

  final testPostsList = (json.decode(fixture('local_posts_list.json')) as List)
    .map((post) => PostModel.fromJson(post)).toList();

  test('Should get list of posts after calling api endpoint', () async{
    when(mockListPostsRepository.getPostsByUser(any)).thenAnswer((_) async => testPostsList);

    final result = await getPostsByUser(1);

    expect(result, testPostsList);
    verify(mockListPostsRepository.getPostsByUser(any));
    verifyNoMoreInteractions(mockListPostsRepository);
  });
}