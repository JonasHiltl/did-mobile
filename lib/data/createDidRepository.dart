import 'dart:convert';
import 'package:http/http.dart' as http;

import "../models/did/did.dart";

class CreateDidRepository {
  Future<String> verifyDid(String id) async {
    final _uri = Uri.https("did-backend.herokuapp.com", "/verify");
    final res = await http.post(_uri, body: {"id": id});
    if (res.statusCode == 200) {
      print("Did is valid");
      return res.body.toString();
    }
    print("Did is not Valid");
    return "Did is not Valid";
  }

  Future<Did> createDid(
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      DateTime? dateOfBirth,
      String sex,
      String address,
      String city,
      String state,
      String postalCode,
      String country) async {
    final _uri = Uri.https("did-backend.herokuapp.com", "/create");
    final res = await http.post(
      _uri,
      body: {
        "firstName": firstName.trim(),
        "lastName": lastName.trim(),
        "email": email.trim(),
        "phoneNumber": phoneNumber.trim(),
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "sex": sex.trim(),
        "address": address.trim(),
        "city": city.trim(),
        "state": state.trim(),
        "postalCode": postalCode.trim(),
        "country": country.trim()
      },
    );
    if (res.statusCode == 200) {
      final didMap = jsonDecode(res.body) as Map<String, dynamic>;

      print(didMap["credential"]["credentialSubject"]["address"]);

      return Did.fromJson(didMap);
    } else {
      throw "Error calling creation backend";
    }
  }
}
