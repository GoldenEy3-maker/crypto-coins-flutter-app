// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinDetailModel _$CryptoCoinDetailModelFromJson(
  Map<String, dynamic> json,
) => CryptoCoinDetailModel(
  name: json['name'] as String,
  usdPrice: (json['PRICE'] as num).toDouble(),
  imageUrl: json['IMAGEURL'] as String,
  high24h: (json['HIGH24HOUR'] as num).toDouble(),
  low24h: (json['LOW24HOUR'] as num).toDouble(),
  lastUpdate: CryptoCoinDetailModel._lastUpdateFromJson(
    (json['LASTUPDATE'] as num).toInt(),
  ),
);

Map<String, dynamic> _$CryptoCoinDetailModelToJson(
  CryptoCoinDetailModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'PRICE': instance.usdPrice,
  'IMAGEURL': instance.imageUrl,
  'HIGH24HOUR': instance.high24h,
  'LOW24HOUR': instance.low24h,
  'LASTUPDATE': CryptoCoinDetailModel._lastUpdateToJson(instance.lastUpdate),
};
