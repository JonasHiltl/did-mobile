import 'package:did/global_components/loading_indicator.dart';
import 'package:did/global_components/noti.dart';
import 'package:did/generated/l10n.dart';
import 'package:did/providers/app_screen_state/session_flow/session_cubit.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/providers/update_personal_data/form_submission_status.dart';
import 'package:did/providers/update_personal_data/repository/update_personal_data_repo.dart';
import 'package:did/providers/update_personal_data/update_personal_bloc.dart';
import 'package:did/providers/update_personal_data/update_personal_event.dart';
import 'package:did/providers/update_personal_data/update_personal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndividualPostalCodeUpdateScreen extends StatefulWidget {
  final String initialValue;
  const IndividualPostalCodeUpdateScreen({required this.initialValue});

  @override
  _IndividualPostalCodeUpdateScreenState createState() =>
      _IndividualPostalCodeUpdateScreenState();
}

class _IndividualPostalCodeUpdateScreenState
    extends State<IndividualPostalCodeUpdateScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
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
                    L.of(context).updatePostalCode,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  centerTitle: true,
                ),
                body: BlocConsumer<UpdatePersonalBloc, UpdatePersonalState>(
                    listener: (context, state) {
                  if (state.formStatus is SubmissionSuccess) {
                    showSuccessNoti(
                        message: L.of(context).updateSuccessPostalCode,
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
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.bodyText2,
                            cursorWidth: 1,
                            controller: _controller,
                            decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: Text(
                                      L.of(context).postalCode,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
                                    )),
                                prefixIconConstraints: const BoxConstraints(
                                  minWidth: 120,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xFFACB6C5)
                                            .withOpacity(0.6))),
                                errorText: state.isValidPostalCode
                                    ? null
                                    : L.of(context).missingPostalCode,
                                filled: true,
                                fillColor: const Color(0xFFf1f3fd)),
                            validator: (value) => state.isValidPostalCode
                                ? null
                                : L.of(context).missingPostalCode,
                            onChanged: (value) =>
                                context.read<UpdatePersonalBloc>().add(
                                      UpdatePersonalPostalCodeChanged(
                                          postalCode: value),
                                    )),
                        SizedBox(
                            width: size.width - 20,
                            child: ElevatedButton(
                              onPressed: !state.isValidPostalCode ||
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
                                      child: const LoadingIndicator(
                                        color: Color(0xFFD9D9D9),
                                      ),
                                    )
                                  : Text(L.of(context).updatePostalCode),
                            ))
                      ],
                    ),
                  );
                }))),
      ),
    );
  }
}
