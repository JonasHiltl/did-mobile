import 'package:did/providers/app_screen_state/session_flow/session_bloc.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/providers/update_personal_data/repository/update_personal_data_repo.dart';
import 'package:did/providers/update_personal_data/update_personal_bloc.dart';
import 'package:did/screens/session/personal_data/components/id_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../../theme.dart';
import 'components/credential_details_view.dart';

class PersonalData extends StatefulWidget {
  @override
  _PersonalDataState createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  @override
  Widget build(BuildContext context) {
    final sessionState = context.watch<SessionState>();
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0.0,
              // if floating is true the appbar becomes instantly visible if scrolled towards top
              // if it's false the appbar is only visible if completly scrolled back to top
              floating: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                L.of(context).identity,
                style: Theme.of(context).textTheme.headline5,
              ),
              centerTitle: true,
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: kMediumPadding,
                vertical: kSmallPadding,
              ),
              sliver: SliverToBoxAdapter(
                child: IdCard(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kMediumPadding,
                  vertical: kSmallPadding,
                ),
                child: RepositoryProvider(
                  create: (context) => UpdatePersonalDataRepo(),
                  child: BlocProvider<UpdatePersonalBloc>(
                    create: (context) => UpdatePersonalBloc(
                      sessionBloc: context.read<SessionBloc>(),
                      repo: context.read<UpdatePersonalDataRepo>(),
                      id: sessionState.identity!.doc.id,
                      firstName: sessionState
                          .personalDataVc!.credentialSubject.firstName,
                      lastName: sessionState
                          .personalDataVc!.credentialSubject.lastName,
                      email:
                          sessionState.personalDataVc!.credentialSubject.email,
                      phoneNumber: sessionState
                          .personalDataVc!.credentialSubject.phoneNumber,
                      dateOfBirth: sessionState
                          .personalDataVc!.credentialSubject.dateOfBirth,
                      sex: sessionState.personalDataVc!.credentialSubject.sex,
                      address: sessionState
                          .personalDataVc!.credentialSubject.address.street,
                      city: sessionState
                          .personalDataVc!.credentialSubject.address.city,
                      locationState: sessionState
                          .personalDataVc!.credentialSubject.address.state,
                      postalCode: sessionState
                          .personalDataVc!.credentialSubject.address.postalCode,
                      country: sessionState
                          .personalDataVc!.credentialSubject.address.country,
                    ),
                    child: CredentialDetailsView(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
