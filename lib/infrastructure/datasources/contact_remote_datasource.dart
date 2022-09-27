import 'dart:convert';

import 'package:contactmanager/domain/enitites/contact_entity.dart';
import 'package:contactmanager/infrastructure/exceptions/exceptions.dart';
import 'package:contactmanager/infrastructure/models/contact_model.dart';
import 'package:http/retry.dart';

abstract class ContactRemoteDatasource {
  Future<List<ContactEntity>> getAllContacts();

  Future<ContactEntity> addNewContact(ContactEntity newContact);

  Future<ContactEntity> editContact(ContactEntity contact);

  Future<ContactEntity> deleteContact(ContactEntity oldcontact);
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

  @override
  Future<ContactEntity> addNewContact(ContactEntity newContact) async {
    const JsonEncoder encoder = JsonEncoder();
    final objectAsString = encoder.convert(newContact.toJson());
    final response = await client.post(Uri.parse("${API_SERVER}v1/contacts"),
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        body: objectAsString,
        encoding: const Utf8Codec());
    if (response.statusCode != 200) {
      throw ServerException();
    }
    final answer = jsonDecode(response.body);
    if (answer["status"] != "success") {
      throw LogicException();
    }

    final contact = answer["data"];
    return ContactModel.fromJson(contact).toDomain();
  }

  @override
  Future<ContactEntity> editContact(ContactEntity editContact) async {
    const JsonEncoder encoder = JsonEncoder();
    final objectAsString = encoder.convert(editContact.toJson());
    final response = await client.put(
        Uri.parse("${API_SERVER}v1/contacts/${editContact.id}"),
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        body: objectAsString,
        encoding: const Utf8Codec());
    if (response.statusCode != 200) {
      throw ServerException();
    }
    final answer = jsonDecode(response.body);
    if (answer["status"] != "success") {
      throw LogicException();
    }

    final contact = answer["data"];
    return ContactModel.fromJson(contact).toDomain();
  }

  @override
  Future<ContactEntity> deleteContact(ContactEntity deleteContact) async {
    const JsonEncoder encoder = JsonEncoder();
    final objectAsString = encoder.convert(deleteContact.toJson());
    final response = await client.delete(
        Uri.parse("${API_SERVER}v1/contacts/${deleteContact.id}"),
        headers: {'Content-Type': 'application/json;charset=UTF-8'},
        body: objectAsString,
        encoding: const Utf8Codec());
    if (response.statusCode != 200) {
      throw ServerException();
    }
    final answer = jsonDecode(response.body);
    if (answer["status"] != "success") {
      throw LogicException();
    }

    final contact = answer["data"];
    return ContactModel.fromJson(contact).toDomain();
  }
}
