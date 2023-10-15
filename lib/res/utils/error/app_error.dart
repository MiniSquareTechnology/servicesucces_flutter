
class AppError {
  String message;
  int code;
  AppError({
    required this.message,
    this.code = 400,
  });
}
