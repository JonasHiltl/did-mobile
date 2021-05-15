import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          // if floating is true the appbar becomes instantly visible if scrolled towards top
          // if it's false the appbar is only visible if completly scrolled back to top
          floating: true,
          expandedHeight: 60.0,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Page 2",
                style: Theme.of(context).textTheme.headline6,
              ),
              titlePadding:
                  const EdgeInsetsDirectional.only(start: 20, bottom: 16)),
        ),
      ],
    );
  }
}
