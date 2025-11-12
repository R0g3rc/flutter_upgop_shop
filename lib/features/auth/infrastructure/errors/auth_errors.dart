class CustomError implements Exception {
  final String message;
  final int statusCode;
  final bool isLogged;

  CustomError(this.message, [this.statusCode = 0, this.isLogged = false]);
}
