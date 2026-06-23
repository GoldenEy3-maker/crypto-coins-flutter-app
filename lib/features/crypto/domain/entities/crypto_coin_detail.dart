import "package:equatable/equatable.dart";

class CryptoCoinDetail extends Equatable {
  final String name;

  final double usdPrice;

  final String imageUrl;

  final double high24h;

  final double low24h;

  final DateTime lastUpdate;

  String get fullImageUrl => "https://www.cryptocompare.com$imageUrl";

  const CryptoCoinDetail({
    required this.name,
    required this.usdPrice,
    required this.imageUrl,
    required this.high24h,
    required this.low24h,
    required this.lastUpdate,
  });

  @override
  List<Object?> get props => [
    name,
    usdPrice,
    imageUrl,
    high24h,
    low24h,
    lastUpdate,
  ];
}
