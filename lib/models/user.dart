// ignore_for_file: avoid_dynamic_calls

class User {
  final int id;
  final String fullName;
  final String email;
  final String? password;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, fullname: $fullName, email: $email, password: $password}';
  }

  factory User.fromSqliteDatabase(Map<String, dynamic> map) => User(
        id: int.parse(map['id'].toString()),
        fullName: map['fullName'].toString(),
        email: map['email'].toString(),
      );
}
