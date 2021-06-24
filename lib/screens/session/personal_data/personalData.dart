import 'package:did/providers/app_screen_state/session_flow/session_cubit.dart';
import 'package:did/providers/app_screen_state/session_flow/session_state.dart';
import 'package:did/providers/update_personal_data/repository/update_personal_data_repo.dart';
import 'package:did/providers/update_personal_data/update_personal_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import 'components/credential_details_view.dart';

class PersonalData extends StatefulWidget {
  @override
  _PersonalDataState createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  @override
  Widget build(BuildContext context) {
    final credential =
        context.watch<Verified>().personalDataVc.credentialSubject;
    final identity = context.watch<Verified>().identity;
    final sessionState = context.watch<Verified>();
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          elevation: 0.0,
          // if floating is true the appbar becomes instantly visible if scrolled towards top
          // if it's false the appbar is only visible if completly scrolled back to top
          floating: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            L.of(context).personalData,
            style: Theme.of(context).textTheme.headline5,
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: RepositoryProvider(
              create: (context) => UpdatePersonalDataRepo(),
              child: BlocProvider<UpdatePersonalBloc>(
                create: (context) => UpdatePersonalBloc(
                  repo: context.read<UpdatePersonalDataRepo>(),
                  sessionCubit: context.read<SessionCubit>(),
                  sessionState: sessionState,
                  id: identity.doc.id,
                  firstName: credential.firstName,
                  lastName: credential.lastName,
                  email: credential.email,
                  phoneNumber: credential.phoneNumber,
                  dateOfBirth: credential.dateOfBirth,
                  sex: credential.sex,
                  address: credential.address.street,
                  city: credential.address.city,
                  locationState: credential.address.state,
                  postalCode: credential.address.postalCode,
                  country: credential.address.country,
                ),
                child: CredentialDetailsView(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
