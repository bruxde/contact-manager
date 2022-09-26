class ContactEntity {
  final int? id;
  final String firstname;
  final String lastname;
  final DateTime birthday;
  final String number;

  ContactEntity(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.birthday,
      required this.number});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstname": firstname,
      "lastname": lastname,
      "birthday": birthday.millisecondsSinceEpoch,
      "number": number
    };
  }
}
