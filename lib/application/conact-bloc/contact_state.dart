part of 'contact_bloc.dart';

@immutable
abstract class ContactState {}

class ContactInitial extends ContactState {}

class LoadingContactsState extends ContactState {}

class AllContactsState extends ContactState {
  final List<ContactEntity> contacts;
  final QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final bool hasMore;

  AllContactsState(
      {required this.contacts,
      required this.hasMore,
      required this.lastDocument});

  AllContactsState copyWith(
      {List<ContactEntity>? contacts,
      QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument,
      bool? hasMore}) {
    return AllContactsState(
        contacts: contacts ?? this.contacts,
        hasMore: hasMore ?? this.hasMore,
        lastDocument: lastDocument ?? this.lastDocument);
  }
}

class FailureContactState extends ContactState {
  final Failure failure;

  FailureContactState({required this.failure});
}

class NewContactIsCreated extends ContactState {
  final ContactEntity contactEntity;

  NewContactIsCreated({required this.contactEntity});
}

class ContactIsEdited extends ContactState {
  final ContactEntity contact;

  ContactIsEdited({required this.contact});
}

class ContactEdited extends ContactState {}

class ContactDeleted extends ContactState {}
