import 'dart:convert';

import 'package:did/models/allergy/allergy.dart';
import 'package:did/models/medication/medication.dart';
import 'package:did/models/patient_questionnaire/patient_questionnaire.dart';
import 'package:http/http.dart' as http;

class CreatePQRepository {
  Future<PatientQuestionnaireVc> createPQ(
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
    String documentName,
    List<Allergy> allergies,
    List<Medication> medication,
  ) async {
    final _uri =
        Uri.https("did-backend.herokuapp.com", "/patient-questionnaire/create");
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
        "country": country.trim(),
        "documentName": documentName.trim(),
        "allergies": allergies,
        "medication": medication
      }),
    );
    if (res.statusCode == 200) {
      final resJson = jsonDecode(res.body) as Map<String, dynamic>;
      final patientQuestionnaire = PatientQuestionnaireVc.fromJson(resJson);

      print(res.body);
      return patientQuestionnaire;
    } else {
      print(res.body);
      throw "Error calling creation backend";
    }
  }
}
