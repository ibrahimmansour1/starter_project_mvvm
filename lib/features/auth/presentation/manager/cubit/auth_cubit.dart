import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../data/repos/auth_repo.dart';
import '../../../domain/entities/sign_in_response_entity/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthInitial());

  Future<void> checkAuthStatus() async {
    try {
      final loginResponse = await _authRepository.getCurrentUser();
      emit(AuthAuthenticated(loginResponse!.user));
    } on CacheException catch (e) {
      emit(AuthError(e.message));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final loginResponse = await _authRepository.login(email, password);
      emit(AuthAuthenticated(loginResponse.user));
    } on ServerException catch (e) {
      emit(AuthError(e.message));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _authRepository.logout();
      emit(AuthInitial());
    } on CacheException catch (e) {
      emit(AuthError(e.message));
    }
  }
}
