import 'package:ceiba_assessment_test/features/list_users/domain/entities/user.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/repositories/list_users_repository.dart';

class GetLocalUsers {
  final IListUsersRepository listUsersRepository;

  GetLocalUsers({ required this.listUsersRepository });

  Future<List<User>> call() async {
    return await listUsersRepository.getLocalUsers();
  }
}