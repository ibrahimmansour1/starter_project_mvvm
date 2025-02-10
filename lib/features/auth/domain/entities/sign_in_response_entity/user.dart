import 'address.dart';

class User {
  String? username;
  String? email;
  String? name;
  String? role;
  Address? address;

  User({this.username, this.email, this.name, this.role, this.address});

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['username'] as String?,
        email: json['email'] as String?,
        name: json['name'] as String?,
        role: json['role'] as String?,
        address: json['address'] == null
            ? null
            : Address.fromJson(json['address'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'name': name,
        'role': role,
        'address': address?.toJson(),
      };
}
