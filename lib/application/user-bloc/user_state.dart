part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserAuthenticatedState extends UserState {
  final String? name;
  final String? email;
  final String? photoURL;

  UserAuthenticatedState(
      {required this.name, required this.email, required this.photoURL});
}

class UserUnAuthenticatedState extends UserState {}
