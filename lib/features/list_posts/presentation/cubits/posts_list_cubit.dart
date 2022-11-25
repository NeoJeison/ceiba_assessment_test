// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ceiba_assessment_test/features/list_posts/domain/entities/post.dart';
import 'package:ceiba_assessment_test/features/list_posts/domain/use_cases/get_posts_by_user.dart';

part 'posts_list_state.dart';

class PostsListCubit extends Cubit<PostsListState> {

  final GetPostsByUser getPostsByUser;

  PostsListCubit({
    required this.getPostsByUser
  }) : super(Loading());

  Future<void> getPostsFromUser(int userId) async {
    try {
      List<Post> posts = await getPostsByUser(userId);
      if ( posts.isEmpty ) {
        emit(Empty());
      }
      emit(Loaded(posts: posts));
    } catch (e) {
      emit(const Error(message: 'Ha ocurrido un error al intentar cargar los usuarios.'));
    }
  }
}