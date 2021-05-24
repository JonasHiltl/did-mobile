import 'dart:io' show Platform;

import 'package:did/generated/l10n.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionCubit.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
import 'package:did/screens/session/personal_data/personalData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../data/secureStorage.dart';
import '../settings/settings.dart';

class ManageApp extends StatelessWidget {
  final SecureStorage secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      if (state is Verified) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              // if floating is true the appbar becomes instantly visible if scrolled towards top
              // if it's false the appbar is only visible if completly scrolled back to top
              floating: true,
              elevation: 0.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Manage App",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  titlePadding:
                      const EdgeInsetsDirectional.only(start: 20, bottom: 16)),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
                child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      curve: Curves.easeInOut,
                      child: PersonalData())),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Icon(
                            Icons.person,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              L.of(context).personalData,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        )
                      ],
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            )),
            SliverToBoxAdapter(
                child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      curve: Curves.easeInOut,
                      child: Settings())),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Icon(
                            Icons.settings,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              L.of(context).settings,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        )
                      ],
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            )),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: ElevatedButton(
                    onPressed: () => Platform.isAndroid
                        ? showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(L.of(context).deleteData),
                                content:
                                    Text(L.of(context).confirmDataDeletion),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(L.of(context).no)),
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<SessionCubit>()
                                            .deleteAll();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        L.of(context).yes,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).errorColor),
                                      ))
                                ],
                              );
                            })
                        : showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text(L.of(context).deleteData),
                                content:
                                    Text(L.of(context).confirmDataDeletion),
                                actions: [
                                  CupertinoDialogAction(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(L.of(context).no)),
                                  CupertinoDialogAction(
                                      onPressed: () {
                                        context
                                            .read<SessionCubit>()
                                            .deleteAll();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        L.of(context).yes,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).errorColor),
                                      ))
                                ],
                              );
                            }),
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return const Color(0xFFf84042);
                          }
                          if (states.contains(MaterialState.hovered)) {
                            return const Color(0xFFf84042);
                          }
                          if (states.contains(MaterialState.pressed)) {
                            return const Color(0xFFe40a0c);
                          }
                          if (states.contains(MaterialState.disabled)) {
                            return const Color(0xFFF5F5F5);
                          }
                          return Theme.of(context).errorColor;
                        }),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return const Color(0xFFf84042);
                          }
                          if (states.contains(MaterialState.hovered)) {
                            return const Color(0xFFf84042);
                          }
                          if (states.contains(MaterialState.pressed)) {
                            return const Color(0xFFe40a0c);
                          }
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.black.withOpacity(0.03);
                          }
                          return Theme.of(context).errorColor;
                        }),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: BorderSide(
                                color: Theme.of(context).errorColor)))),
                    child: Text(L.of(context).deleteAll)),
              ),
            )
          ],
        );
      } else {
        return const Text("Unverified");
      }
    });
  }
}
