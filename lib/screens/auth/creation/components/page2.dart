import 'package:did/providers/create_did/createDidBloc.dart';
import 'package:did/providers/create_did/createDidEvent.dart';
import 'package:did/providers/language/languageBloc.dart';
import 'package:flutter/material.dart';
import 'package:did/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'customSteps.dart';

class Page2 extends StatefulWidget {
  const Page2({required this.formKeys, required this.dateController});
  final List<GlobalKey<FormState>> formKeys;
  final TextEditingController dateController;

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2>
    with AutomaticKeepAliveClientMixin<Page2> {
  final TextEditingController dateController = TextEditingController();

  void setSex(String? value) {
    setState(() {
      context
          .read<CreateDidBloc>()
          .add(CreateDidSexChanged(sex: value.toString()));
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Step2(),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: widget.formKeys[1],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    L.of(context).createHeader,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  TextFormField(
                    onTap: () => DatePicker.showDatePicker(
                      context,
                      locale:
                          context.read<LanguageBloc>().state.language == "en"
                              ? LocaleType.en
                              : LocaleType.de,
                      onConfirm: (date) {
                        context.read<CreateDidBloc>().add(
                              CreateDidDateOfBirthChanged(dateOfBirth: date),
                            );
                        dateController.text = DateFormat.yMMMd().format(date);
                      },
                      currentTime: context
                              .read<CreateDidBloc>()
                              .state
                              .dateOfBirth is DateTime
                          ? context.read<CreateDidBloc>().state.dateOfBirth
                          : DateTime.now(),
                      theme: DatePickerTheme(
                          itemStyle: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          doneStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16)),
                    ),
                    controller: dateController,
                    cursorWidth: 1,
                    readOnly: true,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Text(
                              L.of(context).dateOfBirth,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            )),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 100,
                        ),
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.black.withOpacity(0.6),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xFFACB6C5).withOpacity(0.6)),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: const Color(0xFFACB6C5).withOpacity(0.6),
                        )),
                        filled: true,
                        fillColor: const Color(0xFFF1F3FD)),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
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
                                  child: Row(children: [
                                    Radio(
                                      value: "female",
                                      groupValue: context
                                          .read<CreateDidBloc>()
                                          .state
                                          .sex,
                                      onChanged: setSex,
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    Text(L.of(context).female),
                                  ])),
                            ),
                            SizedBox(
                              width: size.height * 0.02,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
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
                                          .read<CreateDidBloc>()
                                          .state
                                          .sex,
                                      onChanged: setSex,
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
                      ])
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
