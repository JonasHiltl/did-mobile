import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  factory Address.fromJson(Map<String, dynamic> data) =>
      _$AddressFromJson(data);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
