import "package:dio/dio.dart";
import "package:flutter_application_1/core/config/env.dart";
import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/network/api_client.dart";
import "package:flutter_application_1/core/network/dio_failure_mapper.dart";
import "package:flutter_application_1/core/utils/either.dart";

import "../../domain/usecases/usecases.dart";
import "../models/models.dart";

abstract class PostsRemoteDataSource {
  Future<Either<Failure, List<PostModel>>> getPosts(GetPostsParams params);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final ApiClient _apiClient;

  PostsRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<Either<Failure, List<PostModel>>> getPosts(
    GetPostsParams params,
  ) async {
    try {
      final response = await _apiClient.client.get(
        "${Env.jsonPlaceholderBaseUrl}/posts",
        queryParameters: {"_limit": params.limit, "_start": params.start},
      );
      final data = response.data as List<dynamic>;
      return Right(data.map((e) => PostModel.fromJson(e)).toList());
    } on DioException catch (e) {
      return Left(mapDioException(e));
    } catch (e) {
      return Left(ServerFailure("Invalid posts response: $e"));
    }
  }
}
