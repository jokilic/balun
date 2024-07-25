sealed class BalunState<T> {}

class Initial<T> extends BalunState<T> {}

class Loading<T> extends BalunState<T> {}

class Empty<T> extends BalunState<T> {}

class Error<T> extends BalunState<T> {
  final String? error;

  Error({
    required this.error,
  });
}

class Success<T> extends BalunState<T> {
  final T data;

  Success({
    required this.data,
  });
}
