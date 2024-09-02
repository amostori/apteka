import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Medicine extends Equatable {
  final String uid;
  final String name;
  final String ambulance;
  final int quantity;
  final bool isDrug;
  final DateTime? createdAt;
  @override
  // TODO: implement props
  List<Object?> get props =>
      [uid, name, ambulance, quantity, isDrug, createdAt];

  const Medicine({
    required this.uid,
    required this.name,
    required this.ambulance,
    required this.quantity,
    required this.isDrug,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'ambulance': ambulance,
      'quantity': quantity,
      'isDrug': isDrug,
      if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
    };
  }

  factory Medicine.fromMap(Map<String, dynamic> map) {
    final createdAt = map['createdAt'];
    return Medicine(
      uid: map['uid'] as String,
      name: map['name'] as String,
      ambulance: map['ambulance'] as String,
      quantity: map['quantity'] as int,
      isDrug: map['isDrug'] as bool,
      createdAt: createdAt != null ? (createdAt as Timestamp).toDate() : null,
    );
  }
}
