import 'package:apteka/src/features/home/presentation/not_dismiss_me.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/providers.dart';
import '../../../utils/routing/routing.dart';
import '../../home/data/medicine.dart';
import '../../home/hive_functions/ambulance_provider.dart';
import '../../home/repository/firestore_repository.dart';

class AdminHomeScreen extends ConsumerWidget {
  AdminHomeScreen({super.key});
  final _advancedDrawerController = AdvancedDrawerController();
  int profileCounter = 0;
  void goToProfile(BuildContext context) {
    context.goNamed(AppRoute.profile.name);
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final karetka = ref.watch(ambulanceProvider).ambulanceId;
    final firestoreRepository = ref.watch(firestoreRepositoryProvider);

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueGrey,
              Colors.blueGrey.withOpacity(0.2),
            ],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/crop2.png',
                  ),
                ),
                ListTile(
                  onTap: () {
                    context.goNamed(AppRoute.adding.name);
                  },
                  leading: const Icon(Icons.add),
                  title: const Text('Dodaj lek'),
                ),
                ListTile(
                  onTap: () {
                    _showAlertDialog(context, ref, firestoreRepository);
                  },
                  leading: const Icon(Icons.lock_reset_outlined),
                  title: const Text('Zeruj'),
                ),
                ListTile(
                  onTap: () {
                    profileCounter = ++profileCounter;
                    if (profileCounter == 5) {
                      goToProfile(context);
                    }
                  },
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: const Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: [
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
            ),
          ],
          title: const Text('Apteka'),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: const MedicineListView(),
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
    return const NotDismissMe();
  }
}
