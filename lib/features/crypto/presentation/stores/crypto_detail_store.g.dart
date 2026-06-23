// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CryptoDetailStore on AbstractCryptoDetailStore, Store {
  late final _$coinAtom = Atom(
    name: 'AbstractCryptoDetailStore.coin',
    context: context,
  );

  @override
  CryptoCoinDetail? get coin {
    _$coinAtom.reportRead();
    return super.coin;
  }

  @override
  set coin(CryptoCoinDetail? value) {
    _$coinAtom.reportWrite(value, super.coin, () {
      super.coin = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'AbstractCryptoDetailStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAtom = Atom(
    name: 'AbstractCryptoDetailStore.error',
    context: context,
  );

  @override
  Object? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Object? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$loadCoinDetailByNameAsyncAction = AsyncAction(
    'AbstractCryptoDetailStore.loadCoinDetailByName',
    context: context,
  );

  @override
  Future<void> loadCoinDetailByName(String coinName) {
    return _$loadCoinDetailByNameAsyncAction.run(
      () => super.loadCoinDetailByName(coinName),
    );
  }

  late final _$refreshCoinDetailByNameAsyncAction = AsyncAction(
    'AbstractCryptoDetailStore.refreshCoinDetailByName',
    context: context,
  );

  @override
  Future<void> refreshCoinDetailByName(String coinName) {
    return _$refreshCoinDetailByNameAsyncAction.run(
      () => super.refreshCoinDetailByName(coinName),
    );
  }

  @override
  String toString() {
    return '''
coin: ${coin},
isLoading: ${isLoading},
error: ${error}
    ''';
  }
}
