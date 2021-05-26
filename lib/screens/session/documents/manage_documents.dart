import 'package:flutter/material.dart';

class ManageDocuments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          // if floating is true the appbar becomes instantly visible if scrolled towards top
          // if it's false the appbar is only visible if completly scrolled back to top
          floating: true,
          expandedHeight: 60.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Manage Documents",
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          centerTitle: true,
        ),
      ],
    );
  }
}
