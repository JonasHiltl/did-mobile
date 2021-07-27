import 'package:did/global_components/access_right.dart';
import 'package:did/global_components/credential.dart';
import 'package:did/global_components/credential_row.dart';
import 'package:did/global_components/empty.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/screens/session/documents/detailed_bottom_sheets/bottom_sheet_structure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../generated/l10n.dart';
import '../../../../theme.dart';
// TODO: create the detailed content of the bottom sheet for a shared patient questionnaire

class ReceivedPQDetailedBottomSheet extends StatelessWidget {
  const ReceivedPQDetailedBottomSheet({Key? key, required this.i})
      : super(key: key);
  final int i;

  @override
  Widget build(BuildContext context) {
    final receivedPatientQuestionnaire =
        context.watch<SessionState>().receivedPatientQuestionnaires[i];
    return BottomSheetStructure(
      children: [
        Credential(
          highlightColor: Colors.teal.shade400,
          title: receivedPatientQuestionnaire
              .presentation.verifiableCredential.credentialSubject.documentName,
          children: <Widget>[
            BuildRow(
              label1: L.of(context).firstName,
              text1: receivedPatientQuestionnaire.presentation
                  .verifiableCredential.credentialSubject.firstName,
              label2: L.of(context).lastName,
              text2: receivedPatientQuestionnaire
                  .presentation.verifiableCredential.credentialSubject.lastName,
            ),
            BuildRow(
              label1: L.of(context).email,
              text1: receivedPatientQuestionnaire
                  .presentation.verifiableCredential.credentialSubject.email,
              label2: L.of(context).phoneNumber,
              text2: receivedPatientQuestionnaire.presentation
                  .verifiableCredential.credentialSubject.phoneNumber,
            ),
            BuildRow(
              label1: L.of(context).dateOfBirth,
              text1: DateFormat.yMMMd().format(
                receivedPatientQuestionnaire.presentation.verifiableCredential
                    .credentialSubject.dateOfBirth
                    .toLocal(),
              ),
              label2: L.of(context).sex,
              text2: receivedPatientQuestionnaire
                  .presentation.verifiableCredential.credentialSubject.sex,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(kSmallPadding),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Text(
                          L.of(context).address,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                        Text(
                          "${receivedPatientQuestionnaire.presentation.verifiableCredential.credentialSubject.address.street}, ${receivedPatientQuestionnaire.presentation.verifiableCredential.credentialSubject.address.postalCode} ${receivedPatientQuestionnaire.presentation.verifiableCredential.credentialSubject.address.city}, ${receivedPatientQuestionnaire.presentation.verifiableCredential.credentialSubject.address.state} ${receivedPatientQuestionnaire.presentation.verifiableCredential.credentialSubject.address.country}",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.6),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (receivedPatientQuestionnaire.presentation.verifiableCredential
                .credentialSubject.allergies.isEmpty) ...[
              const Padding(
                padding: EdgeInsets.all(kSmallPadding),
                child: Divider(
                  height: 1,
                  thickness: 0.6,
                ),
              ),
              Center(
                child: Empty(text: L.of(context).noAllergiesAdded),
              ),
            ] else
              Padding(
                padding: const EdgeInsets.all(kSmallPadding),
                child: Table(
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        border: Border.all(
                          color: const Color(0xFFACB6C5).withOpacity(0.6),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 8, bottom: 8),
                          child: Text(
                            L.of(context).allergy,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0, top: 8, bottom: 8),
                          child: Text(
                            L.of(context).symptom,
                          ),
                        ),
                      ],
                    ),
                    ...receivedPatientQuestionnaire.presentation
                        .verifiableCredential.credentialSubject.allergies
                        .map(
                          (allergy) => TableRow(
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                color: const Color(0xFFACB6C5).withOpacity(0.6),
                              ),
                              left: BorderSide(
                                color: const Color(0xFFACB6C5).withOpacity(0.6),
                              ),
                              right: BorderSide(
                                color: const Color(0xFFACB6C5).withOpacity(0.6),
                              ),
                            )),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  top: 6,
                                  bottom: 6,
                                  right: 2.0,
                                ),
                                child: Text(
                                  allergy.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.6),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 16,
                                  top: 6,
                                  bottom: 6,
                                  left: 2.0,
                                ),
                                child: Text(
                                  allergy.symptom,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.6),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            if (receivedPatientQuestionnaire.presentation.verifiableCredential
                .credentialSubject.medication.isEmpty) ...[
              const Padding(
                padding: EdgeInsets.all(kSmallPadding),
                child: Divider(
                  height: 1,
                  thickness: 0.6,
                ),
              ),
              Center(
                child: Empty(text: L.of(context).noMedicationAdded),
              ),
            ] else
              Padding(
                padding: const EdgeInsets.all(kSmallPadding),
                child: Table(
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          border: Border.all(
                            color: const Color(0xFFACB6C5).withOpacity(0.6),
                          )),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            top: 8,
                            bottom: 8,
                            right: 2.0,
                          ),
                          child: Text(
                            L.of(context).medication,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 2.0),
                          child: Text(
                            L.of(context).condition,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 2.0),
                          child: Text(
                            L.of(context).frequency,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 16.0,
                            top: 8,
                            bottom: 8,
                            left: 2.0,
                          ),
                          child: Text(
                            L.of(context).dose,
                          ),
                        ),
                      ],
                    ),
                    ...receivedPatientQuestionnaire.presentation
                        .verifiableCredential.credentialSubject.medication
                        .map(
                          (medication) => TableRow(
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  color:
                                      const Color(0xFFACB6C5).withOpacity(0.6)),
                              left: BorderSide(
                                  color:
                                      const Color(0xFFACB6C5).withOpacity(0.6)),
                              right: BorderSide(
                                  color:
                                      const Color(0xFFACB6C5).withOpacity(0.6)),
                            )),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  top: 6,
                                  bottom: 6,
                                  right: 2.0,
                                ),
                                child: Text(
                                  medication.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.6),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 2.0),
                                child: Text(
                                  medication.condition,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.6),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 2.0),
                                child: Text(
                                  medication.frequency,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.6),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 16,
                                  top: 6,
                                  bottom: 6,
                                  left: 2.0,
                                ),
                                child: Text(
                                  medication.dose,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground
                                            .withOpacity(0.6),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            const Padding(
              padding: EdgeInsets.all(kSmallPadding),
              child: Divider(
                height: 1,
                thickness: 0.6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                kSmallPadding,
                0,
                kSmallPadding,
                kSmallPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    L.of(context).createdAt,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  Text(
                    DateFormat.yMMMd().add_jm().format(DateTime.parse(
                          receivedPatientQuestionnaire
                              .presentation.verifiableCredential.issuanceDate,
                        ).toLocal()),
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.6),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: kSmallPadding,
        ),
        AccessCredential(
          sharerID: receivedPatientQuestionnaire.presentation.holder,
          expiration: receivedPatientQuestionnaire.accessVc.expirationDate,
        ),
      ],
    );
  }
}
