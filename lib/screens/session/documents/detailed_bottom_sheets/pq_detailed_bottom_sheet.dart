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

class PQDetailedBottomSheet extends StatelessWidget {
  final int i;
  const PQDetailedBottomSheet({required this.i});

  @override
  Widget build(BuildContext context) {
    final patientQuestionnaires =
        context.watch<SessionState>().patientQuestionnaires;
    return BottomSheetStructure(
      children: [
        Credential(
          title: patientQuestionnaires[i].credentialSubject.documentName,
          children: <Widget>[
            BuildRow(
              label1: L.of(context).firstName,
              text1: patientQuestionnaires[i].credentialSubject.firstName,
              label2: L.of(context).lastName,
              text2: patientQuestionnaires[i].credentialSubject.lastName,
            ),
            BuildRow(
              label1: L.of(context).email,
              text1: patientQuestionnaires[i].credentialSubject.email,
              label2: L.of(context).phoneNumber,
              text2: patientQuestionnaires[i].credentialSubject.phoneNumber,
            ),
            BuildRow(
              label1: L.of(context).dateOfBirth,
              text1: DateFormat.yMMMd().format(
                patientQuestionnaires[i]
                    .credentialSubject
                    .dateOfBirth
                    .toLocal(),
              ),
              label2: L.of(context).sex,
              text2: patientQuestionnaires[i].credentialSubject.sex,
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
                          "${patientQuestionnaires[i].credentialSubject.address.street}, ${patientQuestionnaires[i].credentialSubject.address.postalCode} ${patientQuestionnaires[i].credentialSubject.address.city}, ${patientQuestionnaires[i].credentialSubject.address.state} ${patientQuestionnaires[i].credentialSubject.address.country}",
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
            if (patientQuestionnaires[i]
                .credentialSubject
                .allergies
                .isEmpty) ...[
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
                            color: const Color(0xFFACB6C5).withOpacity(0.4),
                          )),
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
                    ...patientQuestionnaires[i]
                        .credentialSubject
                        .allergies
                        .map(
                          (allergy) => TableRow(
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                  color:
                                      const Color(0xFFACB6C5).withOpacity(0.4)),
                              left: BorderSide(
                                  color:
                                      const Color(0xFFACB6C5).withOpacity(0.4)),
                              right: BorderSide(
                                  color:
                                      const Color(0xFFACB6C5).withOpacity(0.4)),
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
            if (patientQuestionnaires[i]
                .credentialSubject
                .medication
                .isEmpty) ...[
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
                            color: const Color(0xFFACB6C5).withOpacity(0.4),
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
                    ...patientQuestionnaires[i]
                        .credentialSubject
                        .medication
                        .map(
                          (medication) => TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: const Color(0xFFACB6C5).withOpacity(
                                  0.4,
                                )),
                                left: BorderSide(
                                  color:
                                      const Color(0xFFACB6C5).withOpacity(0.4),
                                ),
                                right: BorderSide(
                                  color:
                                      const Color(0xFFACB6C5).withOpacity(0.4),
                                ),
                              ),
                            ),
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
                    DateFormat.yMMMd().add_jm().format(
                        DateTime.parse(patientQuestionnaires[i].issuanceDate)
                            .toLocal()),
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
      ],
    );
  }

  Widget makeDismissible(
          {required Widget child, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
}
