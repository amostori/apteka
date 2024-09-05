import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../../../utils/providers.dart';
import '../../home/hive_functions/ambulance_provider.dart';
import '../../home/repository/firestore_repository.dart';
import 'not_dismiss_me.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final karetka = ref.watch(ambulanceProvider).ambulanceId;
    print('karetka = $karetka');
    final firestoreAuth = ref.watch(firebaseAuthProvider);

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 128.0,
                      height: 128.0,
                      margin: const EdgeInsets.only(
                        top: 24.0,
                        bottom: 14.0,
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
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 64.0,
                      ),
                      width: double.infinity,
                      child: ListTile(
                        title: Text(
                          firestoreAuth.currentUser!.email!,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  onTap: () async {
                    await ref.read(firebaseAuthProvider).signOut();
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text('Wyloguj'),
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
                    child: const Text('created by: Marcin Andrzejczak'),
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
}

class MedicineListView extends ConsumerWidget {
  const MedicineListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const NotDismissMe();
  }
}
