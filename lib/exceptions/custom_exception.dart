class CustomException implements Exception {
  final String? message;
  final int? errorCode;
  final Map<String,dynamic>? errors;

  CustomException({ this.message, this.errorCode,this.errors});
  @override
  String toString() {
    // TODO: implement toString
    return 'CustomException: $message (Error Code: $errorCode ) Errors:${errors}';
  }
}
