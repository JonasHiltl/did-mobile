import 'package:did/global_components/noti.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionCubit.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
import 'package:did/generated/l10n.dart';
import 'package:did/providers/updatePersonalData/form_submission_status.dart';
import 'package:did/providers/updatePersonalData/repository/update_personal_data_repo.dart';
import 'package:did/providers/updatePersonalData/update_personal_bloc.dart';
import 'package:did/providers/updatePersonalData/update_personal_event.dart';
import 'package:did/providers/updatePersonalData/update_personal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndividualFirstNameUpdateScreen extends StatefulWidget {
  final String initialValue;
  const IndividualFirstNameUpdateScreen({required this.initialValue});

  @override
  _IndividualFirstNameUpdateScreenState createState() =>
      _IndividualFirstNameUpdateScreenState();
}

class _IndividualFirstNameUpdateScreenState
    extends State<IndividualFirstNameUpdateScreen> {
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
                    L.of(context).updateFirstName,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  centerTitle: true,
                ),
                body: BlocConsumer<UpdatePersonalBloc, UpdatePersonalState>(
                    listener: (context, state) {
                  if (state.formStatus is SubmissionSuccess) {
                    showSuccessNoti(
                        message: L.of(context).updateSuccessFirstName,
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
                          style: Theme.of(context).textTheme.bodyText2,
                          cursorWidth: 1,
                          controller: _controller,
                          decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  child: Text(
                                    L.of(context).firstName,
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFFACB6C5)
                                          .withOpacity(0.6))),
                              errorText: state.isValidFirstName
                                  ? null
                                  : L.of(context).missingFirstName,
                              filled: true,
                              fillColor: const Color(0xFFf1f3fd)),
                          validator: (value) => state.isValidFirstName
                              ? null
                              : L.of(context).missingFirstName,
                          onChanged: (value) =>
                              context.read<UpdatePersonalBloc>().add(
                                    UpdatePersonalFirstNameChanged(
                                        firstName: value),
                                  ),
                        ),
                        SizedBox(
                            width: size.width - 20,
                            child: ElevatedButton(
                              onPressed: !state.isValidFirstName ||
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
                                  : Text(L.of(context).updateFirstName),
                            ))
                      ],
                    ),
                  );
                }))),
      ),
    );
  }
}
