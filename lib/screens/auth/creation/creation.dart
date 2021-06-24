import 'package:did/generated/l10n.dart';
import 'package:did/global_components/loading_indicator.dart';
import 'package:did/providers/create_did/createDidBloc.dart';
import 'package:did/providers/create_did/createDidEvent.dart';
import 'package:did/providers/create_did/createDidState.dart';
import 'package:did/providers/create_did/formSubmissionStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global_components/noti.dart';
import 'components/page1.dart';
import 'components/page2.dart';
import 'components/page3.dart';

class Creation extends StatefulWidget {
  @override
  _CreationState createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  final TextEditingController dateController = TextEditingController();
  final PageController _pageController = PageController();
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  int currentStep = 0;
  bool complete = false;

  Future next() async {
    final validationSuccess = formKeys[currentStep].currentState?.validate();
    if (validationSuccess != null) {
      if (validationSuccess) {
        if (currentStep == 2) {
          context.read<CreateDidBloc>().add(CreateDidSubmitted());
        } else {
          currentStep != 2
              ? goTo(currentStep + 1)
              : setState(() => complete = true);
        }
      }
    } else {
      print("could not submit");
    }
  }

  void goTo(int step) {
    _pageController.animateToPage(step,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  void cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  @override
  void dispose() {
    dateController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        BlocListener<CreateDidBloc, CreateDidState>(
          listener: (context, state) {
            if (state.formStatus is SubmissionSuccess) {
              showSuccessNoti(
                  message: L
                      .of(context)
                      .createSuccessMessage, //TODO: make mesasge dynamic and display message of formstatus
                  context: context);
            } else if (state.formStatus is SubmissionFailed) {
              showErrorNoti(
                  message: L.of(context).createErrorMessage, context: context);
            }
          },
          child: Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => currentStep = index);
              },
              children: [
                Page1(formKeys: formKeys),
                Page2(formKeys: formKeys, dateController: dateController),
                Page3(formKeys: formKeys),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (currentStep == 0)
                BlocBuilder<CreateDidBloc, CreateDidState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: size.width - 20,
                      child: ElevatedButton(
                          onPressed: !state.isValidFirstName ||
                                  !state.isValidlastName ||
                                  !state.isValidEmail ||
                                  !state.isValidPhoneNumber
                              ? null
                              : next,
                          child: Text(L.of(context).next)),
                    );
                  },
                ),
              if (currentStep == 1)
                Column(
                  children: [
                    BlocBuilder<CreateDidBloc, CreateDidState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: size.width - 20,
                          child: ElevatedButton(
                              onPressed:
                                  !state.isValidDateOfBirth || !state.isValidSex
                                      ? null
                                      : next,
                              child: Text(L.of(context).next)),
                        );
                      },
                    ),
                    BlocBuilder<CreateDidBloc, CreateDidState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: size.width - 20,
                          child: OutlinedButton(
                              onPressed: state.formStatus is FormSubmitting
                                  ? null
                                  : cancel,
                              child: Text(L.of(context).back)),
                        );
                      },
                    )
                  ],
                ),
              if (currentStep == 2)
                Column(
                  children: [
                    BlocBuilder<CreateDidBloc, CreateDidState>(
                      builder: (context, state) {
                        return SizedBox(
                            width: size.width - 20,
                            child: ElevatedButton(
                              onPressed: state.formStatus is FormSubmitting ||
                                      !state.isValidAddress ||
                                      !state.isValidCity ||
                                      !state.isValidState ||
                                      !state.isValidCountry ||
                                      !state.isValidPostalCode
                                  ? null
                                  : next,
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
                                  : Text(L.of(context).submit),
                            ));
                      },
                    ),
                    BlocBuilder<CreateDidBloc, CreateDidState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: size.width - 20,
                          child: OutlinedButton(
                              onPressed: state.formStatus is FormSubmitting
                                  ? null
                                  : cancel,
                              child: Text(L.of(context).back)),
                        );
                      },
                    )
                  ],
                ),
            ],
          ),
        ),
      ],
    )));
  }
}
