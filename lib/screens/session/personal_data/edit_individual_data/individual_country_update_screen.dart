import 'package:did/data/countries.dart';
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
import 'package:flutter_typeahead/flutter_typeahead.dart';

class IndividualCountryUpdateScreen extends StatefulWidget {
  final String initialValue;
  const IndividualCountryUpdateScreen({required this.initialValue});

  @override
  _IndividualCountryUpdateScreenState createState() =>
      _IndividualCountryUpdateScreenState();
}

class _IndividualCountryUpdateScreenState
    extends State<IndividualCountryUpdateScreen> {
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
                    L.of(context).updateCountry,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  centerTitle: true,
                ),
                body: BlocConsumer<UpdatePersonalBloc, UpdatePersonalState>(
                    listener: (context, state) {
                  if (state.formStatus is SubmissionSuccess) {
                    showSuccessNoti(
                        message: L.of(context).updateSuccessCountry,
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
                        TypeAheadField(
                          suggestionsBoxDecoration:
                              const SuggestionsBoxDecoration(
                                  elevation: 2, hasScrollbar: false),
                          textFieldConfiguration: TextFieldConfiguration(
                              controller: _controller,
                              cursorWidth: 1,
                              style: Theme.of(context).textTheme.bodyText2,
                              decoration: InputDecoration(
                                  isDense: true,
                                  prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      child: Text(
                                        L.of(context).country,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      )),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 100,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.expand_more,
                                    size: 28,
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
                                        .withOpacity(0.6),
                                  )),
                                  filled: true,
                                  fillColor: const Color(0xFFF1F3FD)),
                              onChanged: (value) =>
                                  context.read<UpdatePersonalBloc>().add(
                                        UpdatePersonalCountryChanged(
                                            country: value),
                                      )),
                          suggestionsCallback: (value) {
                            return CountryService.getSuggestions(value);
                          },
                          itemBuilder: (context, CustomCountry suggestion) {
                            final country = suggestion;

                            return ListTile(
                              leading: SizedBox(
                                height: 25,
                                width: 40,
                                child: Image.network(
                                  country.flagUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              title: Text(
                                country.name,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            );
                          },
                          noItemsFoundBuilder: (context) => SizedBox(
                            height: 50,
                            child: Center(
                              child: Text(L.of(context).noCountriesFound),
                            ),
                          ),
                          onSuggestionSelected: (CustomCountry? suggestion) {
                            final country = suggestion!;

                            _controller.text = country.name;
                            context.read<UpdatePersonalBloc>().add(
                                  UpdatePersonalCountryChanged(
                                      country: country.name),
                                );
                          },
                        ),
                        SizedBox(
                            width: size.width - 20,
                            child: ElevatedButton(
                              onPressed: !state.isValidCountry ||
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
                                  : Text(L.of(context).updateCountry),
                            ))
                      ],
                    ),
                  );
                }))),
      ),
    );
  }
}
