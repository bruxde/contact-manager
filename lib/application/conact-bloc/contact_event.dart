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

class EditContactOnFirestore extends ContactEvent {
  final String userId;
  final ContactEntity contact;

  EditContactOnFirestore({required this.userId, required this.contact});
}

class DeleteContact extends ContactEvent {
  final ContactEntity contact;

  DeleteContact({required this.contact});
}

class ObserveContacts extends ContactEvent {
  final String userId;
  final QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument;

  ObserveContacts({required this.userId, required this.lastDocument});
}

class ObservationFailureEvent extends ContactEvent {
  final Failure failure;

  ObservationFailureEvent({required this.failure});
}

class ObservationContactListEvent extends ContactEvent {
  final List<ContactEntity> contacts;
  final QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final bool hasMore;

  ObservationContactListEvent(
      {required this.contacts,
      required this.hasMore,
      required this.lastDocument});
}
