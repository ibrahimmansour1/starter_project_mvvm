import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/auth/presentation/manager/cubit/auth_cubit.dart';
import '../network/api_provider.dart';
import '../network/network_info.dart';
import '../utils/secure_storage_helper.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Core
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => SecureStorageHelper(getIt()));
  getIt.registerLazySingleton(() => ApiProvider());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  getIt.registerLazySingleton(() => InternetConnectionChecker.createInstance());

  // Features
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      apiProvider: getIt(),
      secureStorage: getIt(),
      networkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt()),
  );
  getIt.registerFactory(() => AuthCubit(authRepository: getIt()));
}
