import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactmanager/domain/enitites/contact_entity.dart';
import 'package:contactmanager/domain/enitites/contacts_list.dart';
import 'package:contactmanager/domain/failure/failures.dart';
import 'package:contactmanager/infrastructure/models/contact_model.dart';
import 'package:dartz/dartz.dart';

abstract class ContactFirestoreDatasource {
  Stream<Either<Failure, ContactsList>> observeContacts(
      String userId, QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument);

  Future<Either<Failure, ContactEntity>> addNewContactToFirestore(
      String userId, ContactEntity newContact);

  Future<Either<Failure, ContactEntity>> editContact(
      String userId, ContactEntity contact);
}

class ContactFirestoreDatasourceImpl extends ContactFirestoreDatasource {
  final FirebaseFirestore firestore;

  ContactFirestoreDatasourceImpl({required this.firestore});

  @override
  Stream<Either<Failure, ContactsList>> observeContacts(String userId,
      QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument) async* {
    const pageLimit = 10;
    final documentReference = firestore.collection("users").doc(userId);
    // right side
    final query = documentReference.collection("contacts");
    yield* (lastDocument != null
            ? query.startAfterDocument(lastDocument)
            : query)
        .limit(pageLimit)
        .snapshots()
        .map((snapshot) => right<Failure, ContactsList>(ContactsList(
            list: snapshot.docs
                .map((doc) => ContactModel.fromJson(doc.data())
                    .toDomain()
                    .copyWith(id: doc.id))
                .toList(),
            lastDocument: snapshot.docs.last,
            hasMore: pageLimit == snapshot.docs.length &&
                snapshot.docs.last.id != lastDocument?.id)))
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

  @override
  Future<Either<Failure, ContactEntity>> editContact(
      String userId, ContactEntity contact) async {
    final documentReference = firestore.collection("users").doc(userId);
    final result = await documentReference
        .collection("contacts")
        .doc(contact.id)
        .update(contact.toJson())
        .catchError((e) {
      if (e is FirebaseException) {
        return Left(ServerFailure(details: e.message));
      }
      return Left(CommonFailure());
    });
    return Right(contact);
  }
}
