import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/providers.dart';
import '../../../utils/routing/routing.dart';
import '../../home/data/medicine.dart';
import '../../home/hive_functions/ambulance_provider.dart';
import '../../home/presentation/dismiss_me.dart';
import '../../home/repository/firestore_repository.dart';

class AdminHomeScreen extends ConsumerWidget {
  AdminHomeScreen({super.key});
  int profileCounter = 0;
  void goToProfile(BuildContext context) {
    context.goNamed(AppRoute.profile.name);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final karetka = ref.watch(ambulanceProvider).ambulanceId;
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Apteka'), actions: [
        IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.person),
          ),
          onPressed: () {
            print(ref.read(firebaseAuthProvider).currentUser?.email);

            profileCounter = ++profileCounter;
            if (profileCounter == 5) {
              goToProfile(context);
            }
          },
        ),
        IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.add),
          ),
          onPressed: () {
            context.goNamed(AppRoute.adding.name);
            // final user = ref.read(firebaseAuthProvider).currentUser;
            // ref
            //     .read(firestoreRepositoryProvider)
            //     .addMedicine(user!.uid, 'Noradrenalina', '', 0, false);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: PopupMenuButton(
              child: Text(karetka == '' ? 'karetka' : karetka),
              onSelected: (value) {
                ref.read(ambulanceProvider.notifier).setAmbulanceId(value);
              },
              itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: '112',
                      child: Text('112'),
                    ),
                    const PopupMenuItem(
                      value: '114',
                      child: Text('114'),
                    ),
                    const PopupMenuItem(
                      value: '116',
                      child: Text('116'),
                    ),
                    const PopupMenuItem(
                      value: '118',
                      child: Text('118'),
                    ),
                    const PopupMenuItem(
                      value: '142',
                      child: Text('142'),
                    ),
                  ]),
        )
      ]),
      body: const MedicineListView(),
      floatingActionButton: FloatingActionButton(
        child: const Text('Zeruj'),
        onPressed: () {
          _showAlertDialog(context, ref, firestoreRepository);
          // final user = ref.read(firebaseAuthProvider).currentUser;
          // final ambulance = ref.read(ambulanceProvider).ambulanceId;
          // const quantity = 0;
          // // ref
          // //     .read(firestoreRepositoryProvider)
          // //     .addMedicine(user!.uid, 'Morfina', ambulance!, quantity, false);
          // for (final medicineName in MedicineList.medicinesList) {
          //   ref.read(firestoreRepositoryProvider).addMedicine(
          //       user!.uid, medicineName, ambulance, quantity, false);
          // }
        },
      ),
    );
  }

  Future<void> _showAlertDialog(BuildContext context, WidgetRef ref,
      FirestoreRepository firestoreRepository) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(AppStrings.deleteAll),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppStrings.deleteAll),
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
                final QuerySnapshot<Medicine> medicinesQuery =
                    await firestoreRepository.medicinesQuery().get();

                for (final medicineName in medicinesQuery.docs) {
                  ref
                      .read(firestoreRepositoryProvider)
                      .updateMedicine(user!.uid, medicineName.id, '', 0);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class MedicineListView extends ConsumerWidget {
  const MedicineListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DismissMe();
  }
}
