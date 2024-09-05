import 'package:apteka/src/utils/extensions/capitalize.dart';
import 'package:apteka/src/utils/my_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validators/validators.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/providers.dart';
import '../../home/repository/firestore_repository.dart';

class AddingMedicine extends ConsumerWidget {
  AddingMedicine({super.key});
  final TextEditingController medicineController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodawanie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: AppSizes.sizedBoxHeight,
            ),
            TextField(
              controller: medicineController,
              decoration: const InputDecoration(
                  labelText: 'Nazwa leku', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 50.0,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    final user = ref.read(firebaseAuthProvider).currentUser;

                    final medicineName = medicineController.text;
                    if (medicineName.isNotEmpty) {
                      ref.read(firestoreRepositoryProvider).addMedicine(
                          user!.uid, medicineName.capitalize(), '', 0, false);
                      medicineController.text = '';
                      Navigator.pop(context);
                      MyToast.showMyToast(
                          'Dodałeś ${medicineName.capitalize()}');
                    } else {
                      MyToast.showMyToast('Nie podałeś nazwy leku');
                    }
                  },
                  child: const Text(
                    'Dodaj',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
