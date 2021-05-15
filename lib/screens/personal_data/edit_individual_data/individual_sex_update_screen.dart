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

class IndividualSexUpdateScreen extends StatefulWidget {
  final String initialValue;
  const IndividualSexUpdateScreen({required this.initialValue});

  @override
  _IndividualSexUpdateScreenState createState() =>
      _IndividualSexUpdateScreenState();
}

class _IndividualSexUpdateScreenState extends State<IndividualSexUpdateScreen> {
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
                    L.of(context).updateSex,
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 18, 0),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFF1F3FD),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        border: Border.all(
                                            color: const Color(0xFFACB6C5)
                                                .withOpacity(0.6))),
                                    child: Row(children: [
                                      Radio(
                                        value: "female",
                                        groupValue: context
                                            .read<UpdatePersonalBloc>()
                                            .state
                                            .sex,
                                        onChanged: (value) => context
                                            .read<UpdatePersonalBloc>()
                                            .add(UpdatePersonalSexChanged(
                                                sex: value.toString())),
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                      Text(L.of(context).female),
                                    ])),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 18, 0),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF1F3FD),
                                      borderRadius: BorderRadius.circular(4.0),
                                      border: Border.all(
                                          color: const Color(0xFFACB6C5)
                                              .withOpacity(0.6))),
                                  child: Row(
                                    children: [
                                      Radio(
                                        value: "male",
                                        groupValue: context
                                            .read<UpdatePersonalBloc>()
                                            .state
                                            .sex,
                                        onChanged: (value) => context
                                            .read<UpdatePersonalBloc>()
                                            .add(UpdatePersonalSexChanged(
                                                sex: value.toString())),
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                      Text(L.of(context).male),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            width: size.width - 20,
                            child: ElevatedButton(
                              onPressed: !state.isValidSex ||
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
                                  : Text(L.of(context).updateSex),
                            ))
                      ],
                    ),
                  );
                }))),
      ),
    );
  }
}
