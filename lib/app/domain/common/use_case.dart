abstract class UseCaseWithParam<R, T> {
  Future<R> call(T param);
}

abstract class UseCaseEmptyParam<R> {
  Future<R> call();
}