import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactmanager/domain/enitites/contact_entity.dart';
import 'package:contactmanager/domain/enitites/contacts_list.dart';
import 'package:contactmanager/domain/failure/failures.dart';
import 'package:contactmanager/domain/repositories/contact_repository.dart';
import 'package:contactmanager/infrastructure/datasources/contact_remote_datasource.dart';
import 'package:contactmanager/infrastructure/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../datasources/contact_firestore_datasource.dart';

class ContactRepositoryImpl extends ContactRepository {
  final ContactRemoteDatasource contactRemoteDatasource;
  final ContactFirestoreDatasource contactFirestoreDatasource;

  ContactRepositoryImpl(
      {required this.contactRemoteDatasource,
      required this.contactFirestoreDatasource});

  @override
  Future<Either<Failure, List<ContactEntity>>> getContactList() async {
    try {
      return Right(await contactRemoteDatasource.getAllContacts());
    } on LogicException {
      return Left(LogicFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(CommonFailure());
    }
  }

  @override
  Future<Either<Failure, ContactEntity>> addNewContact(
      ContactEntity newContact) async {
    try {
      return Right(await contactRemoteDatasource.addNewContact(newContact));
    } on LogicException {
      return Left(LogicFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(CommonFailure());
    }
  }

  @override
  Future<Either<Failure, ContactEntity>> editContact(
      ContactEntity contact) async {
    try {
      return Right(await contactRemoteDatasource.editContact(contact));
    } on LogicException {
      return Left(LogicFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(CommonFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteContact(ContactEntity contact) async {
    try {
      return Right(await contactRemoteDatasource.deleteContact(contact));
    } on LogicException {
      return Left(LogicFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(CommonFailure());
    }
  }

  @override
  Stream<Either<Failure, ContactsList>> observeContacts(String userId, QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument) {
    return contactFirestoreDatasource.observeContacts(userId, lastDocument);
  }

  @override
  Future<Either<Failure, ContactEntity>> addNewContactToFirestore(
      String userId, ContactEntity newContact) {
    return contactFirestoreDatasource.addNewContactToFirestore(
        userId, newContact);
  }

  @override
  Future<Either<Failure, ContactEntity>> editContactOnFirestore(
      String userId, ContactEntity newContact) {
    return contactFirestoreDatasource.editContact(userId, newContact);
  }
}
