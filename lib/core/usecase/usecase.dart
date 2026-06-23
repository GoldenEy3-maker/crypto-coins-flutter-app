import "package:flutter_application_1/core/utils/either.dart";

import "../error/failures.dart";

abstract interface class UseCase<ResultType, Params> {
  Future<Either<Failure, ResultType>> call(Params params);
}

final class NoParams {
  const NoParams();
}
