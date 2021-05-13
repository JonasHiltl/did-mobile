import 'package:flutter/material.dart';

class Credential extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final String title;

  const Credential(
      {required this.children, required this.spacing, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Theme.of(context).backgroundColor),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                color: Theme.of(context).primaryColor,
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        AssetImage("assets/images/dot_pattern_light_50.png"))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          Column(
              children: children
                  .map((e) => Container(
                        padding: EdgeInsets.only(bottom: spacing),
                        child: e,
                      ))
                  .toList()),
        ],
      ),
    );
  }
}
