import 'package:ceiba_assessment_test/features/list_users/domain/entities/user.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/repositories/list_users_repository.dart';

class SaveUsersLocally {
  final IListUsersRepository listUsersRepository;

  SaveUsersLocally({ required this.listUsersRepository });

  Future<void> call(List<User> users) async {
    return await listUsersRepository.saveUsersLocally(users);
  }
}