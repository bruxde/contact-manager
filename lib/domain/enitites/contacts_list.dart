import 'package:cloud_firestore/cloud_firestore.dart';

import 'contact_entity.dart';

class ContactsList {
  List<ContactEntity> list;
  QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument;
  bool hasMore;

  ContactsList(
      {required this.list, required this.hasMore, required this.lastDocument});
}
