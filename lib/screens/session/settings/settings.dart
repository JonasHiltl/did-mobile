import 'package:did/providers/appScreenState/sessionFlow/sessionCubit.dart';
import 'package:did/providers/appScreenState/sessionFlow/sessionState.dart';
import 'package:did/screens/session/personal_data/personalData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      if (state is Verified) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              // if floating is true the appbar becomes instantly visible if scrolled towards top
              // if it's false the appbar is only visible if completly scrolled back to top
              floating: true,
              elevation: 0.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Settings",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  titlePadding:
                      const EdgeInsetsDirectional.only(start: 20, bottom: 16)),
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
                padding: const EdgeInsets.all(20.0),
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
                          child: const Icon(
                            Icons.admin_panel_settings_rounded,
                            color: Color(0xFFF1F5F9),
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Personal Data",
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
            ))
          ],
        );
      } else {
        return const Text("Unverified");
      }
    });
  }
}
