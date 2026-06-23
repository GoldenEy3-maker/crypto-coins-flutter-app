// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinModel _$CryptoCoinModelFromJson(Map<String, dynamic> json) =>
    CryptoCoinModel(
      name: json['name'] as String,
      usdPrice: (json['PRICE'] as num).toDouble(),
      imageUrl: json['IMAGEURL'] as String,
    );

Map<String, dynamic> _$CryptoCoinModelToJson(CryptoCoinModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'PRICE': instance.usdPrice,
      'IMAGEURL': instance.imageUrl,
    };
