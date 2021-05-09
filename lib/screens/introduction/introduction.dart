import 'package:did/blocs/appScreenState/authFlow/authCubit.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/minimalChangeLanguage.dart';
import '../../models/carousel.dart';

class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction>
    with TickerProviderStateMixin {
  final CarouselController _controller = CarouselController();
  late AnimationController _animationController;
  late AnimationController _scaleController;
  late AnimationController _widthController;
  late AnimationController _moveController;
  late AnimationController _scale2Controller;

  late Animation<double> _scaleAnimation;
  late Animation<double> _widthAnimation;
  late Animation<double> _moveAnimation;
  late Animation<double> _scale2Animation;

  int _current = 0;
  bool hideProgessIndicator = false;
  bool hideIcon = false;
  List<Carousel> carouselList = [
    Carousel(
        title: "Doctors",
        paragraph:
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt, sed diam voluptua.",
        imagePath: 'assets/images/undraw_doctors.svg'),
    Carousel(
        title: "Privacy",
        paragraph:
            "Lorem ipsum dolor , sed diam nonumy eirmod tempor invidunt ut labore et dolore magna erat, sed diam voluptua. At",
        imagePath: 'assets/images/undraw_Private_data.svg'),
    Carousel(
        title: "Health",
        paragraph:
            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmo magna aliquyam erat, sed diam voluptua. At",
        imagePath: 'assets/images/undraw_doctor.svg'),
  ];

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _widthController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _moveController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _scale2Controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.9).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });
    _widthAnimation = Tween<double>(begin: 60.0, end: 300.0).animate(
        CurvedAnimation(parent: _widthController, curve: Curves.easeInOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _moveController.forward();
        }
      });

    _moveAnimation = Tween<double>(begin: 0.0, end: 240.0).animate(
        CurvedAnimation(parent: _moveController, curve: Curves.easeInOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            hideIcon = true;
          });
          _scale2Controller.forward();
        }
      });

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 42.0).animate(_scale2Controller);

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: InkWell(
                onTap: () {
                  if (_current > 0) {
                    _controller.previousPage();
                  }
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
              ),
            ),
            MinimalChangeLanguage()
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(children: [
                  FadeTransition(
                    opacity: _animationController,
                    child: Text(
                      carouselList[_current].title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FadeTransition(
                        opacity: _animationController,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: carouselList[_current].paragraph,
                                style: Theme.of(context).textTheme.bodyText2,
                              )
                            ]))),
                  )
                ]),
              ),
              CarouselSlider(
                options: CarouselOptions(
                    autoPlayCurve: Curves.easeIn,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 400),
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      _animationController.reset();
                      _animationController.forward();

                      setState(() {
                        _current = index;
                      });
                    }),
                carouselController: _controller,
                items: carouselList.map((carousel) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(children: [
                        Expanded(
                          flex: 3,
                          child: SvgPicture.asset(
                            carousel.imagePath,
                          ),
                        ),
                      ]);
                    },
                  );
                }).toList(),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ...Iterable<int>.generate(carouselList.length).map(
                      (int pageIndex) => InkWell(
                        onTap: () {
                          _controller.animateToPage(pageIndex);
                        },
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            margin: const EdgeInsets.all(10),
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: _current == pageIndex
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor))),
                      ),
                    ),
                  ]),
            ],
          ),
        ),
        AnimatedBuilder(
            animation: _scaleController,
            builder: (context, child) => Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (hideProgessIndicator == false)
                        AnimatedBuilder(
                          animation: _widthController,
                          builder: (context, child) => SizedBox(
                              width: _widthAnimation.value,
                              height: 60,
                              child: CircularProgressIndicator(
                                value: (_current + 1) / (carouselList.length),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.4)),
                              )),
                        ),
                      Center(
                        child: AnimatedBuilder(
                          animation: _widthController,
                          builder: (context, child) => Container(
                            width: _widthAnimation.value,
                            height: 60,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: hideProgessIndicator
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.4)
                                  : Colors.transparent,
                            ),
                            child: InkWell(
                                onTap: () async {
                                  if (_current + 1 == carouselList.length) {
                                    setState(() {
                                      hideProgessIndicator = true;
                                    });
                                    _scaleController.forward();
                                    //TODO wait time and push new page
                                    await Future.delayed(
                                        const Duration(milliseconds: 2200),
                                        () => context
                                            .read<AuthCubit>()
                                            .showCreation());
                                  } else {
                                    _controller.nextPage();
                                  }
                                },
                                borderRadius: BorderRadius.circular(25),
                                child: Stack(
                                  children: [
                                    AnimatedBuilder(
                                      animation: _moveAnimation,
                                      builder: (context, child) => Positioned(
                                        left: _moveAnimation.value,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                child: AnimatedBuilder(
                                              animation: _scale2Controller,
                                              builder: (context, child) =>
                                                  Transform.scale(
                                                scale: _scale2Animation.value,
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  child: hideIcon == false
                                                      ? const Icon(
                                                          Icons.arrow_forward,
                                                          color: Colors.white,
                                                        )
                                                      : Container(),
                                                ),
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
        const SizedBox(
          height: 16,
        )
      ],
    )));
  }
}
