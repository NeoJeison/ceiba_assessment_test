import 'package:ceiba_assessment_test/features/list_posts/domain/entities/post.dart';

abstract class IListPostsRepository {
  Future<List<Post>> getPostsByUser(int userId);
}