import 'dart:convert';
import 'package:http/http.dart' as http;

class CommonBackendRepo {
  Future<bool> verifyDid(String id) async {
    final _uri = Uri.https("did-backend.herokuapp.com", "/verify");
    final res = await http.post(_uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"id": id}));
    if (res.statusCode == 200) {
      print("Did is valid");
      return true;
    }
    print("Did is not Valid ${res.body}");
    return false;
  }
}
