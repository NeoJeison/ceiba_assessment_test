import 'package:ceiba_assessment_test/features/list_users/domain/entities/user.dart';

abstract class IListUsersRepository {
  Future<List<User>> getLocalUsers();
  Future<List<User>> getUsersByRequest();
  Future<void> saveUsersLocally(List<User> users);
}