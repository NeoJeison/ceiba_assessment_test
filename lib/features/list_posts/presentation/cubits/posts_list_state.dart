part of 'posts_list_cubit.dart';

@immutable
abstract class PostsListState extends Equatable {
  const PostsListState();

  @override
  List<Object> get props => [];
}

class Empty extends PostsListState {}

class Loading extends PostsListState {}

class Loaded extends PostsListState {
  final List<Post> posts;

  const Loaded({required this.posts});

  @override
  List<Object> get props => [ posts ];
}

class Error extends PostsListState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [ message ];
}