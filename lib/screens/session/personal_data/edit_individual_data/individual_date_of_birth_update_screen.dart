import 'package:did/global_components/noti.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionCubit.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
import 'package:did/providers/language/languageBloc.dart';
import 'package:did/generated/l10n.dart';
import 'package:did/providers/updatePersonalData/form_submission_status.dart';
import 'package:did/providers/updatePersonalData/repository/update_personal_data_repo.dart';
import 'package:did/providers/updatePersonalData/update_personal_bloc.dart';
import 'package:did/providers/updatePersonalData/update_personal_event.dart';
import 'package:did/providers/updatePersonalData/update_personal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

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
    final credential =
        context.watch<Verified>().personalDataVc.credentialSubject;
    final identity = context.watch<Verified>().identity;
    final sessionState = context.watch<Verified>();
    return RepositoryProvider(
      create: (context) => UpdatePersonalDataRepo(),
      child: BlocProvider<UpdatePersonalBloc>(
        create: (context) => UpdatePersonalBloc(
          repo: context.read<UpdatePersonalDataRepo>(),
          sessionCubit: context.read<SessionCubit>(),
          sessionState: sessionState,
          id: identity.doc.id,
          firstName: credential.firstName,
          lastName: credential.lastName,
          email: credential.email,
          phoneNumber: credential.phoneNumber,
          dateOfBirth: credential.dateOfBirth,
          sex: credential.sex,
          address: credential.address.street,
          city: credential.address.city,
          locationState: credential.address.state,
          postalCode: credential.address.postalCode,
          country: credential.address.country,
        ),
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  // if floating is true the appbar becomes instantly visible if scrolled towards top
                  // if it's false the appbar is only visible if completly scrolled back to top
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  iconTheme: const IconThemeData(
                    color: Colors.black,
                  ),
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
                }, builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          onTap: () => DatePicker.showDatePicker(
                            context,
                            locale:
                                context.read<LanguageBloc>().state.language ==
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
                                itemStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                                doneStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16),
                                cancelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.85),
                                    fontSize: 16,
                                    height: 1.5),
                                backgroundColor:
                                    Theme.of(context).backgroundColor),
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
                                        color: Colors.black.withOpacity(0.6)),
                                  )),
                              prefixIconConstraints: const BoxConstraints(
                                minWidth: 100,
                              ),
                              suffixIcon: Icon(
                                Icons.calendar_today,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: const Color(0xFFACB6C5)
                                        .withOpacity(0.6)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: const Color(0xFFACB6C5).withOpacity(0.6),
                              )),
                              filled: true,
                              fillColor: const Color(0xFFF1F3FD)),
                        ),
                        SizedBox(
                            width: size.width - 20,
                            child: ElevatedButton(
                              onPressed: !state.isValidDateOfBirth ||
                                      state.formStatus is FormSubmitting
                                  ? null
                                  : () => context
                                      .read<UpdatePersonalBloc>()
                                      .add(UpdatePersonalSubmitted()),
                              child: state.formStatus is FormSubmitting
                                  ? Container(
                                      height: 19,
                                      width: 19,
                                      margin:
                                          const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Color(0xFFD9D9D9)),
                                      ))
                                  : Text(L.of(context).updateDateOfBirth),
                            ))
                      ],
                    ),
                  );
                }))),
      ),
    );
  }
}
