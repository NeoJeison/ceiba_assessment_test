import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ceiba_assessment_test/features/list_users/data/models/user_model.dart';
import 'package:ceiba_assessment_test/features/list_users/data/datasources/users_local_data_source.dart';
import 'package:ceiba_assessment_test/features/list_users/data/datasources/users_remote_data_source.dart';
import 'package:ceiba_assessment_test/features/list_users/data/repositories/list_users_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'list_users_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IUsersLocalDataSource>(), MockSpec<IUsersRemoteDataSource>()])
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late ListUsersRepository listUsersRepository;
  late MockIUsersLocalDataSource mockLocalDataSource;
  late MockIUsersRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockLocalDataSource = MockIUsersLocalDataSource();
    mockRemoteDataSource = MockIUsersRemoteDataSource();
    listUsersRepository = ListUsersRepository(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource
    );
  });

  final testUsersList = (json.decode(fixture('local_users_list.json')) as List)
    .map((user) => UserModel.fromJson(user)).toList();

  group('getLocalUsers', () {

    test('Should return a list of user from local database when is not empty', () async {
      
      when(mockLocalDataSource.getUsersList()).thenAnswer((_) async => testUsersList);

      final result = await listUsersRepository.getLocalUsers();

      verify(mockLocalDataSource.getUsersList());
      expect(result, equals(testUsersList));
    });

    test('Should return an empty list when there is no users stored in local database', () async {
      
      when(mockLocalDataSource.getUsersList()).thenAnswer((_) async => List.empty());

      final result = await listUsersRepository.getLocalUsers();

      verify(mockLocalDataSource.getUsersList());
      expect(result, equals(List.empty()));
    });
  });

  group('getUsersByRequest', () {

    test('Should return a list of user after api request returns a list of elements', () async {
      
      when(mockRemoteDataSource.getUsersList()).thenAnswer((_) async => testUsersList);

      final result = await listUsersRepository.getUsersByRequest();

      verify(mockRemoteDataSource.getUsersList());
      expect(result, equals(testUsersList));
    });

    test('Should return an empty list when api request returns no elements', () async {
      
      when(mockRemoteDataSource.getUsersList()).thenAnswer((_) async => List.empty());

      final result = await listUsersRepository.getUsersByRequest();

      verify(mockRemoteDataSource.getUsersList());
      expect(result, equals(List.empty()));
    });
  });

  group('saveUsersLocally', () {

    test('Should store a list of user in local database', () async {
      
      when(mockLocalDataSource.saveUsers(testUsersList)).thenAnswer((_) async => {});

      await listUsersRepository.saveUsersLocally(testUsersList);

      verify(mockLocalDataSource.saveUsers(testUsersList));
    });
  });
}