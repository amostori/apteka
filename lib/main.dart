import 'package:apteka/src/features/home/data/ambulance_model.dart';
import 'package:apteka/src/utils/constants/constants.dart';
import 'package:apteka/src/utils/routing/routing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// flutter build apk --split-per-abi
// open ios/Runner.xcworkspace
// Theme.of(context).accentColor
// flutter build appbundle
// flutter build ipa
// Pełny ekran dla pola edycji: ctrl+shift+F12
// F2 lub SHIFT+F2 służy do przeskakiwania od błędu do błędu.
// Zamknięcie aktualnie otworzonego pliku: ctrl+F4
// Uruchom terminal: ALT+F12
// µ Ś  Ł
// ctrl + shift + alt + j - zaznacz wszystkie podobne
// ctrl + alt + o - optymalizacja importów
// ctrl + shift + f - szukaj wszędzie
// _total.toStringAsFixed(1)
// multi cursor: press and hold 'option'
// W przypadku błędu przy validate app może pomóc aktualizacja flutter,
// rozwiązanie żółtego ostrzeżenia w  xcode
// option+delete to delete entire word behind cursor (terminal)
// dart run build_runner build

// Komenda ładująca wszystkie pakiety:
// flutter packages get

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AmbulanceAdapter());
  await Hive.openBox<Ambulance>(BoxName.ambulanceBoxName);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey, // background (button) color
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ), // foreground (text) color
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo, // background (button) color
          foregroundColor: Colors.white, // foreground (text) color
        ),
      ),
    );
  }
}
