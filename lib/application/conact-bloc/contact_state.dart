part of 'contact_bloc.dart';

@immutable
abstract class ContactState {}

class ContactInitial extends ContactState {}

class LoadingContactsState extends ContactState {}

class AllContactsState extends ContactState {}
