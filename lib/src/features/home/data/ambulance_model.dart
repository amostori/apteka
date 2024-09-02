import 'package:hive/hive.dart';
part 'ambulance_model.g.dart';

@HiveType(typeId: 1)
class Ambulance {
  @HiveField(0)
  String ambulanceId;

  Ambulance({
    required this.ambulanceId,
  });

  Ambulance copyWith({
    String? ambulanceId,
  }) {
    return Ambulance(
      ambulanceId: ambulanceId ?? this.ambulanceId,
    );
  }
}
