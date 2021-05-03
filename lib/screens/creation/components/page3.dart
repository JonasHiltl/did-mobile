import 'package:did/components/CustomTextFields.dart';
import 'package:flutter/material.dart';
import 'package:did/generated/l10n.dart';

import 'customSteps.dart';

class Page3 extends StatefulWidget {
  const Page3({required this.formKeys});
  final List<GlobalKey<FormState>> formKeys;

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3>
    with AutomaticKeepAliveClientMixin<Page3> {
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
          Step3(),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: widget.formKeys[2],
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
                  addressField(),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  cityField(),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  stateField(),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  postalCodeField(),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  CountryField()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
