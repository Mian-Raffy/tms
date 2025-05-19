class AppException implements Exception {
  final String? message; // Error message
  final String? prefix; // Optional prefix (e.g., error type)

  AppException([
    this.message,
    this.prefix,
  ]);

  @override
  String toString() {
    return '$prefix$message';
  }
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url]) : super(message, '');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message, String? url])
      : super(
          message,
          'The Account Not Found',
        );
}

class NotFoundException extends AppException {
  NotFoundException([String? message, String? url])
      : super(
          message,
          'Not Found Any Data ',
        );
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException([String? message, String? url])
      : super(
          message,
          'Internal Server Error',
        );
}

class TimeoutException extends AppException {
  TimeoutException([String? message])
      : super(message, 'Request timed out. Please try again.');
}

class NoInternetException extends AppException {
  NoInternetException([String? message])
      : super(message, 'No Internet Connection: ');
}

class UnknownException extends AppException {
  UnknownException([String? message, String? url])
      : super(message, 'Unknown Error:');
}
