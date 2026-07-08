import 'package:get_it/get_it.dart';
import '../network/api_client.dart';
import '../bloc/user_session/user_session_bloc.dart';
import '../bloc/notification/notification_bloc.dart';
import '../bloc/app_loading/app_loading_bloc.dart';
import '../../features/api_test/data/datasources/post_remote_datasource.dart';
import '../../features/api_test/data/datasources/user_remote_datasource.dart';
import '../../features/api_test/data/repositories/post_repository_impl.dart';
import '../../features/api_test/data/repositories/user_repository_impl.dart';
import '../../features/api_test/domain/repositories/post_repository.dart';
import '../../features/api_test/domain/repositories/user_repository.dart';
import '../../features/api_test/presentation/bloc/post_detail/post_detail_bloc.dart';
import '../../features/api_test/presentation/bloc/post_list/post_list_bloc.dart';
import '../../features/api_test/presentation/bloc/user_list/user_list_bloc.dart';
import '../../features/informasi_layanan/data/datasources/informasi_layanan_remote_datasource.dart';
import '../../features/informasi_layanan/data/repositories/informasi_layanan_repository_impl.dart';
import '../../features/informasi_layanan/domain/repositories/informasi_layanan_repository.dart';
import '../../features/informasi_layanan/presentation/bloc/informasi_layanan_bloc.dart';
import '../../features/kategori_layanan/data/datasources/kategori_layanan_remote_datasource.dart';
import '../../features/kategori_layanan/data/repositories/kategori_layanan_repository_impl.dart';
import '../../features/kategori_layanan/domain/repositories/kategori_layanan_repository.dart';
import '../../features/kategori_layanan/presentation/bloc/kategori_layanan_bloc.dart';
import '../../features/layanan/data/datasources/layanan_remote_datasource.dart';
import '../../features/layanan/data/repositories/layanan_repository_impl.dart';
import '../../features/layanan/domain/repositories/layanan_repository.dart';
import '../../features/layanan/presentation/bloc/layanan_bloc.dart';
import '../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';

final getIt = GetIt.instance;

/// Initialize all dependencies.
///
/// Call this once in `main()` before `runApp()`.
///
/// Registration order:
/// 1. Core services (API clients)
/// 2. Data sources
/// 3. Repositories
/// 4. Blocs
Future<void> setupDependencies() async {
  // ── Core ──
  getIt.registerLazySingleton<ApiClient>(() {
    final client = ApiClient();
    // Point to JSONPlaceholder for testing
    client.setBaseUrl('https://jsonplaceholder.typicode.com');
    return client;
  });

  // Portal Layanan Publik API client (separate instance)
  getIt.registerLazySingleton<ApiClient>(() {
    final client = ApiClient();
    client.setBaseUrl('http://217.217.254.139:4002');
    return client;
  }, instanceName: 'PortalApiClient');

  // ── Data Sources ──
  getIt.registerLazySingleton<PostRemoteDatasource>(
    () => PostRemoteDatasource(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasource(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<InformasiLayananRemoteDatasource>(
    () => InformasiLayananRemoteDatasource(
        getIt<ApiClient>(instanceName: 'PortalApiClient')),
  );
  getIt.registerLazySingleton<KategoriLayananRemoteDatasource>(
    () => KategoriLayananRemoteDatasource(
        getIt<ApiClient>(instanceName: 'PortalApiClient')),
  );
  getIt.registerLazySingleton<LayananRemoteDatasource>(
    () => LayananRemoteDatasource(
        getIt<ApiClient>(instanceName: 'PortalApiClient')),
  );
  getIt.registerLazySingleton<ProfileRemoteDatasource>(
        () => ProfileRemoteDatasource(
      getIt<ApiClient>(instanceName: 'PortalApiClient'),
    ),
  );

  // ── Repositories ──
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(getIt<PostRemoteDatasource>()),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt<UserRemoteDatasource>()),
  );
  getIt.registerLazySingleton<InformasiLayananRepository>(
    () => InformasiLayananRepositoryImpl(
        getIt<InformasiLayananRemoteDatasource>()),
  );
  getIt.registerLazySingleton<KategoriLayananRepository>(
    () => KategoriLayananRepositoryImpl(
        getIt<KategoriLayananRemoteDatasource>()),
  );
  getIt.registerLazySingleton<LayananRepository>(
    () => LayananRepositoryImpl(
        getIt<LayananRemoteDatasource>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(
      getIt<ProfileRemoteDatasource>(),
    ),
  );

  // ── Global Blocs (singleton = one instance for entire app) ──
  getIt.registerLazySingleton<UserSessionBloc>(() => UserSessionBloc());
  getIt.registerLazySingleton<NotificationBloc>(() => NotificationBloc());
  getIt.registerLazySingleton<AppLoadingBloc>(() => AppLoadingBloc());

  // ── Feature Blocs (factory = new instance each time) ──
  getIt.registerFactory<PostListBloc>(
    () => PostListBloc(getIt<PostRepository>()),
  );
  getIt.registerFactory<PostDetailBloc>(
    () => PostDetailBloc(getIt<PostRepository>()),
  );
  getIt.registerFactory<UserListBloc>(
    () => UserListBloc(getIt<UserRepository>()),
  );
  getIt.registerFactory<InformasiLayananBloc>(
    () => InformasiLayananBloc(getIt<InformasiLayananRepository>()),
  );
  getIt.registerFactory<KategoriLayananBloc>(
    () => KategoriLayananBloc(getIt<KategoriLayananRepository>()),
  );
  getIt.registerFactory<LayananBloc>(
    () => LayananBloc(getIt<LayananRepository>()),
  );
  getIt.registerFactory<ProfileBloc>(
        () => ProfileBloc(
      repository: getIt<ProfileRepository>(),
      userSessionBloc: getIt<UserSessionBloc>(),
    ),
  );

}
