import 'package:contactmanager/domain/enitites/contact_entity.dart';
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
      {required this.contactRemoteDatasource, required this.contactFirestoreDatasource});

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
  Stream<Either<Failure, List<ContactEntity>>> observeContacts(String userId) {
    return contactFirestoreDatasource.observeContacts(userId);
  }
}
