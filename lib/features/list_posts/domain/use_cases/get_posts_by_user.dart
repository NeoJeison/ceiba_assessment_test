import 'package:ceiba_assessment_test/features/list_posts/domain/entities/post.dart';
import 'package:ceiba_assessment_test/features/list_posts/domain/repositories/list_posts_repository.dart';

class GetPostsByUser {
  final IListPostsRepository listPostsRepository;

  GetPostsByUser({ required this.listPostsRepository });

  Future<List<Post>> call(int userId) async {
    return await listPostsRepository.getPostsByUser(userId);
  }
}