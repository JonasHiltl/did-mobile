import 'package:did/models/did/identity.dart';
import 'package:did/models/personal_data_vc/personal_data_vc.dart';

class DidVcCombination {
  final Identity identity;
  final PersonalDataVc personalDataVc;

  DidVcCombination({required this.identity, required this.personalDataVc});
}
