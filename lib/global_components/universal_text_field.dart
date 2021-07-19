import 'package:did/theme.dart';
import 'package:flutter/material.dart';

class UniversalTextField extends StatelessWidget {
  final String? errorText;
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final String prefixText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Color? textColor;
  const UniversalTextField({
    this.errorText,
    this.hintText,
    this.controller,
    this.onChanged,
    this.initialValue,
    this.keyboardType,
    this.readOnly,
    this.textColor,
    required this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      initialValue: initialValue,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(color: textColor),
      cursorWidth: 1,
      controller: controller,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: kSmallPadding,
          ),
          child: Text(
            prefixText,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.6),
                ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 120,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: kSmallPadding,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFFACB6C5).withOpacity(0.6),
          ),
        ),
        errorText: errorText,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.4),
        ),
        filled: true,
        fillColor: const Color(0xFFf1f3fd),
      ),
      onChanged: onChanged,
    );
  }
}
