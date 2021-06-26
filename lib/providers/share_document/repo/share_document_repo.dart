import 'dart:convert';
import 'package:did/models/did/doc.dart';
import 'package:did/models/dynamic_credential/dynamic_credential.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

class ShareDocumentRepo {
  Future<Tuple2<String, int>> createChannel(
    Doc doc,
    DynamicCredential credential,
  ) async {
    final _uri =
        Uri.https("did-backend.herokuapp.com", "/streams/create-channel");
    final res = await http.post(
      _uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "didDoc": doc,
        "credential": credential,
      }),
    );
    if (res.statusCode == 200) {
      final parsedRes = jsonDecode(res.body);
      return Tuple2(parsedRes["annLink"].toString(), res.statusCode);
    } else {
      final parsedRes = jsonDecode(res.body);
      if (parsedRes["message"].toString().isNotEmpty) {
        return Tuple2(parsedRes["message"].toString(), 500);
      }

      return const Tuple2("Server error", 500);
    }
  }
}