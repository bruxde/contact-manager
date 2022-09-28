import 'package:contactmanager/application/conact-bloc/contact_bloc.dart';
import 'package:contactmanager/domain/enitites/contact_entity.dart';
import 'package:contactmanager/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';

import '../failure/failures.dart';

class ContactUsecases {
  final ContactRepository contactRepository;

  ContactUsecases({required this.contactRepository});

  Future<Either<Failure, List<ContactEntity>>> getContactList() async {
    return contactRepository.getContactList();
  }

  Future<Either<Failure, ContactEntity>> addNewContact(
      ContactEntity newContact) async {
    return contactRepository.addNewContact(newContact);
  }

  Future<Either<Failure, ContactEntity>> editContact(
      ContactEntity contact) async {
    return contactRepository.editContact(contact);
  }

  Future<Either<Failure, void>> deleteContact(ContactEntity contact) async {
    return contactRepository.deleteContact(contact);
  }

  Stream<Either<Failure, List<ContactEntity>>> observeContacts(String userId) {
    return contactRepository.observeContacts(userId);
  }

  Future<Either<Failure, ContactEntity>> addNewContactToFirestore(String userId, ContactEntity newContact){
    return contactRepository.addNewContactToFirestore(userId, newContact);
  }

  Future<Either<Failure, ContactEntity>> editContactOnFirestore(String userId, ContactEntity newContact){
    return contactRepository.editContactOnFirestore(userId, newContact);
  }
}
