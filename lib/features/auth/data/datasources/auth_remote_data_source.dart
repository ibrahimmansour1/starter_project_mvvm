import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_provider.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> register(
      String email, String password, String name);
  Future<Map<String, dynamic>> getProfile();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiProvider apiProvider;

  AuthRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await apiProvider.post(
      ApiConstants.login,
      data: {
        'email': email,
        'password': password,
      },
    );
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> register(
      String email, String password, String name) async {
    final response = await apiProvider.post(
      ApiConstants.register,
      data: {
        'email': email,
        'password': password,
        'name': name,
      },
    );
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getProfile() async {
    final response = await apiProvider.get(ApiConstants.profile);
    return response.data;
  }
}
