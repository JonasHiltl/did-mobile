import 'package:did/global_components/noti.dart';
import 'package:did/providers/appScreenState/authFlow/authCubit.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
import 'package:did/providers/updatePersonalData/form_submission_status.dart';
import 'package:did/providers/updatePersonalData/repository/update_personal_data_repo.dart';
import 'package:did/providers/updatePersonalData/update_personal_bloc.dart';
import 'package:did/providers/updatePersonalData/update_personal_event.dart';
import 'package:did/providers/updatePersonalData/update_personal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';

class IndividualStateUpdateScreen extends StatefulWidget {
  final String initialValue;
  const IndividualStateUpdateScreen({required this.initialValue});

  @override
  _IndividualStateUpdateScreenState createState() =>
      _IndividualStateUpdateScreenState();
}

class _IndividualStateUpdateScreenState
    extends State<IndividualStateUpdateScreen> {
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
    return RepositoryProvider(
      create: (context) => UpdatePersonalDataRepo(),
      child: BlocProvider<UpdatePersonalBloc>(
        create: (context) => UpdatePersonalBloc(
          repo: context.read<UpdatePersonalDataRepo>(),
          authCubit: context.read<AuthCubit>(),
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
                    L.of(context).updateState,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  centerTitle: true,
                ),
                body: BlocConsumer<UpdatePersonalBloc, UpdatePersonalState>(
                    listener: (context, state) {
                  if (state.formStatus is SubmissionSuccess) {
                    showSuccessNoti(
                        message: L.of(context).updateSuccessSex,
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
                      children: [
                        Expanded(
                            child: TextFormField(
                                style: Theme.of(context).textTheme.bodyText2,
                                cursorWidth: 1,
                                controller: _controller,
                                decoration: InputDecoration(
                                    isDense: true,
                                    prefixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 10),
                                        child: Text(
                                          L.of(context).state,
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.6)),
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
                                    errorText: state.isValidState
                                        ? null
                                        : L.of(context).missingState,
                                    filled: true,
                                    fillColor: const Color(0xFFf1f3fd)),
                                validator: (value) => state.isValidState
                                    ? null
                                    : L.of(context).missingState,
                                onChanged: (value) => context
                                    .read<UpdatePersonalBloc>()
                                    .add(
                                      UpdatePersonalStateChanged(state: value),
                                    ))),
                        SizedBox(
                            width: size.width - 20,
                            child: ElevatedButton(
                              onPressed: !state.isValidState ||
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
                                  : Text(L.of(context).updateState),
                            ))
                      ],
                    ),
                  );
                }))),
      ),
    );
  }
}
