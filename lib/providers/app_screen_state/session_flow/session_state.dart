// sessionStatus = similar to a form_status but reflects the states Verified, Unverified, UnkownSessionState
// identity
// personalDataVc
// patientQuestionnaires
// receivedPatientQuestionnaires

import 'package:did/models/did/identity.dart';
import 'package:did/models/file_type_data/file_type_data.dart';
import 'package:did/models/patient_questionnaire/patient_questionnaire.dart';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';
import 'package:did/models/received_patient_questionnaire/received_patient_questionnaire.dart';
import 'package:did/providers/app_screen_state/session_flow/session_status.dart';
import 'package:flutter/material.dart';

class SessionState {
  SessionState({
    this.identity,
    this.personalDataVc,
    this.patientQuestionnaires = const [],
    this.receivedPatientQuestionnaires = const [],
    this.sessionStatus = const UnkownSessionStatus(),
  });

  final Identity? identity;
  final PersonalDataVc? personalDataVc;
  List<PatientQuestionnaireVc> patientQuestionnaires;
  List<ReceivedPatientQuestionnaire> receivedPatientQuestionnaires;
  final SessionStatus sessionStatus;
  // TODO: implement getter for percentage between List of doc

  List<FileTypeData> get getFileTypeData => [
        FileTypeData(
          "Patient Questionnaire",
          patientQuestionnaires.length /
              (patientQuestionnaires.length +
                  receivedPatientQuestionnaires.length) *
              100,
          const Color(0xFF3861FB),
        ),
        FileTypeData(
          "Received Patient Questionnaire",
          receivedPatientQuestionnaires.length /
              (receivedPatientQuestionnaires.length +
                  patientQuestionnaires.length) *
              100,
          Colors.teal.shade400,
        ),
      ];
  // pQPercent
  // receivedPQPercent

  SessionState clear() => SessionState(
        patientQuestionnaires: [],
        receivedPatientQuestionnaires: [],
        sessionStatus: Unverified(),
      );

  SessionState copyWith({
    Identity? identity,
    PersonalDataVc? personalDataVc,
    List<PatientQuestionnaireVc>? patientQuestionnaires,
    List<ReceivedPatientQuestionnaire>? receivedPatientQuestionnaires,
    SessionStatus? sessionStatus,
  }) {
    return SessionState(
      identity: identity ?? this.identity,
      personalDataVc: personalDataVc ?? this.personalDataVc,
      patientQuestionnaires:
          patientQuestionnaires ?? this.patientQuestionnaires,
      receivedPatientQuestionnaires:
          receivedPatientQuestionnaires ?? this.receivedPatientQuestionnaires,
      sessionStatus: sessionStatus ?? this.sessionStatus,
    );
  }
}
