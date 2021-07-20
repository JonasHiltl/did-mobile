import 'package:did/generated/l10n.dart';
import 'package:did/providers/app_screen_state/session_flow/session_cubit.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';

import 'package:did/screens/session/manage_app/components/delete_all_button.dart';
import 'package:did/screens/session/manage_app/components/security_expansion_tile.dart';
import 'package:did/screens/session/manage_app/components/settings_expansion_tile.dart';
import 'package:did/screens/session/personal_data/personalData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../data/secure_storage.dart';
import '../../../theme.dart';

class ManageApp extends StatefulWidget {
  @override
  _ManageAppState createState() => _ManageAppState();
}

class _ManageAppState extends State<ManageApp> {
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
              title: Text(
                "Manage App",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: kSmallPadding,
              ),
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    curve: Curves.easeInOut,
                    child: PersonalData(),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kMediumPadding, vertical: kSmallPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.person,
                              color: Theme.of(context).backgroundColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: kSmallPadding,
                          ),
                          Text(
                            L.of(context).identity,
                            style: Theme.of(context).textTheme.headline6,
                          )
                        ],
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SecurityExpansionTile(),
            ),
            const SliverToBoxAdapter(
              child: SettingsExpansionTile(),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kMediumPadding, vertical: kSmallPadding),
                child: DeleteAllButton(),
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
