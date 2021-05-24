import 'package:did/global_components/changeLanguage.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
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
            L.of(context).settings,
            style: Theme.of(context).textTheme.headline5,
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(child: ChangeLanguage())
      ],
    );
  }
}
