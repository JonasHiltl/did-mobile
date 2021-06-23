import 'dart:convert';
import 'package:did/models/did/doc.dart';
import 'package:did/models/dynamic_credential/dynamic_credential.dart';
import 'package:http/http.dart' as http;

class ShareDocumentRepo {
  Future<String> createChannel(
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
      final annLink = jsonDecode(res.body) as String;
      print(annLink);
      return annLink;
    } else {
      print(res.body);
      throw "Error calling creation backend";
    }
  }
}
