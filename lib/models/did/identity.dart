import 'package:json_annotation/json_annotation.dart';

import 'doc.dart';
import 'key.dart';

part 'identity.g.dart';

@JsonSerializable(explicitToJson: true)
class Identity {
  Identity({
    required this.key,
    required this.doc,
    required this.messageId,
  });
  final Key key;
  final Doc doc;
  final String messageId;

  factory Identity.fromJson(Map<String, dynamic> data) =>
      _$IdentityFromJson(data);

  Map<String, dynamic> toJson() => _$IdentityToJson(this);
}
