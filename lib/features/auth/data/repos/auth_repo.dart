import '../../domain/entities/sign_in_response_entity/sign_in_response_entity.dart';

abstract class AuthRepository {
  Future<SignInResponseEntity> login(String email, String password);
  Future<SignInResponseEntity> register(
      String email, String password, String name);
  Future<SignInResponseEntity?> getCurrentUser();
  Future<void> logout();
  Future<void> updateProfile(Map<String, dynamic> data);
}
