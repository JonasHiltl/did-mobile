import 'package:did/global_components/loading_indicator.dart';
import 'package:did/global_components/noti.dart';
import 'package:did/generated/l10n.dart';
import 'package:did/global_components/universal_text_field.dart';
import 'package:did/providers/app_screen_state/session_flow/session_bloc.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/providers/update_personal_data/form_submission_status.dart';
import 'package:did/providers/update_personal_data/repository/update_personal_data_repo.dart';
import 'package:did/providers/update_personal_data/update_personal_bloc.dart';
import 'package:did/providers/update_personal_data/update_personal_event.dart';
import 'package:did/providers/update_personal_data/update_personal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme.dart';

class IndividualLastNameUpdateScreen extends StatefulWidget {
  final String initialValue;
  const IndividualLastNameUpdateScreen({required this.initialValue});

  @override
  _IndividualLastNameUpdateScreenState createState() =>
      _IndividualLastNameUpdateScreenState();
}

class _IndividualLastNameUpdateScreenState
    extends State<IndividualLastNameUpdateScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
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
                L.of(context).updateLastName,
                style: Theme.of(context).textTheme.headline5,
              ),
              centerTitle: true,
            ),
            body: BlocConsumer<UpdatePersonalBloc, UpdatePersonalState>(
              listener: (context, state) {
                if (state.formStatus is SubmissionSuccess) {
                  showSuccessNoti(
                      message: L.of(context).updateSuccessLastName,
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
                      UniversalTextField(
                        prefixText: L.of(context).lastName,
                        initialValue: widget.initialValue,
                        onChanged: (value) => context
                            .read<UpdatePersonalBloc>()
                            .add(
                              UpdatePersonalLastNameChanged(lastName: value),
                            ),
                      ),
                      SizedBox(
                          width: size.width - kMediumPadding,
                          child: ElevatedButton(
                            onPressed: !state.isValidlastName ||
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
                                    margin:
                                        const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                    child: LoadingIndicator(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? const Color(0xFFD9D9D9)
                                          : kTextFieldDarkBorder,
                                    ),
                                  )
                                : Text(L.of(context).updateLastName),
                          ))
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
