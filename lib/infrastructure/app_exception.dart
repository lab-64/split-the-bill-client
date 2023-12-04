/// Base class for all client-side errors
sealed class AppException implements Exception {
  AppException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}

/// API
class UnauthenticatedException extends AppException {
  UnauthenticatedException(String message) : super('unauthenticated', message);
}

class NoInternetConnectionException extends AppException {
  NoInternetConnectionException()
      : super('no-internet', 'No Internet connection');
}

class NotFoundException extends AppException {
  NotFoundException(String message) : super('not-found', message);
}

class UnknownException extends AppException {
  UnknownException(String message) : super('unknown-error', message);
}

/// item
 class ItemNotFoundException extends AppException {
   ItemNotFoundException() : super('item-not-found', 'Item not found');
 }
