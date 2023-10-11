class Contacts {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;
  late bool isFav;

  Contacts(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatar,
      this.isFav = false});

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    isFav = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    return data;
  }

  @override
  String toString() {
    return 'ID:$id\nfirst name: $firstName\nlast name: $lastName\nemail: $email\navatar: $avatar\n\n';
  }
}
