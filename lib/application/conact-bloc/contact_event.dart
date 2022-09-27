part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent {}

class GetAllContacts extends ContactEvent {}

class AddNewContact extends ContactEvent {
  final ContactEntity newContact;

  AddNewContact({required this.newContact});
}

class AddNewContactToFirestore extends ContactEvent {
  final String userId;
  final ContactEntity newContact;

  AddNewContactToFirestore({required this.userId, required this.newContact});
}

class EditContact extends ContactEvent {
  final ContactEntity contact;

  EditContact({required this.contact});
}

class DeleteContact extends ContactEvent {
  final ContactEntity contact;

  DeleteContact({required this.contact});
}

class ObserveContacts extends ContactEvent {
  final String userId;

  ObserveContacts({required this.userId});
}

class ObservationFailureEvent extends ContactEvent {
  final Failure failure;

  ObservationFailureEvent({required this.failure});
}

class ObservationContactListEvent extends ContactEvent {
  final List<ContactEntity> contacts;

  ObservationContactListEvent({required this.contacts});
}
