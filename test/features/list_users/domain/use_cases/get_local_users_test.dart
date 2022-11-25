
import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ceiba_assessment_test/features/list_users/data/models/user_model.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/repositories/list_users_repository.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/use_cases/get_local_users.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'get_local_users_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IListUsersRepository>()])
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late GetLocalUsers getLocalUsers;
  late MockIListUsersRepository mockListUsersRepository;

  setUp(() {
    mockListUsersRepository = MockIListUsersRepository();
    getLocalUsers = GetLocalUsers(
      listUsersRepository: mockListUsersRepository
    );
  });

  final testUsersList = (json.decode(fixture('local_users_list.json')) as List)
    .map((user) => UserModel.fromJson(user)).toList();

  test('Should get local list of users stored in database', () async{
    when(mockListUsersRepository.getLocalUsers()).thenAnswer((_) async => testUsersList);

    final result = await getLocalUsers();

    expect(result, testUsersList);
    verify(mockListUsersRepository.getLocalUsers());
    verifyNoMoreInteractions(mockListUsersRepository);
  });
}