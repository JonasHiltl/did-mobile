import 'dart:convert';
import 'package:did/models/received_patient_questionnaire/received_patient_questionnaire.dart';
import 'package:http/http.dart' as http;

class RetrieveDocumentRepo {
  Future<dynamic> retrieve(String annLinkString) async {
    final _uri = Uri.https(
      "did-backend.herokuapp.com",
      "/streams/retrieve",
    );
    final res = await http.post(
      _uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "annLinkString": annLinkString,
      }),
    );
    if (res.statusCode == 200) {
      final parsedRes = jsonDecode(res.body) as Map<String, dynamic>;
      if (parsedRes["presentation"]["verifiableCredential"]["type"][1] ==
          "patientQuestionnaireCredential") {
        final sharedPatientQuestionnair =
            ReceivedPatientQuestionnaire.fromJson(parsedRes);
        return sharedPatientQuestionnair;
      }
    } else {
      return null;
    }
  }
}
