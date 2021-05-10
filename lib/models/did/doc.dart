import 'package:json_annotation/json_annotation.dart';

import 'authentication.dart';
import 'proof.dart';

part 'doc.g.dart';

@JsonSerializable(explicitToJson: true)
class Doc {
  Doc({
    required this.id,
    required this.authentication,
    required this.created,
    required this.updated,
    required this.proof,
  });
  final String id;
  final List<Authentication> authentication;
  final String created;
  final String updated;
  final Proof proof;

  factory Doc.fromJson(Map<String, dynamic> data) => _$DocFromJson(data);

  Map<String, dynamic> toJson() => _$DocToJson(this);
}
