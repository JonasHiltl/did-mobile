import 'package:did/global_components/minimal_change_language.dart';
import 'package:did/providers/app_screen_state/auth_flow/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../generated/l10n.dart';

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.headline4!,
      bodyTextStyle: Theme.of(context).textTheme.bodyText1!,
      descriptionPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
      bodyFlex: 2,
      imageFlex: 3,
      imageAlignment: Alignment.topCenter,
    );

    return IntroductionScreen(
      isTopSafeArea: true,
      globalBackgroundColor: Theme.of(context).backgroundColor,
      done: Text(L.of(context).next),
      onDone: () => context.read<AuthCubit>().showCreation(),
      showSkipButton: true,
      skip: Text(L.of(context).skip),
      onSkip: () => context.read<AuthCubit>().showCreation(),
      next: const Icon(Icons.arrow_forward),
      animationDuration: 300,
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        activeColor: Theme.of(context).primaryColor,
        activeSize: const Size(18.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      globalHeader: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MinimalChangeLanguage(),
        ],
      )),
      pages: [
        PageViewModel(
          title: "Doctors",
          body:
              "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt, sed diam voluptua.",
          image: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/undraw_medicine.svg",
                width: 350,
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Privacy",
          body:
              "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt, sed diam voluptua.",
          image: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/undraw_secure_files.svg",
                width: 350,
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Health",
          body:
              "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt, sed diam voluptua.",
          image: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/undraw_doctor.svg",
                width: 350,
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
    );
  }
}
