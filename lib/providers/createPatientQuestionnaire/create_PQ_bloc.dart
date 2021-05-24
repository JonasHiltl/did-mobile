import 'package:did/models/allergy/allergy.dart';
import 'package:did/models/medication/medication.dart';
import 'package:did/providers/createPatientQuestionnaire/create_PQ_event.dart';
import 'package:did/providers/createPatientQuestionnaire/create_PQ_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePQBloc extends Bloc<CreatePQEvent, CreatePQState> {
  CreatePQBloc() : super(CreatePQState(allergies: [], medications: []));

  @override
  Stream<CreatePQState> mapEventToState(CreatePQEvent event) async* {
    if (event is CreatePQAddAllergy) {
      final newState = state.allergies.add(event.allergy) as List<Allergy>?;
      yield state.copyWith(allergies: newState);
    } else if (event is CreatePQRemoveAllergy) {
      final List<Allergy> newState = List.from(state.allergies);
      newState.removeAt(event.index);
      yield state.copyWith(allergies: newState);
    } else if (event is CreatePQAddMedication) {
      final newState =
          state.medications.add(event.medication) as List<Medication>?;
      yield state.copyWith(medications: newState);
    } else if (event is CreatePQRemoveMedication) {
      final List<Medication> newState = List.from(state.medications);
      newState.removeAt(event.index);
      yield state.copyWith(medications: newState);
    }
  }
}
