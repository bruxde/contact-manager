class ContactEntity {
  final String? id;
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

  ContactEntity copyWith(
      {String? id,
      String? firstname,
      String? lastname,
      DateTime? birthday,
      String? number}) {

    return ContactEntity(
        id: id ?? this.id,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        birthday: birthday ?? this.birthday,
        number: number ?? this.number);
  }
}
