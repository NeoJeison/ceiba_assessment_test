import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:ceiba_assessment_test/features/list_users/domain/use_cases/get_local_users.dart';
import 'package:ceiba_assessment_test/features/list_posts/domain/use_cases/get_posts_by_user.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/use_cases/save_users_locally.dart';
import 'package:ceiba_assessment_test/features/list_posts/presentation/cubits/posts_list_cubit.dart';
import 'package:ceiba_assessment_test/features/list_users/presentation/cubits/users_list_cubit.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/use_cases/get_users_by_request.dart';
import 'package:ceiba_assessment_test/features/list_users/data/datasources/users_local_data_source.dart';
import 'package:ceiba_assessment_test/features/list_posts/domain/repositories/list_posts_repository.dart';
import 'package:ceiba_assessment_test/features/list_users/data/datasources/users_remote_data_source.dart';
import 'package:ceiba_assessment_test/features/list_users/domain/repositories/list_users_repository.dart';
import 'package:ceiba_assessment_test/features/list_posts/data/datasources/posts_remote_data_source.dart';
import 'package:ceiba_assessment_test/features/list_posts/data/repositories/list_posts_repository_impl.dart';
import 'package:ceiba_assessment_test/features/list_users/data/repositories/list_users_repository_impl.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {

  // Cubits
  // > User
  getIt.registerFactory(() => UsersListCubit(getLocalUsers: getIt(), saveUsersLocally: getIt(), getUsersByRequest: getIt()));
  // > Posts
  getIt.registerFactory(() => PostsListCubit(getPostsByUser: getIt()));
  

  // Use cases
  // > User
  getIt.registerLazySingleton(() => GetLocalUsers(listUsersRepository: getIt()));
  getIt.registerLazySingleton(() => GetUsersByRequest(listUsersRepository: getIt()));
  getIt.registerLazySingleton(() => SaveUsersLocally(listUsersRepository: getIt()));
  // > Posts
  getIt.registerLazySingleton(() => GetPostsByUser(listPostsRepository: getIt()));

  // Repositories
  // > User
  getIt.registerLazySingleton<IListUsersRepository>(() => ListUsersRepository(remoteDataSource: getIt(), localDataSource: getIt()));
  // > Posts
  getIt.registerLazySingleton<IListPostsRepository>(() => ListPostsRepository(remoteDataSource: getIt()));

  // Data
  // > User
  getIt.registerLazySingleton<IUsersRemoteDataSource>(() => UsersRemoteDataSource(client: getIt()));
  getIt.registerLazySingleton<IUsersLocalDataSource>(() => UsersLocalDataSource());
  // > Posts
  getIt.registerLazySingleton<IPostsRemoteDataSource>(() => PostsRemoteDataSource(client: getIt()));

  // External
  getIt.registerLazySingleton(() => http.Client());
}