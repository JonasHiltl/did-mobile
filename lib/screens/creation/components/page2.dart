import 'package:did/blocs/createDid/createDidBloc.dart';
import 'package:did/blocs/createDid/createDidEvent.dart';
import 'package:did/blocs/language/languageBloc.dart';
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
  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime.now());
    if (newDate == null) return;
    //context.read is an extension method from Provider. import flutter_bloc to use with Bloc
    context.read<CreateDidBloc>().add(
          CreateDidDateOfBirthChanged(dateOfBirth: newDate),
        );
    widget.dateController.text = DateFormat.yMMMd().format(newDate);
  }

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
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: widget.formKeys[1],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    L.of(context).createHeader,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: size.height * 0.1,
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
                      currentTime: DateTime.now(),
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
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFACB6C5)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFFACB6C5),
                        )),
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9)),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(L.of(context).sex),
                        Row(
                          children: <Widget>[
                            Radio(
                              value: "female",
                              groupValue:
                                  context.read<CreateDidBloc>().state.sex,
                              onChanged: setSex,
                              activeColor: Theme.of(context).primaryColor,
                            ),
                            Text(L.of(context).female),
                            const SizedBox(
                              width: 30,
                            ),
                            Radio(
                              value: "male",
                              groupValue:
                                  context.read<CreateDidBloc>().state.sex,
                              onChanged: setSex,
                              activeColor: Theme.of(context).primaryColor,
                            ),
                            Text(L.of(context).male),
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
