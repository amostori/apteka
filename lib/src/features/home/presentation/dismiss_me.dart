import 'package:apteka/src/utils/my_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/providers.dart';
import '../data/medicine.dart';
import '../hive_functions/ambulance_provider.dart';
import '../repository/firestore_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
          confirmDismiss: (_) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(medicine.name),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(AppStrings.deleteOne),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(AppStrings.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text(AppStrings.yes),
                      onPressed: () async {
                        final user = ref.read(firebaseAuthProvider).currentUser;
                        ref
                            .read(firestoreRepositoryProvider)
                            .deleteMedicine(user!.uid, doc.id);
                        Navigator.of(context).pop();
                        MyToast.showMyToast('Usunięto ${medicine.name}');
                      },
                    ),
                  ],
                );
              },
            );
          },
          background: const ColoredBox(color: Colors.red),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {},
          child: ListTile(
            title: medicine.isDrug
                ? Text(
                    medicine.name,
                    style: AppTextStyle.listTileRedFont,
                  )
                : Text(
                    medicine.name,
                    style: AppTextStyle.listTileFont,
                  ),
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
              MyToast.showMyToast('Usunięto ${medicine.name}');
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
              MyToast.showMyToast('Dodano ${medicine.name}');
            },
          ),
        );
      },
    );
  }
}
