import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/usecase/usecase.dart";
import "package:flutter_application_1/core/utils/either.dart";

import "../../params/params.dart";
import "../entities/entities.dart";
import "../repositories/repositories.dart";

class GetPosts implements UseCase<List<Post>, GetPostsParams> {
  final PostsRepository _repository;

  GetPosts({required PostsRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, List<Post>>> call(GetPostsParams params) =>
      _repository.getPosts(params);
}
