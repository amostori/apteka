import 'package:apteka/src/features/home/presentation/not_dismiss_me.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/providers.dart';
import '../../../utils/routing/routing.dart';
import '../data/medicine.dart';
import '../hive_functions/ambulance_provider.dart';
import '../repository/firestore_repository.dart';
import 'dismiss_me.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  int profileCounter = 0;
  void goToProfile(BuildContext context) {
    context.goNamed(AppRoute.profile.name);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final karetka = ref.watch(ambulanceProvider).ambulanceId;

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
    );
  }
}

class MedicineListView extends ConsumerWidget {
  const MedicineListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const NotDismissMe();
  }
}
