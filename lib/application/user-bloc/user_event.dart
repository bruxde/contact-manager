part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoginViaGoogle extends UserEvent {}

class LoginViaCredential extends UserEvent {
  final String? email;
  final String? password;

  LoginViaCredential({required this.email, required this.password});
}

class UserIsSignedOut extends UserEvent {}

class UserIsSignedIn extends UserEvent {
  final String userId;
  final String? name;
  final String? email;
  final String? photoURL;

  UserIsSignedIn(
      {required this.userId, required this.name, required this.email, required this.photoURL});
}

class SignOut extends UserEvent {}
