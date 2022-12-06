import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../enitites/contact_entity.dart';
import '../enitites/contacts_list.dart';
import '../failure/failures.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<ContactEntity>>> getContactList();

  Future<Either<Failure, ContactEntity>> addNewContact(
      ContactEntity newContact);

  Future<Either<Failure, ContactEntity>> editContact(ContactEntity contact);

  Future<Either<Failure, void>> deleteContact(ContactEntity contact);

  Stream<Either<Failure, ContactsList>> observeContacts(String userId, QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument);

  Future<Either<Failure, ContactEntity>> addNewContactToFirestore(String userId,
      ContactEntity newContact);

  Future<Either<Failure, ContactEntity>> editContactOnFirestore(String userId,
      ContactEntity newContact);
}
