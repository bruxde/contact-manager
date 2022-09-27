import 'package:contactmanager/domain/enitites/contact_entity.dart';

class ContactModel {
  String? id;
  String? firstname;
  String? lastname;
  String? number;
  int? birthday;

  ContactModel(
      {this.id, this.firstname, this.lastname, this.number, this.birthday});

  static ContactModel fromJson(Map<String, dynamic> json) {
    return ContactModel(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        number: json["number"],
        birthday: json["birthday"]);
  }

  ContactEntity toDomain() {
    return ContactEntity(
        id: id ?? "0",
        firstname: firstname ?? "Unknown",
        lastname: lastname ?? "Unknown",
        birthday: DateTime.fromMillisecondsSinceEpoch(birthday ?? 0),
        number: number ?? "Unkown");
  }
}
