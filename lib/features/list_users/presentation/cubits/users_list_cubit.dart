// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ceiba_assessment_test/features/list_users/domain/entities/user.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/use_cases/get_local_users.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/use_cases/save_users_locally.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/use_cases/get_users_by_request.dart';

part 'users_list_state.dart';

class UsersListCubit extends Cubit<UsersListState> {

  final GetLocalUsers getLocalUsers;
  final GetUsersByRequest getUsersByRequest;
  final SaveUsersLocally saveUsersLocally;

  UsersListCubit({
    required this.getLocalUsers,
    required this.getUsersByRequest,
    required this.saveUsersLocally
  }) : super(Loading());

  Future<void> getUsers() async {
    try {
      List<User> users = await getLocalUsers();
      if ( users.isEmpty ) {
        users = await getUsersByRequest();
        if ( users.isEmpty ) {
          emit(Empty());
          return;
        } else {
          saveUsersLocally(users);
        }
      }
      emit(Loaded(users: users));
    } catch (e) {
      emit(const Error(message: 'Ha ocurrido un error al intentar cargar los usuarios.'));
    }
  }

  void search(String value) {
    final currentState = state;
    if ( currentState is Loaded ) {
      emit(Loading());
      final filteredUsers = [ ...currentState.users ]
        ..removeWhere((user) => !user.name.trim().toLowerCase().contains(value.trim().toLowerCase()));
      emit(Filtered(users: currentState.users, filteredUsers: filteredUsers));
    } 
  }

}