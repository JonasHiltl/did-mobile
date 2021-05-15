import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import 'components/credentialDetailsView.dart';

class PersonalData extends StatefulWidget {
  @override
  _PersonalDataState createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          elevation: 0.0,
          // if floating is true the appbar becomes instantly visible if scrolled towards top
          // if it's false the appbar is only visible if completly scrolled back to top
          floating: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            L.of(context).personalData,
            style: Theme.of(context).textTheme.headline5,
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CredentialDetailsView(),
        ))
      ],
    );
  }
}
