import 'package:did/global_components/loading_indicator.dart';
import 'package:did/global_components/noti.dart';
import 'package:did/global_components/universal_text_field.dart';
import 'package:did/providers/app_screen_state/session_flow/session_cubit.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/providers/update_personal_data/form_submission_status.dart';
import 'package:did/providers/update_personal_data/repository/update_personal_data_repo.dart';
import 'package:did/providers/update_personal_data/update_personal_bloc.dart';
import 'package:did/providers/update_personal_data/update_personal_event.dart';
import 'package:did/providers/update_personal_data/update_personal_state.dart';
import 'package:did/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme.dart';

class IndividualAddressUpdateScreen extends StatefulWidget {
  final String initialValue;
  const IndividualAddressUpdateScreen({required this.initialValue});

  @override
  _IndividualAddressUpdateScreenState createState() =>
      _IndividualAddressUpdateScreenState();
}

class _IndividualAddressUpdateScreenState
    extends State<IndividualAddressUpdateScreen> {
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
    final sessionState = context.watch<Verified>();
    final identity = context.watch<Verified>().identity;
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
                L.of(context).updateAddress,
                style: Theme.of(context).textTheme.headline5,
              ),
              centerTitle: true,
            ),
            body: BlocConsumer<UpdatePersonalBloc, UpdatePersonalState>(
              listener: (context, state) {
                if (state.formStatus is SubmissionSuccess) {
                  showSuccessNoti(
                      message: L.of(context).updateSuccessAddress,
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
                        prefixText: L.of(context).address,
                        initialValue: widget.initialValue,
                        onChanged: (value) =>
                            context.read<UpdatePersonalBloc>().add(
                                  UpdatePersonalAddressChanged(address: value),
                                ),
                      ),
                      SizedBox(
                          width: size.width - kMediumPadding,
                          child: ElevatedButton(
                            onPressed: !state.isValidAddress ||
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
                                : Text(L.of(context).updateAddress),
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
