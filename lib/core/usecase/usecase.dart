import "package:flutter_application_1/core/utils/either.dart";

import "../error/failures.dart";

/// Application-specific business rules.
///
/// Presentation must depend on use cases, not repositories directly.
/// Thin delegates are intentional: they keep a stable boundary and a single
/// place for validation, orchestration, or side effects before/after data access.
abstract interface class UseCase<ResultType, Params> {
  Future<Either<Failure, ResultType>> call(Params params);
}

final class NoParams {
  const NoParams();
}
