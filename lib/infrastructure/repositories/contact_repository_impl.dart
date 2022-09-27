import 'package:contactmanager/domain/enitites/contact_entity.dart';
import 'package:contactmanager/domain/failure/failures.dart';
import 'package:contactmanager/domain/repositories/contact_repository.dart';
import 'package:contactmanager/infrastructure/datasources/contact_remote_datasource.dart';
import 'package:contactmanager/infrastructure/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

class ContactRepositoryImpl extends ContactRepository {
  final ContactRemoteDatasource contactRemoteDatasource;

  ContactRepositoryImpl({required this.contactRemoteDatasource});

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
  Future<Either<Failure, ContactEntity>> deleteContact(
      ContactEntity oldcontact) async {
    try {
      return Right(await contactRemoteDatasource.deleteContact(oldcontact));
    } on LogicException {
      return Left(LogicFailure());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(CommonFailure());
    }
  }
}
