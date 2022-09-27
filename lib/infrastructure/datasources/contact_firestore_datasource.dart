import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactmanager/domain/enitites/contact_entity.dart';
import 'package:contactmanager/domain/failure/failures.dart';
import 'package:contactmanager/infrastructure/models/contact_model.dart';
import 'package:dartz/dartz.dart';

abstract class ContactFirestoreDatasource {
  Stream<Either<Failure, List<ContactEntity>>> observeContacts(String userId);

  Future<Either<Failure, ContactEntity>> addNewContactToFirestore(
      String userId, ContactEntity newContact);
}

class ContactFirestoreDatasourceImpl extends ContactFirestoreDatasource {
  final FirebaseFirestore firestore;

  ContactFirestoreDatasourceImpl({required this.firestore});

  @override
  Stream<Either<Failure, List<ContactEntity>>> observeContacts(
      String userId) async* {
    final documentReference = firestore.collection("users").doc(userId);
    // right side
    yield* documentReference
        .collection("contacts")
        .snapshots()
        .map((snapshot) => right<Failure, List<ContactEntity>>(snapshot.docs
            .map((doc) => ContactModel.fromJson(doc.data())
                .toDomain()
                .copyWith(id: doc.id))
            .toList()))
        // left side
        .handleError((e) {
      if (e is FirebaseException) {
        return Left(ServerFailure(details: e.message));
      }
      return Left(CommonFailure());
    });
  }

  @override
  Future<Either<Failure, ContactEntity>> addNewContactToFirestore(
      String userId, ContactEntity newContact) async {
    final documentReference = firestore.collection("users").doc(userId);
    final result = await documentReference
        .collection("contacts")
        .add(newContact.toJson())
        .catchError((e) {
      if (e is FirebaseException) {
        return Left(ServerFailure(details: e.message));
      }
      return Left(CommonFailure());
    });
    return Right(newContact);
  }
}
