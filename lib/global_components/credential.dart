import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Credential extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final Color? highlightColor;

  const Credential({
    required this.children,
    required this.title,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6)),
                  color: highlightColor ?? Theme.of(context).primaryColor,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/dot_pattern_light_50.png"),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          Card(
            margin: const EdgeInsets.only(
              top: 50,
            ),
            child: Wrap(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
