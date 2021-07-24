import 'dart:convert';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';
import 'package:http/http.dart' as http;

class UpdatePersonalDataRepo {
  Future<PersonalDataVc?> updatePersonalVc(
    String id,
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
    final _uri = Uri.https("did-backend.herokuapp.com", "/update-personal-vc");
    final res = await http.post(
      _uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "id": id,
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
      final personalDataVcJson = resJson["credential"] as Map<String, dynamic>;

      return PersonalDataVc.fromJson(personalDataVcJson);
    } else {
      return null;
    }
  }
}
