import 'package:did/providers/create_did/create_did_bloc.dart';
import 'package:did/providers/create_did/create_did_event.dart';
import 'package:did/providers/app_settings/app_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:did/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../../../theme.dart';
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
      context.read<CreateDidBloc>().add(
            CreateDidSexChanged(
              sex: value.toString(),
            ),
          );
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: kMediumPadding),
                child: Step2(),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight - 70,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kMediumPadding,
                      ),
                      child: Text(
                        L.of(context).createHeader,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        kMediumPadding,
                        0,
                        kMediumPadding,
                        kMediumPadding,
                      ),
                      child: Form(
                        key: widget.formKeys[1],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              onTap: () => DatePicker.showDatePicker(
                                context,
                                locale: context
                                            .read<AppSettingsBloc>()
                                            .state
                                            .language ==
                                        "en"
                                    ? LocaleType.en
                                    : LocaleType.de,
                                onConfirm: (date) {
                                  context.read<CreateDidBloc>().add(
                                        CreateDidDateOfBirthChanged(
                                            dateOfBirth: date),
                                      );
                                  dateController.text =
                                      DateFormat.yMMMd().format(date);
                                },
                                currentTime: context
                                        .read<CreateDidBloc>()
                                        .state
                                        .dateOfBirth is DateTime
                                    ? context
                                        .read<CreateDidBloc>()
                                        .state
                                        .dateOfBirth
                                    : DateTime.now(),
                                theme: DatePickerTheme(
                                  itemStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                  ),
                                  doneStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                  ),
                                  cancelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fontSize: 16,
                                      height: 1.5),
                                  backgroundColor:
                                      Theme.of(context).backgroundColor,
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
                                    horizontal: kSmallPadding,
                                  ),
                                  child: Text(
                                    L.of(context).dateOfBirth,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                ),
                                prefixIconConstraints: const BoxConstraints(
                                  minWidth: 100,
                                ),
                                suffixIcon: Icon(
                                  Icons.calendar_today,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.6),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: kSmallPadding),
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? kTextFieldLightBorder
                                        : kTextFieldDarkBorder,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(0xFFACB6C5)
                                        .withOpacity(0.6),
                                  ),
                                ),
                                filled: true,
                                fillColor: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? kLightAccentBG
                                    : kDarkAccentBG,
                              ),
                            ),
                            const SizedBox(
                              height: kSmallPadding,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? kLightAccentBG
                                              : kDarkAccentBG,
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border: Border.all(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? kTextFieldLightBorder
                                                    : kTextFieldDarkBorder,
                                          ),
                                        ),
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
                                        ]),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: kSmallPadding,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? kLightAccentBG
                                              : kDarkAccentBG,
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border: Border.all(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? kTextFieldLightBorder
                                                    : kTextFieldDarkBorder,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: "male",
                                              groupValue: context
                                                  .read<CreateDidBloc>()
                                                  .state
                                                  .sex,
                                              onChanged: setSex,
                                              activeColor: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            Text(L.of(context).male),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
