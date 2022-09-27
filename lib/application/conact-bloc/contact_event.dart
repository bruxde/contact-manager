part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class GetAllContacts extends ContactEvent {}

class AddNewContact extends ContactEvent {
  final ContactEntity newContact;

  AddNewContact({required this.newContact});
}

class EditContact extends ContactEvent {
  final ContactEntity contact;

  EditContact({required this.contact});
}

class DeleteContact extends ContactEvent {
  final ContactEntity contact;

  DeleteContact({required this.contact});
}

class ObserveContacts extends ContactEvent {}

class ObservationFailureEvent extends ContactEvent {
  final Failure failure;

  ObservationFailureEvent({required this.failure});
}

class ObservationContactListEvent extends ContactEvent {
  final List<ContactEntity> contacts;

  ObservationContactListEvent({required this.contacts});
}
