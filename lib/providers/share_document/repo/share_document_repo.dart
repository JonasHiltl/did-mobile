import 'dart:convert';
import 'package:http/http.dart' as http;

class ShareDocumentRepo {
  Future<String?> createChannel(
    String id,
    dynamic credential,
    DateTime? expirationMoment,
  ) async {
    final _uri =
        Uri.https("did-backend.herokuapp.com", "/streams/create-channel");
    final res = await http.post(
      _uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // TODO: encrypt data with private key
      body: jsonEncode({
        "id": id,
        "credential": credential,
        "expirationDate": expirationMoment?.toUtc().toIso8601String(),
      }),
    );
    print(res.body);
    if (res.statusCode == 200) {
      final parsedRes = jsonDecode(res.body);
      return parsedRes["annLink"].toString();
    } else {
      return null;
    }
  }
}
