import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String username;
  final String email;
  final String name;
  final String? role;

  const UserEntity({
    required this.username,
    required this.email,
    required this.name,
    this.role,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      username: json['username'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'name': name,
      'role': role,
    };
  }

  @override
  List<Object?> get props => [username, email, name, role];
}
