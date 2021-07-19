import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../models/did/did_vc_combination.dart';
import '../../../models/did/identity.dart';
import '../../../models/personal_data_vc/personal_data_vc.dart';

class CreateDidRepository {
  Future<DidVcCombination?> createDid(
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
    String country,
  ) async {
    final _uri = Uri.https("did-backend.herokuapp.com", "/did/create");
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
      final resJson = jsonDecode(res.body);
      final didJson = resJson["did"] as Map<String, dynamic>;
      final credentialJson = resJson["credential"] as Map<String, dynamic>;

      final personalDataVc = PersonalDataVc.fromJson(credentialJson);
      final identity = Identity.fromJson(didJson);
      print("DID Message Id: ${identity.messageId}");
      print("DID Message Id: ${identity.messageId}");

      return DidVcCombination(
        identity: identity,
        personalDataVc: personalDataVc,
      );
    } else {
      print(res.body);
      return null;
    }
  }
}
