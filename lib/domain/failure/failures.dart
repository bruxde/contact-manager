abstract class Failure {
  final String? details;

  Failure({this.details});
}

class ServerFailure extends Failure {}

class LogicFailure extends Failure {}
