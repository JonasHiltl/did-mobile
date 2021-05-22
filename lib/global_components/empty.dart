import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Empty extends StatelessWidget {
  final String text;
  const Empty({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 100,
            child: SvgPicture.asset('assets/images/undraw_no_data.svg')),
        const SizedBox(
          height: 8,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.3)),
        ),
      ],
    );
  }
}
