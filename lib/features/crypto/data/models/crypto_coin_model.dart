import "package:flutter_application_1/features/crypto/domain/entities/crypto_coin.dart";
import "package:json_annotation/json_annotation.dart";

part "crypto_coin_model.g.dart";

@JsonSerializable()
class CryptoCoinModel {
  final String name;

  @JsonKey(name: "PRICE")
  final double usdPrice;

  @JsonKey(name: "IMAGEURL")
  final String imageUrl;

  const CryptoCoinModel({
    required this.name,
    required this.usdPrice,
    required this.imageUrl,
  });

  factory CryptoCoinModel.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinModelFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinModelToJson(this);

  factory CryptoCoinModel.fromEntity(CryptoCoin entity) => CryptoCoinModel(
    name: entity.name,
    usdPrice: entity.usdPrice,
    imageUrl: entity.imageUrl,
  );

  CryptoCoin toEntity() =>
      CryptoCoin(name: name, usdPrice: usdPrice, imageUrl: imageUrl);
}
