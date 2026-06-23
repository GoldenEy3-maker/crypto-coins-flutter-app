// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CryptoListStore on AbstractCryptoListStore, Store {
  late final _$coinsAtom = Atom(
    name: 'AbstractCryptoListStore.coins',
    context: context,
  );

  @override
  List<CryptoCoin> get coins {
    _$coinsAtom.reportRead();
    return super.coins;
  }

  @override
  set coins(List<CryptoCoin> value) {
    _$coinsAtom.reportWrite(value, super.coins, () {
      super.coins = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'AbstractCryptoListStore.isLoading',
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
    name: 'AbstractCryptoListStore.error',
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

  late final _$loadCoinsAsyncAction = AsyncAction(
    'AbstractCryptoListStore.loadCoins',
    context: context,
  );

  @override
  Future<void> loadCoins() {
    return _$loadCoinsAsyncAction.run(() => super.loadCoins());
  }

  @override
  String toString() {
    return '''
coins: ${coins},
isLoading: ${isLoading},
error: ${error}
    ''';
  }
}
