import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';

class DynamicTextField extends StatefulWidget {
  final String initialValue;
  final String label;
  const DynamicTextField({required this.initialValue, required this.label});

  @override
  _DynamicTextFieldState createState() => _DynamicTextFieldState();
}

class _DynamicTextFieldState extends State<DynamicTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
          readOnly: true,
          controller: _controller,
          keyboardType: TextInputType.number,
          cursorWidth: 1,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.black.withOpacity(0.6)),
          decoration: InputDecoration(
              isDense: true,
              prefixIcon: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Text(
                    widget.label,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  )),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 100,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xFFACB6C5).withOpacity(0.6)),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: const Color(0xFFACB6C5).withOpacity(0.6),
              )),
              filled: true,
              fillColor: const Color(0xFFF1F3FD)),
          onChanged: (value) => {}),
    );
  }
}
