import 'dart:convert';

import 'package:contactmanager/domain/enitites/contact_entity.dart';
import 'package:contactmanager/infrastructure/exceptions/exceptions.dart';
import 'package:contactmanager/infrastructure/models/contact_model.dart';
import 'package:http/retry.dart';

abstract class ContactRemoteDatasource {
  Future<List<ContactEntity>> getAllContacts();
}

class ContactRemoteDatasourceImpl extends ContactRemoteDatasource {
  final API_SERVER = "https://api-project-309129321434.appspot.com/";
  late final RetryClient client;

  ContactRemoteDatasourceImpl({required this.client});

  @override
  Future<List<ContactEntity>> getAllContacts() async {
    final response = await client.get(Uri.parse("${API_SERVER}v1/contacts"));
    if (response.statusCode != 200) {
      throw ServerException();
    }
    final answer = jsonDecode(response.body);
    if (answer["status"] != "success") {
      throw LogicException();
    }

    final listContacts = answer["data"];
    List<ContactEntity> result = [];
    for (final contact in listContacts) {
      result.add(ContactModel.fromJson(contact).toDomain());
    }

    return result;
  }
}
