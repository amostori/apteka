import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/medicine.dart';

class FirestoreRepository {
  FirestoreRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> addMedicine(String uid, String name, String ambulance,
      int quantity, bool isDrug) async {
    await _firestore.collection('medicines').add({
      'uid': uid,
      'name': name,
      'quantity': quantity,
      'isDrug': isDrug,
      'ambulance': ambulance,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Query<Medicine> medicinesQuery() {
    return _firestore
        .collection('medicines')
        .withConverter(
            fromFirestore: (snapshot, _) => Medicine.fromMap(snapshot.data()!),
            toFirestore: (medicine, _) => medicine.toMap())
        .orderBy('name', descending: false);
  }

  Future<void> updateMedicine(
          String uid, String medicineId, String ambu, int quantity) =>
      _firestore.doc('medicines/$medicineId').update({
        'uid': uid,
        'quantity': quantity,
        'ambulance': ambu,
        'createdAt': FieldValue.serverTimestamp(),
      });

  Future<void> deleteMedicine(String uid, String medicineId) =>
      _firestore.doc('medicines/$medicineId').delete();
}

final firestoreRepositoryProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository(FirebaseFirestore.instance);
});
