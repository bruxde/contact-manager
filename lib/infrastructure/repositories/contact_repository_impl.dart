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
      print("Im here");
      return Left(CommonFailure());
    }
  }
}
