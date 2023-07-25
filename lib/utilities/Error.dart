class Failure {
  int? code;
  String message;
  FailureType type;
  Failure(this.message, this.type, [this.code]);
}

enum FailureType { SERVER, LOCAL, OTHER }
