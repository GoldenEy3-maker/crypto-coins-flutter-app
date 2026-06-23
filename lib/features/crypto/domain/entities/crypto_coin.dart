import "package:equatable/equatable.dart";

class CryptoCoin extends Equatable {
  final String name;

  final double usdPrice;

  final String imageUrl;

  String get fullImageUrl => "https://www.cryptocompare.com$imageUrl";

  const CryptoCoin({
    required this.name,
    required this.usdPrice,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, usdPrice, imageUrl];
}
