
import 'dart:convert';

import 'package:ceiba_assessment_test/features/list_users/data/models/user_model.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/repositories/list_users_repository.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/use_cases/save_users_locally.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'get_local_users_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IListUsersRepository>()])
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late SaveUsersLocally saveUsersLocally;
  late MockIListUsersRepository mockListUsersRepository;

  setUp(() {
    mockListUsersRepository = MockIListUsersRepository();
    saveUsersLocally = SaveUsersLocally(
      listUsersRepository: mockListUsersRepository
    );
  });

  final testUsersList = (json.decode(fixture('local_users_list.json')) as List)
    .map((user) => UserModel.fromJson(user)).toList();

  test('Should store a list of user in local database', () async{
    when(mockListUsersRepository.saveUsersLocally(testUsersList)).thenAnswer((_) async => {});

    await saveUsersLocally(testUsersList);

    verify(mockListUsersRepository.saveUsersLocally(testUsersList));
    verifyNoMoreInteractions(mockListUsersRepository);
  });
}