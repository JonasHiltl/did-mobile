import 'package:json_annotation/json_annotation.dart';

import 'credential.dart';

part 'did.g.dart';

@JsonSerializable(explicitToJson: true)
class Did {
  Did({
    required this.id,
    required this.docHash,
    required this.pubKey,
    required this.privKey,
    required this.credential,
  });

  final String id;
  final String docHash;
  final String pubKey;
  final String privKey;
  final Credential credential;

  factory Did.fromJson(Map<String, dynamic> data) => _$DidFromJson(data);

  Map<String, dynamic> toJson() => _$DidToJson(this);
}
