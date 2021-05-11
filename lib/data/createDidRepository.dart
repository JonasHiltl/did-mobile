import 'dart:convert';
import 'package:http/http.dart' as http;

import "../models/did/did.dart";

class CreateDidRepository {
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
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
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
      }),
    );
    if (res.statusCode == 200) {
      final didJson = jsonDecode(res.body) as Map<String, dynamic>;

      return Did.fromJson(didJson);
    } else {
      throw "Error calling creation backend";
    }
  }
}
