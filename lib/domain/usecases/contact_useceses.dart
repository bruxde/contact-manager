import 'package:contactmanager/domain/enitites/contact_entity.dart';
import 'package:dartz/dartz.dart';

import '../failure/failures.dart';

class ContactUsecases {
  Future<Either<Failure, List<ContactEntity>>> getContactList() async {
    return Future.value(Right([
      ContactEntity(
          id: 123,
          firstname: "Test",
          lastname: "Lastname",
          birthday: DateTime.now(),
          number: "+123456789"),
      ContactEntity(
          id: 123,
          firstname: "Test2",
          lastname: "Lastname2",
          birthday: DateTime.now(),
          number: "+123456789"),
      ContactEntity(
          id: 123,
          firstname: "Test3",
          lastname: "Lastname3",
          birthday: DateTime.now(),
          number: "+123456789")
    ]));
  }
}
