import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ceiba_assessment_test/features/list_users/data/models/user_model.dart';
import 'package:ceiba_assessment_test/features/list_users/data/datasources/users_local_data_source.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'users_local_data_source_test.mocks.dart';

class PartialMockUsersLocalDataSource extends UsersLocalDataSource {
  final mock = MockDatabase();

  @override
  Future<void> openDB() => Future.value(null);

  @override
  Future<void> closeDB() => Future.value(null);
}

@GenerateNiceMocks([MockSpec<Database>()])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  late PartialMockUsersLocalDataSource localDataSource;
  late MockDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockDatabase();
    localDataSource = PartialMockUsersLocalDataSource();
    localDataSource.database = mockDatabase;
  });

  group('getUsersList', () {
    final testUsersList = (json.decode(fixture('local_users_list.json')) as List)
      .map((user) => UserModel.fromJson(user)).toList();

    test('Should return a list of user from local database when is not empty', () async {
      
      when(mockDatabase.query('users')).thenAnswer((_) async => 
        (json.decode(fixture('local_users_list.json')) as List).map((user) => user as Map<String, dynamic>).toList()
      );

      final result = await localDataSource.getUsersList();

      verify(mockDatabase.query('users'));
      expect(result, equals(testUsersList));
    });

    test('Should return an empty list when there is no users stored in local database', () async {
      
      when(mockDatabase.query('users')).thenAnswer((_) async => List.empty());

      final result = await localDataSource.getUsersList();

      verify(mockDatabase.query('users'));
      expect(result, equals(List.empty()));
    });
  });

  group('saveUsers', () {
    final testUsersList = (json.decode(fixture('local_users_list.json')) as List)
      .map((user) => UserModel.fromJson(user)).toList();

    test('Should store a list of user in local database', () async {

      await localDataSource.saveUsers(testUsersList);

      testUsersList.map((user) => verify(mockDatabase.insert('users', user.toMap(), conflictAlgorithm: any)));
    });
  });
}