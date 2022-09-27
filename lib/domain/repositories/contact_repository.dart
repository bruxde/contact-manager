import 'package:dartz/dartz.dart';
import '../enitites/contact_entity.dart';
import '../failure/failures.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<ContactEntity>>> getContactList();

  Future<Either<Failure, ContactEntity>> addNewContact(
      ContactEntity newContact);

  Future<Either<Failure, ContactEntity>> editContact(ContactEntity contact);

  Future<Either<Failure, ContactEntity>> deleteContact(ContactEntity contact);
}
