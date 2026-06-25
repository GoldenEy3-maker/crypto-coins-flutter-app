import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/core/network/api_client.dart";
import "package:flutter_application_1/features/posts/data/datasources/datasources.dart";
import "package:flutter_application_1/features/posts/data/repositories/repositories.dart";
import "package:flutter_application_1/features/posts/domain/repositories/repositories.dart";
import "package:flutter_application_1/features/posts/domain/usecases/usecases.dart";

void registerPostsModule() {
  getIt.registerLazySingleton<PostsRemoteDataSource>(
    () => PostsRemoteDataSourceImpl(apiClient: getIt.get<ApiClient>()),
  );

  getIt.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      remoteDataSource: getIt.get<PostsRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetPosts>(
    () => GetPosts(repository: getIt.get<PostsRepository>()),
  );
}
