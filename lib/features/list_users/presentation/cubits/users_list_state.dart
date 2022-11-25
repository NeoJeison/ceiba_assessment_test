part of 'users_list_cubit.dart';

@immutable
abstract class UsersListState extends Equatable {
  const UsersListState();

  @override
  List<Object> get props => [];
}

class Empty extends UsersListState {}

class Loading extends UsersListState {}

class Loaded extends UsersListState {
  final List<User> users;

  const Loaded({required this.users});

  @override
  List<Object> get props => [ users ];
}

class Filtered extends Loaded {
  final List<User> filteredUsers;

  const Filtered({ required super.users, required this.filteredUsers });

  @override
  List<Object> get props => [ users, filteredUsers ];
}

class Error extends UsersListState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [ message ];
}