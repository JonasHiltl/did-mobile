import 'package:flutter/material.dart';

class UniversalTextField extends StatelessWidget {
  final String? errorText;
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final String prefixText;
  const UniversalTextField({
    this.errorText,
    this.hintText,
    this.controller,
    this.onChanged,
    required this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: Theme.of(context).textTheme.bodyText2,
        cursorWidth: 1,
        controller: controller,
        decoration: InputDecoration(
            isDense: true,
            prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Text(
                  prefixText,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                )),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 120,
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
                    color: const Color(0xFFACB6C5).withOpacity(0.6))),
            errorText: errorText,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
            filled: true,
            fillColor: const Color(0xFFf1f3fd)),
        onChanged: onChanged);
  }
}
