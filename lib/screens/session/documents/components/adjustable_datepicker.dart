import 'package:did/providers/app_settings/app_settings_bloc.dart';
import 'package:did/providers/share_document/share_document_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme.dart';

class AdjustableDatePicker extends StatelessWidget {
  const AdjustableDatePicker({
    required this.dateController,
    required this.currentTime,
    required this.state,
    required this.prefixText,
    this.onConfirm,
    Key? key,
  }) : super(key: key);

  final ShareDocumentState state;
  final TextEditingController dateController;
  final Function(DateTime)? onConfirm;
  final DateTime? currentTime;
  final String prefixText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () => state.noExpiration
          ? null
          : DatePicker.showDatePicker(
              context,
              locale: context.read<AppSettingsBloc>().state.language == "en"
                  ? LocaleType.en
                  : LocaleType.de,
              onConfirm: onConfirm,
              currentTime: currentTime,
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
                    color: Theme.of(context).colorScheme.onBackground,
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
            vertical: 15,
            horizontal: 10,
          ),
          child: Text(
            prefixText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(
                    state.noExpiration ? 0.2 : 0.6,
                  ),
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 100,
        ),
        suffixIcon: Icon(
          Icons.calendar_today,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(
                state.noExpiration ? 0.2 : 0.6,
              ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.light
                ? kTextFieldLightBorder
                : kTextFieldDarkBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: state.noExpiration
                ? Theme.of(context).brightness == Brightness.light
                    ? kLightAccentBG.withOpacity(0.5)
                    : Colors.white.withOpacity(0.05)
                : Theme.of(context).brightness == Brightness.light
                    ? kTextFieldLightBorder
                    : kTextFieldDarkBorder,
          ),
        ),
        filled: true,
        fillColor: state.noExpiration
            ? Theme.of(context).brightness == Brightness.light
                ? kLightAccentBG
                : Colors.white.withOpacity(0.05)
            : Theme.of(context).brightness == Brightness.light
                ? kLightAccentBG
                : kDarkAccentBG,
      ),
    );
  }
}
