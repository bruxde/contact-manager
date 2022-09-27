abstract class Failure {
  final String? details;

  Failure({this.details});
}

class CommonFailure extends Failure {}

class ServerFailure extends Failure {
  ServerFailure({String? details}) : super(details: details);
}

class LogicFailure extends Failure {}
