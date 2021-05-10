import 'package:json_annotation/json_annotation.dart';

part 'authentication.g.dart';

@JsonSerializable()
class Authentication {
  Authentication({
    required this.id,
    required this.controller,
    required this.type,
    required this.publicKeyBase58,
  });
  final String id;
  final String controller;
  final String type;
  final String publicKeyBase58;

  factory Authentication.fromJson(Map<String, dynamic> data) =>
      _$AuthenticationFromJson(data);

  Map<String, dynamic> toJson() => _$AuthenticationToJson(this);
}
