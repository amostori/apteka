import 'package:flutter/material.dart';

class BoxName {
  static const String ambulanceBoxName = 'ambulance';
}

class AppStrings {
  static const String deleteAll = 'Jesteś pewien, że chcesz wyzerować stany?';
  static const String deleteOne = 'Jesteś pewien, że chcesz usunąć ten lek?';
  static const String cancel = 'Anuluj';
  static const String yes = 'Tak';
  static const String no = 'Nie';
}

class MedicineList {
  static const List<String> medicinesList = [
    'Acard',
    'Adenocor',
    'Amiodaron',
    'Atropina 0,5 mg',
    'Atropina 1 mg',
    'Budesonid 0,5 mg',
    'Budesonid 1 mg',
    'Budesonid 2,5 mg',
    'Captopril',
    'Clemastin',
    'Clonazepam',
    'Klopidogrel',
    'Dexaven 4 mg',
    'Dexaven 8 mg',
    'Neorelium',
    'Relsed',
    'No - Spa',
    'Adrenalina',
    'Tranexamic Acid',
    'Fentanyl',
    'Flumazenil',
    'Furosemid',
    'Glukagon',
    'Glukoza 5%',
    'Glukoza 20%',
    'Nitromint',
    'Heparyna',
    'Hydrocortyzon',
    'Hydroxyzyna tabletki',
    'Hydroxyzyna ampułka',
    'Ibuprofen',
    'Ketonal',
    'Lidokaina szt.',
    'Lidokaina 200 mg',
    'Magnez',
    'Mannitol',
    'Pyralgina tabletki',
    'Pyralgina 1 g',
    'Pyralgina 2,5 g',
    'Metoclopramid',
    'Metocard, Betaloc ampułki',
    'Metocard, Betaloc tabletki',
    'Midanium',
    'Morfina',
    'Naloxon',
    'NaCl 10 ml',
    'NaCl 100 ml',
    'NaCl 250 ml',
    'NaCl 500 ml',
    'Natrium Bicarbonicum',
    'Noradrenalina',
    'Papaveryna',
    'Paracetamol fiolka 500 mg',
    'Paracetamol fiolka 1 g',
    'Paracetamol czop. 125 mg',
    'Paracetamol czop. 250 mg',
    'Paracetamol czop. 500 mg',
    'Optilyte 250 ml',
    'Optilyte 500 ml',
    'Salbutamol, Ventolin 2,5',
    'Salbutamol, Ventolin 5',
    'Torecan',
    'Brilique',
    'Tlen mały',
    'Tlen duży',
    'Tachyben, Ebrantil',
  ];
}

class AppFontSize {
  static const double listTileFontSize = 18.0;
}

class AppSizes {
  static const double sizedBoxHeight = 30.0;
}

class AppTextStyle {
  static const listTileFont = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: AppFontSize.listTileFontSize);
  static const listTileRedFont = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.red,
      fontSize: AppFontSize.listTileFontSize);
}
