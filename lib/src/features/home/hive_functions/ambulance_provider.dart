import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/ambulance_model.dart';
import 'hive_functions.dart';

class AmbulanceProviderNotifier extends StateNotifier<Ambulance> {
  final HiveFunctions hiveFunctions;

  AmbulanceProviderNotifier({required this.hiveFunctions})
      : super(Ambulance(ambulanceId: hiveFunctions.getAmbulanceId()));

  void setAmbulanceId(String id) {
    state = state.copyWith(ambulanceId: id);
    hiveFunctions.setAmbulanceId(id);
  }
}

final ambulanceProvider =
    StateNotifierProvider<AmbulanceProviderNotifier, Ambulance>((ref) {
  final hiveFunctions = ref.watch(hiveProvider);
  return AmbulanceProviderNotifier(hiveFunctions: hiveFunctions);
});
