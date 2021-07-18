import 'package:did/global_components/universal_text_field.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/countries.dart';
import '../../../../generated/l10n.dart';
import '../../../../providers/create_did/create_did_bloc.dart';
import '../../../../providers/create_did/create_did_event.dart';
import '../../../../providers/create_did/create_did_state.dart';

class FirstNameField extends StatefulWidget {
  @override
  _FirstNameFieldState createState() => _FirstNameFieldState();
}

class _FirstNameFieldState extends State<FirstNameField>
    with AutomaticKeepAliveClientMixin<FirstNameField> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CreateDidBloc, CreateDidState>(
      builder: (context, state) {
        return UniversalTextField(
          prefixText: L.of(context).firstName,
          onChanged: (value) => context.read<CreateDidBloc>().add(
                CreateDidFirstNameChanged(firstName: value),
              ),
        );
      },
    );
  }
}

class LastNameField extends StatefulWidget {
  @override
  _LastNameFieldState createState() => _LastNameFieldState();
}

class _LastNameFieldState extends State<LastNameField>
    with AutomaticKeepAliveClientMixin<LastNameField> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CreateDidBloc, CreateDidState>(
      builder: (context, state) {
        return UniversalTextField(
          prefixText: L.of(context).lastName,
          onChanged: (value) => context.read<CreateDidBloc>().add(
                CreateDidLastNameChanged(lastName: value),
              ),
        );
      },
    );
  }
}

class EmailField extends StatefulWidget {
  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField>
    with AutomaticKeepAliveClientMixin<EmailField> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CreateDidBloc, CreateDidState>(
      builder: (context, state) {
        return UniversalTextField(
          prefixText: L.of(context).email,
          errorText: state.showEmailError ? L.of(context).invalidEmail : null,
          onChanged: (value) => context.read<CreateDidBloc>().add(
                CreateDidEmailChanged(email: value),
              ),
        );
      },
    );
  }
}

class PhoneNumberField extends StatefulWidget {
  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField>
    with AutomaticKeepAliveClientMixin<PhoneNumberField> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CreateDidBloc, CreateDidState>(
      builder: (context, state) {
        return UniversalTextField(
          prefixText: L.of(context).phoneNumber,
          keyboardType: TextInputType.number,
          onChanged: (value) => context.read<CreateDidBloc>().add(
                CreateDidPhoneNumberChanged(phoneNumber: value),
              ),
        );
      },
    );
  }
}

Widget addressField() {
  return BlocBuilder<CreateDidBloc, CreateDidState>(
    builder: (context, state) {
      return UniversalTextField(
        prefixText: L.of(context).address,
        onChanged: (value) => context.read<CreateDidBloc>().add(
              CreateDidAddressChanged(address: value),
            ),
      );
    },
  );
}

Widget cityField() {
  return BlocBuilder<CreateDidBloc, CreateDidState>(
    builder: (context, state) {
      return UniversalTextField(
        prefixText: L.of(context).city,
        onChanged: (value) => context.read<CreateDidBloc>().add(
              CreateDidCityChanged(city: value),
            ),
      );
    },
  );
}

Widget stateField() {
  return BlocBuilder<CreateDidBloc, CreateDidState>(
    builder: (context, state) {
      return UniversalTextField(
        prefixText: L.of(context).state,
        onChanged: (value) => context.read<CreateDidBloc>().add(
              CreateDidStateChanged(state: value),
            ),
      );
    },
  );
}

Widget postalCodeField() {
  return BlocBuilder<CreateDidBloc, CreateDidState>(
    builder: (context, state) {
      return UniversalTextField(
        prefixText: L.of(context).postalCode,
        keyboardType: TextInputType.number,
        onChanged: (value) => context.read<CreateDidBloc>().add(
              CreateDidPostalCodeChanged(postalCode: value),
            ),
      );
    },
  );
}

class CountryField extends StatefulWidget {
  @override
  _CountryFieldState createState() => _CountryFieldState();
}

class _CountryFieldState extends State<CountryField> {
  final txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateDidBloc, CreateDidState>(
      builder: (context, state) {
        return TypeAheadField(
          suggestionsBoxDecoration:
              const SuggestionsBoxDecoration(elevation: 2, hasScrollbar: false),
          textFieldConfiguration: TextFieldConfiguration(
            controller: txt,
            cursorWidth: 1,
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Text(
                  L.of(context).country,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 100,
              ),
              suffixIcon: const Icon(
                Icons.expand_more,
                size: 28,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xFFACB6C5).withOpacity(0.6),
                ),
              ),
              filled: true,
              fillColor: const Color(0xFFF1F3FD),
            ),
            onChanged: (value) => context.read<CreateDidBloc>().add(
                  CreateDidCountryChanged(country: value),
                ),
          ),
          suggestionsCallback: (value) {
            return getCountrySuggestion(value);
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

            txt.text = country.name;
            context.read<CreateDidBloc>().add(
                  CreateDidCountryChanged(country: country.name),
                );
          },
        );
      },
    );
  }
}
