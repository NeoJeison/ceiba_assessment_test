
import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ceiba_assessment_test/features/list_users/data/models/user_model.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/use_cases/get_users_by_request.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'get_local_users_test.mocks.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late GetUsersByRequest getUsersByRequest;
  late MockIListUsersRepository mockListUsersRepository;

  setUp(() {
    mockListUsersRepository = MockIListUsersRepository();
    getUsersByRequest = GetUsersByRequest(
      listUsersRepository: mockListUsersRepository
    );
  });

  final testUsersList = (json.decode(fixture('local_users_list.json')) as List)
    .map((user) => UserModel.fromJson(user)).toList();

  test('Should get list of users after calling api endpoint', () async{
    when(mockListUsersRepository.getUsersByRequest()).thenAnswer((_) async => testUsersList);

    final result = await getUsersByRequest();

    expect(result, testUsersList);
    verify(mockListUsersRepository.getUsersByRequest());
    verifyNoMoreInteractions(mockListUsersRepository);
  });
}