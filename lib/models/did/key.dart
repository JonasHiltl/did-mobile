import 'package:json_annotation/json_annotation.dart';

part 'key.g.dart';

@JsonSerializable()
class Key {
  Key({
    required this.type,
    required this.public,
    required this.secret,
  });
  final String type;
  final String public;
  final String secret;

  factory Key.fromJson(Map<String, dynamic> data) => _$KeyFromJson(data);

  Map<String, dynamic> toJson() => _$KeyToJson(this);
}
