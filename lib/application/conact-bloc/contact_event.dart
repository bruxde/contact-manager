part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class GetAllContacts extends ContactEvent {}

class AddNewContact extends ContactEvent {
  final ContactEntity newContact;

  AddNewContact(
      {required this.newContact});
}
