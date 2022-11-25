import 'package:ceiba_assessment_test/features/list_posts/data/datasources/posts_remote_data_source.dart';
import 'package:ceiba_assessment_test/features/list_posts/domain/entities/post.dart';
import 'package:ceiba_assessment_test/features/list_posts/domain/repositories/list_posts_repository.dart';

class ListPostsRepository implements IListPostsRepository {

  final IPostsRemoteDataSource remoteDataSource;

  ListPostsRepository({ required this.remoteDataSource });

  @override
  Future<List<Post>> getPostsByUser(int userId) async {
    return await remoteDataSource.getPostsByUser(userId);
  }
  
}