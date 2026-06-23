import "package:flutter_application_1/features/crypto/domain/entities/crypto_coin_detail.dart";
import "package:json_annotation/json_annotation.dart";

part "crypto_coin_detail_model.g.dart";

@JsonSerializable()
class CryptoCoinDetailModel {
  final String name;

  @JsonKey(name: "PRICE")
  final double usdPrice;

  @JsonKey(name: "IMAGEURL")
  final String imageUrl;

  @JsonKey(name: "HIGH24HOUR")
  final double high24h;

  @JsonKey(name: "LOW24HOUR")
  final double low24h;

  @JsonKey(
    name: "LASTUPDATE",
    fromJson: _lastUpdateFromJson,
    toJson: _lastUpdateToJson,
  )
  final DateTime lastUpdate;

  const CryptoCoinDetailModel({
    required this.name,
    required this.usdPrice,
    required this.imageUrl,
    required this.high24h,
    required this.low24h,
    required this.lastUpdate,
  });

  factory CryptoCoinDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailModelToJson(this);

  factory CryptoCoinDetailModel.fromEntity(CryptoCoinDetail entity) =>
      CryptoCoinDetailModel(
        name: entity.name,
        usdPrice: entity.usdPrice,
        imageUrl: entity.imageUrl,
        high24h: entity.high24h,
        low24h: entity.low24h,
        lastUpdate: entity.lastUpdate,
      );

  CryptoCoinDetail toEntity() => CryptoCoinDetail(
    name: name,
    usdPrice: usdPrice,
    imageUrl: imageUrl,
    high24h: high24h,
    low24h: low24h,
    lastUpdate: lastUpdate,
  );

  static DateTime _lastUpdateFromJson(int seconds) =>
      DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

  static int _lastUpdateToJson(DateTime value) =>
      value.difference(DateTime.now()).inSeconds;
}
