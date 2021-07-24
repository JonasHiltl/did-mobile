import 'package:did/global_components/bottom_Sheet_drag_handle.dart';
import 'package:did/global_components/credential.dart';
import 'package:did/global_components/empty.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
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
    return makeDismissible(
      context: context,
      child: DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.8,
        minChildSize: 0.5,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: SingleChildScrollView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.fromLTRB(
                kMediumPadding,
                8,
                kMediumPadding,
                kMediumPadding,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: BottomSheetDraghandle(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Credential(
                    title:
                        patientQuestionnaires[i].credentialSubject.documentName,
                    children: <Widget>[
                      _BuildRow(
                        label1: L.of(context).firstName,
                        text1: patientQuestionnaires[i]
                            .credentialSubject
                            .firstName,
                        label2: L.of(context).lastName,
                        text2:
                            patientQuestionnaires[i].credentialSubject.lastName,
                      ),
                      _BuildRow(
                        label1: L.of(context).email,
                        text1: patientQuestionnaires[i].credentialSubject.email,
                        label2: L.of(context).phoneNumber,
                        text2: patientQuestionnaires[i]
                            .credentialSubject
                            .phoneNumber,
                      ),
                      _BuildRow(
                        label1: L.of(context).dateOfBirth,
                        text1: DateFormat.yMMMd().format(
                            patientQuestionnaires[i]
                                .credentialSubject
                                .dateOfBirth),
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
                            color: Colors.black38,
                            height: 1,
                            thickness: 0.6,
                          ),
                        ),
                        Center(
                          child: Empty(text: L.of(context).noAllergiesAdded),
                        ),
                      ],
                      if (patientQuestionnaires[i]
                          .credentialSubject
                          .allergies
                          .isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(kSmallPadding),
                          child: Table(
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                    border: Border.all(
                                      color: const Color(0xFFACB6C5)
                                          .withOpacity(0.6),
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
                                            color: const Color(0xFFACB6C5)
                                                .withOpacity(0.6)),
                                        left: BorderSide(
                                            color: const Color(0xFFACB6C5)
                                                .withOpacity(0.6)),
                                        right: BorderSide(
                                            color: const Color(0xFFACB6C5)
                                                .withOpacity(0.6)),
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
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 16,
                                            top: 6,
                                            bottom: 6,
                                            left: 2.0,
                                          ),
                                          child: Text(allergy.symptom),
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
                            color: Colors.black38,
                            height: 1,
                            thickness: 0.6,
                          ),
                        ),
                        Center(
                          child: Empty(text: L.of(context).noMedicationAdded),
                        ),
                      ],
                      if (patientQuestionnaires[i]
                          .credentialSubject
                          .medication
                          .isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(kSmallPadding),
                          child: Table(
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                    border: Border.all(
                                      color: const Color(0xFFACB6C5)
                                          .withOpacity(0.6),
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
                                            color: const Color(0xFFACB6C5)
                                                .withOpacity(0.6)),
                                        left: BorderSide(
                                            color: const Color(0xFFACB6C5)
                                                .withOpacity(0.6)),
                                        right: BorderSide(
                                            color: const Color(0xFFACB6C5)
                                                .withOpacity(0.6)),
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
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 2.0),
                                          child: Text(
                                            medication.condition,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 2.0),
                                          child: Text(
                                            medication.frequency,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 16,
                                            top: 6,
                                            bottom: 6,
                                            left: 2.0,
                                          ),
                                          child: Text(medication.dose),
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
                          color: Colors.black38,
                          height: 1,
                          thickness: 0.6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            kSmallPadding, 0, kSmallPadding, kSmallPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              L.of(context).createdAt,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                            Text(
                              DateFormat.yMMMd().add_jm().format(DateTime.parse(
                                      patientQuestionnaires[i].issuanceDate)
                                  .toLocal()),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.6)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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

class _BuildRow extends StatelessWidget {
  const _BuildRow({
    Key? key,
    required this.label1,
    required this.text1,
    required this.label2,
    required this.text2,
  }) : super(key: key);

  final String label1;
  final String text1;
  final String label2;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(kSmallPadding),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  label1,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                Text(
                  text1,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.6)),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(kSmallPadding),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  label2,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                Text(
                  text2,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.6)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
