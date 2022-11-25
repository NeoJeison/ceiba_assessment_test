import 'package:ceiba_assessment_test/features/list_users/domain/entities/user.dart';
import 'package:ceiba_assessment_test/features/list_users/data/models/user_model.dart';
import 'package:ceiba_assessment_test/features/list_users/data/datasources/users_local_data_source.dart';
import 'package:ceiba_assessment_test/features/list_users/data/datasources/users_remote_data_source.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/repositories/list_users_repository.dart';

class ListUsersRepository implements IListUsersRepository {

  final IUsersRemoteDataSource remoteDataSource;
  final IUsersLocalDataSource localDataSource;

  ListUsersRepository({ required this.remoteDataSource, required this.localDataSource });
  
  @override
  Future<List<User>> getLocalUsers() async {
    return await localDataSource.getUsersList();
  }

  @override
  Future<List<User>> getUsersByRequest() async {
    return await remoteDataSource.getUsersList();
  }
  
  @override
  Future<void> saveUsersLocally(List<User> users) async {
    final castedUsers = users.map((user) => UserModel(id: user.id, name: user.name, email: user.email, phone: user.phone)).toList();
    await localDataSource.saveUsers(castedUsers);
  }
  
}