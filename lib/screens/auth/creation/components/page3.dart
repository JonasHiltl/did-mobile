import 'package:did/theme.dart';
import 'package:flutter/material.dart';
import 'package:did/generated/l10n.dart';

import 'customSteps.dart';
import 'customTextFields.dart';

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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Step3(),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        L.of(context).createHeader,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                      child: Form(
                        key: widget.formKeys[2],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            addressField(),
                            const SizedBox(
                              height: kSmallPadding,
                            ),
                            cityField(),
                            const SizedBox(
                              height: kSmallPadding,
                            ),
                            stateField(),
                            const SizedBox(
                              height: kSmallPadding,
                            ),
                            postalCodeField(),
                            const SizedBox(
                              height: kSmallPadding,
                            ),
                            CountryField()
                          ],
                        ),
                      ),
                    ),
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
