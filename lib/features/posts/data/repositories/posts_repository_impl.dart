import "package:flutter_application_1/core/error/error_mapper.dart";
import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/utils/either.dart";

import "../../domain/entities/entities.dart";
import "../../domain/repositories/repositories.dart";
import "../datasources/datasources.dart";
import "../../domain/usecases/usecases.dart";

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource _remoteDataSource;

  PostsRepositoryImpl({required PostsRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<Post>>> getPosts(GetPostsParams params) async {
    try {
      final remoteResult = await _remoteDataSource.getPosts(params);
      return remoteResult.fold(
        (failure) => Left(failure),
        (posts) => Right(posts.map((post) => post.toEntity()).toList()),
      );
    } catch (error) {
      return Left(mapExceptionToFailure(error));
    }
  }
}
