import "package:flutter_application_1/core/di/get_it.dart";
import "package:flutter_application_1/core/network/api_client.dart";
import "package:flutter_application_1/features/crypto/data/datasources/crypto_local_data_source.dart";
import "package:flutter_application_1/features/crypto/data/datasources/crypto_remote_data_source.dart";
import "package:flutter_application_1/features/crypto/data/repositories/crypto_repository_impl.dart";
import "package:flutter_application_1/features/crypto/domain/repositories/crypto_repository.dart";
import "package:flutter_application_1/features/crypto/domain/usecases/get_coin_detail.dart";
import "package:flutter_application_1/features/crypto/domain/usecases/get_coins_list.dart";
import "package:flutter_application_1/features/crypto/presentation/stores/crypto_detail_store.dart";
import "package:flutter_application_1/features/crypto/presentation/stores/crypto_list_store.dart";
import "package:talker_flutter/talker_flutter.dart";

void registerCryptoModule() {
  final talker = getIt.get<Talker>();

  final cryptoRemoteDataSource = CryptoRemoteDataSourceImpl(
    apiClient: getIt.get<ApiClient>(),
  );
  final cryptoLocalDataSource = CryptoLocalDataSourceImpl();

  getIt.registerSingleton<CryptoRemoteDataSource>(cryptoRemoteDataSource);
  getIt.registerSingleton<CryptoLocalDataSource>(cryptoLocalDataSource);

  getIt.registerSingleton<CryptoRepository>(
    CryptoRepositoryImpl(
      remoteDataSource: cryptoRemoteDataSource,
      localDataSource: cryptoLocalDataSource,
    ),
  );

  getIt.registerLazySingleton<GetCoinsList>(
    () => GetCoinsList(getIt.get<CryptoRepository>()),
  );
  getIt.registerLazySingleton<GetCoinDetail>(
    () => GetCoinDetail(getIt.get<CryptoRepository>()),
  );

  getIt.registerFactory<CryptoListStore>(
    () => CryptoListStore(
      getCoinsList: getIt.get<GetCoinsList>(),
      talker: talker,
    ),
  );
  getIt.registerFactory<CryptoDetailStore>(
    () => CryptoDetailStore(
      getCoinDetail: getIt.get<GetCoinDetail>(),
      talker: talker,
    ),
  );
}
