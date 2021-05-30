import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Credential extends StatelessWidget {
  final List<Widget> children;
  final String title;

  const Credential({required this.children, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black38,
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
                    color: Theme.of(context).primaryColor,
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            "assets/images/dot_pattern_light_50.png"))),
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
          Container(
              margin: const EdgeInsets.only(
                top: 50,
              ),
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6))),
              child: Wrap(
                children: children,
              )),
        ],
      ),
    );
  }
}
