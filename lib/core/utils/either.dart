import "package:dartz/dartz.dart" as dartz;

typedef Either<L, R> = dartz.Either<L, R>;

// ignore: non_constant_identifier_names
dartz.Left<L, R> Left<L, R>(L value) => dartz.Left<L, R>(value);
// ignore: non_constant_identifier_names
dartz.Right<L, R> Right<L, R>(R value) => dartz.Right<L, R>(value);

extension EitherExtensions<L, R> on Either<L, R> {
  bool get isLeft => fold((_) => true, (_) => false);
  bool get isRight => fold((_) => false, (_) => true);

  R? get rightOrNull => fold((_) => null, (r) => r);
  L? get leftOrNull => fold((l) => l, (_) => null);
}
