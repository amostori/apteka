import 'package:apteka/src/utils/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/ambulance_model.dart';

class HiveFunctions {
  static final ambulanceBox = Hive.box<Ambulance>(BoxName.ambulanceBoxName);
  void setAmbulanceId(String id) {
    ambulanceBox.put('ambu', Ambulance(ambulanceId: id));
  }

  String? getAmbulanceId() {
    if (ambulanceBox.isNotEmpty) {
      return ambulanceBox.get('ambu')?.ambulanceId;
    } else {
      return '112';
    }
  }
}

final hiveProvider = Provider<HiveFunctions>((ref) {
  return HiveFunctions();
});
