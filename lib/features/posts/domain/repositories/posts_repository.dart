import "package:flutter_application_1/core/error/failures.dart";
import "package:flutter_application_1/core/utils/either.dart";

import "../entities/entities.dart";
import "../usecases/usecases.dart";

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getPosts(GetPostsParams params);
}
