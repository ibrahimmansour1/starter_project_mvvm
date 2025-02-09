import 'package:starter_project/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String email, String password, String name);
  Future<UserEntity?> getCurrentUser();
  Future<void> logout();
  Future<void> updateProfile(Map<String, dynamic> data);
}
