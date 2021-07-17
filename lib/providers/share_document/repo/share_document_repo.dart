import 'dart:convert';
import 'package:did/models/dynamic_credential/dynamic_credential.dart';
import 'package:http/http.dart' as http;

class ShareDocumentRepo {
  Future<String?> createChannel(
    String id,
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
        "id": id,
        "credential": credential,
      }),
    );
    if (res.statusCode == 200) {
      final parsedRes = jsonDecode(res.body);
      return parsedRes["annLink"].toString();
    } else {
      final parsedRes = jsonDecode(res.body);
      if (parsedRes["message"].toString().isNotEmpty) {
        return null;
      }

      return null;
    }
  }
}
