import 'package:json_annotation/json_annotation.dart';

import 'credential.dart';
import 'identity.dart';

part 'did.g.dart';

@JsonSerializable(explicitToJson: true)
class Did {
  Did({
    required this.identity,
    required this.credential,
  });

  final Identity identity;
  final Credential credential;

  factory Did.fromJson(Map<String, dynamic> data) => _$DidFromJson(data);

  Map<String, dynamic> toJson() => _$DidToJson(this);
}
