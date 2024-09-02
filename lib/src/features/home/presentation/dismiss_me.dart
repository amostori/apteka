import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/providers.dart';
import '../data/medicine.dart';
import '../hive_functions/ambulance_provider.dart';
import '../repository/firestore_repository.dart';

class DismissMe extends ConsumerWidget {
  const DismissMe({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);

    return FirestoreListView<Medicine>(
      errorBuilder: (context, error, stacktrace) =>
          Center(child: Text(error.toString())),
      emptyBuilder: (context) => const Center(
        child: Text('Brak danych'),
      ),
      query: firestoreRepository.medicinesQuery(),
      itemBuilder: (BuildContext context, QueryDocumentSnapshot<Medicine> doc) {
        final medicine = doc.data();
        return Dismissible(
          key: Key(doc.id),
          background: const ColoredBox(color: Colors.red),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            final user = ref.read(firebaseAuthProvider).currentUser;
            ref
                .read(firestoreRepositoryProvider)
                .deleteMedicine(user!.uid, doc.id);
          },
          child: ListTile(
            title: medicine.isDrug
                ? Text(
                    medicine.name,
                    style: const TextStyle(color: Colors.red),
                  )
                : Text(medicine.name),
            subtitle: medicine.createdAt != null
                ? Text(medicine.createdAt.toString(),
                    style: Theme.of(context).textTheme.bodySmall)
                : null,
            trailing: Text(medicine.quantity.toString()),
            leading: Text(medicine.ambulance,
                style: Theme.of(context).textTheme.bodySmall),
            onLongPress: () {
              final user = ref.read(firebaseAuthProvider).currentUser;
              int quantity = medicine.quantity;
              int quantityPlus = quantity > 0 ? quantity - 1 : quantity;
              ref.read(firestoreRepositoryProvider).updateMedicine(
                  user!.uid,
                  doc.id,
                  ref.watch(ambulanceProvider).ambulanceId,
                  quantityPlus);
            },
            onTap: () {
              final user = ref.read(firebaseAuthProvider).currentUser;
              int quantity = medicine.quantity;
              int quantityPlus = quantity + 1;
              ref.read(firestoreRepositoryProvider).updateMedicine(
                  user!.uid,
                  doc.id,
                  ref.watch(ambulanceProvider).ambulanceId,
                  quantityPlus);
            },
          ),
        );
      },
    );
  }
}
