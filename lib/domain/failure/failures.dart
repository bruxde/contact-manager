abstract class Failure {
  final String? details;

  Failure({this.details});
}

class CommonFailure extends Failure {}

class ServerFailure extends Failure {}

class LogicFailure extends Failure {}
