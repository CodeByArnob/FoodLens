class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  AppException(this.message, {this.code, this.details});

  @override
  String toString() => 'AppException: $message (code: $code)';
}

class PuterInsufficientFundsException extends AppException {
  final String upgradeUrl;

  PuterInsufficientFundsException({
    String message = 'Your Puter monthly AI allowance has been exhausted.',
    this.upgradeUrl = 'https://puter.com/account',
    String? code = 'insufficient_funds',
  }) : super(message, code: code);
}

class PuterAuthException extends AppException {
  PuterAuthException(super.message, {super.code = 'auth_error'});
}

class NetworkException extends AppException {
  NetworkException(super.message, {super.code = 'network_error'});
}
