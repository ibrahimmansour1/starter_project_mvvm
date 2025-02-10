import 'dart:developer';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_provider.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/secure_storage_helper.dart';
import '../../domain/entities/sign_in_response_entity/sign_in_response_entity.dart';
import 'auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiProvider _apiProvider;
  final SecureStorageHelper _secureStorage;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl({
    required ApiProvider apiProvider,
    required SecureStorageHelper secureStorage,
    required NetworkInfo networkInfo,
  })  : _apiProvider = apiProvider,
        _secureStorage = secureStorage,
        _networkInfo = networkInfo;

  @override
  Future<SignInResponseEntity> login(String email, String password) async {
    if (!await _networkInfo.isConnected) {
      throw ServerException('No internet connection');
    }

    try {
      final response = await _apiProvider.post(
        ApiConstants.login,
        data: {
          'username': email,
          'password': password,
        },
      );

      if (response.data['token'] != null) {
        await _secureStorage.saveString(
          ApiConstants.tokenKey,
          response.data['token'] ?? '',
        );
      }
      log('Login Response: ${response.data}');

      final user = SignInResponseEntity.fromJson(response.data['user']);
      await _secureStorage.saveMap(ApiConstants.userKey, user.toJson());

      return user;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<SignInResponseEntity> getCurrentUser() async {
    try {
      final userData = await _secureStorage.getMap(ApiConstants.userKey);
      if (userData != null) {
        return SignInResponseEntity.fromJson(userData);
      }
      throw CacheException('No user data found');
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<SignInResponseEntity> register(
      String email, String password, String name) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfile(Map<String, dynamic> data) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  // Additional repository methods...
}
