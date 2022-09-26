import 'package:dartz/dartz.dart';

import '../enitites/contact_entity.dart';
import '../failure/failures.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<ContactEntity>>> getContactList();
}
