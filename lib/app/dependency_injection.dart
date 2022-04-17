import 'package:get_it/get_it.dart';
import 'package:mvvm_demo/app/app_prefs.dart';
import 'package:mvvm_demo/data/data_source/remote_data_source.dart';
import 'package:mvvm_demo/data/network/dio_factory.dart';
import 'package:mvvm_demo/data/network/network_info.dart';
import 'package:mvvm_demo/data/repository/repository_impl.dart';
import 'package:mvvm_demo/domain/domain_reppository/repository.dart';
import 'package:mvvm_demo/domain/usecases/login_usecase.dart';
import 'package:mvvm_demo/presentation/screens/login/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/app_api.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(instance<SharedPreferences>()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // dio factory
  instance.registerLazySingleton<DioFactory>(
      () => DioFactory(instance()));

  // app service class
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementor(instance()));

  // repository
  instance.registerLazySingleton<Repository>(() =>
      RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
            () => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(
            () => LoginViewModel(instance()));
  }
}
