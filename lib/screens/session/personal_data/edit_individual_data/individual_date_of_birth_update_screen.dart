import 'package:did/global_components/loading_indicator.dart';
import 'package:did/global_components/noti.dart';
import 'package:did/providers/app_screen_state/session_flow/session_bloc.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/providers/app_settings/app_settings_bloc.dart';
import 'package:did/generated/l10n.dart';
import 'package:did/providers/update_personal_data/form_submission_status.dart';
import 'package:did/providers/update_personal_data/repository/update_personal_data_repo.dart';
import 'package:did/providers/update_personal_data/update_personal_bloc.dart';
import 'package:did/providers/update_personal_data/update_personal_event.dart';
import 'package:did/providers/update_personal_data/update_personal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../../../theme.dart';

class IndividualDateOfBirthUpdateScreen extends StatefulWidget {
  final String initialValue;
  const IndividualDateOfBirthUpdateScreen({required this.initialValue});

  @override
  _IndividualDateOfBirthUpdateScreenState createState() =>
      _IndividualDateOfBirthUpdateScreenState();
}

class _IndividualDateOfBirthUpdateScreenState
    extends State<IndividualDateOfBirthUpdateScreen> {
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final sessionState = context.watch<SessionState>();
    return RepositoryProvider(
      create: (context) => UpdatePersonalDataRepo(),
      child: BlocProvider<UpdatePersonalBloc>(
        create: (context) => UpdatePersonalBloc(
          sessionBloc: context.read<SessionBloc>(),
          repo: context.read<UpdatePersonalDataRepo>(),
          id: sessionState.identity!.doc.id,
          firstName: sessionState.personalDataVc!.credentialSubject.firstName,
          lastName: sessionState.personalDataVc!.credentialSubject.lastName,
          email: sessionState.personalDataVc!.credentialSubject.email,
          phoneNumber:
              sessionState.personalDataVc!.credentialSubject.phoneNumber,
          dateOfBirth:
              sessionState.personalDataVc!.credentialSubject.dateOfBirth,
          sex: sessionState.personalDataVc!.credentialSubject.sex,
          address:
              sessionState.personalDataVc!.credentialSubject.address.street,
          city: sessionState.personalDataVc!.credentialSubject.address.city,
          locationState:
              sessionState.personalDataVc!.credentialSubject.address.state,
          postalCode:
              sessionState.personalDataVc!.credentialSubject.address.postalCode,
          country:
              sessionState.personalDataVc!.credentialSubject.address.country,
        ),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              // if floating is true the appbar becomes instantly visible if scrolled towards top
              // if it's false the appbar is only visible if completly scrolled back to top
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                L.of(context).updateDateOfBirth,
                style: Theme.of(context).textTheme.headline5,
              ),
              centerTitle: true,
            ),
            body: BlocConsumer<UpdatePersonalBloc, UpdatePersonalState>(
              listener: (context, state) {
                if (state.formStatus is SubmissionSuccess) {
                  showSuccessNoti(
                      message: L.of(context).updateDateOfBirth,
                      context: context);
                  Navigator.pop(context);
                } else if (state.formStatus is SubmissionFailed) {
                  showErrorNoti(
                      message: L.of(context).updateErrorMessage,
                      context: context);
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(kMediumPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormField(
                        onTap: () => DatePicker.showDatePicker(
                          context,
                          locale:
                              context.read<AppSettingsBloc>().state.language ==
                                      "en"
                                  ? LocaleType.en
                                  : LocaleType.de,
                          onConfirm: (date) {
                            context.read<UpdatePersonalBloc>().add(
                                  UpdatePersonalDateOfBirthChanged(
                                      dateOfBirth: date),
                                );
                            dateController.text =
                                DateFormat.yMMMd().format(date);
                          },
                          currentTime: context
                                  .read<UpdatePersonalBloc>()
                                  .state
                                  .dateOfBirth is DateTime
                              ? context
                                  .read<UpdatePersonalBloc>()
                                  .state
                                  .dateOfBirth
                              : DateTime.now(),
                          theme: DatePickerTheme(
                            itemStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 16,
                            ),
                            doneStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                            ),
                            cancelStyle: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 16,
                                height: 1.5),
                            backgroundColor: Theme.of(context).backgroundColor,
                          ),
                        ),
                        controller: dateController,
                        cursorWidth: 1,
                        readOnly: true,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Text(
                              L.of(context).dateOfBirth,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.6),
                              ),
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 100,
                          ),
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.6),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? kTextFieldLightBorder
                                  : kTextFieldDarkBorder,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? kTextFieldLightBorder
                                  : kTextFieldDarkBorder,
                            ),
                          ),
                          filled: true,
                          fillColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? kLightAccentBG
                                  : kDarkAccentBG,
                        ),
                      ),
                      SizedBox(
                        width: size.width - kMediumPadding,
                        child: ElevatedButton(
                          onPressed: !state.isValidDateOfBirth ||
                                  state.formStatus is FormSubmitting
                              ? null
                              : () {
                                  final FocusScopeNode currentFocus =
                                      FocusScope.of(context);

                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  context
                                      .read<UpdatePersonalBloc>()
                                      .add(UpdatePersonalSubmitted());
                                },
                          child: state.formStatus is FormSubmitting
                              ? Container(
                                  height: 19,
                                  width: 19,
                                  margin: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                  child: LoadingIndicator(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? const Color(0xFFD9D9D9)
                                        : kTextFieldDarkBorder,
                                  ),
                                )
                              : Text(L.of(context).updateDateOfBirth),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
