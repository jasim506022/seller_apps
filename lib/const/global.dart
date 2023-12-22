import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreference;

List<String> allCategoryList = <String>[
  "All",
  'Fruits',
  'Vegetables',
  'Dairy & Egg',
  'Dry & Canned',
  "Drinks",
  "Meat & Fish",
  "Candy & Chocolate"
];

List<String> category = <String>[
  'Fruits',
  'Vegetables',
  'Dairy & Egg',
  'Dry & Canned',
  "Drinks",
  "Meat & Fish",
  "Candy & Chocolate",
];

enum ProductSelect { detele, edit }

const List<String> unitList = <String>[
  'Per Kg',
  'Per Dozen',
  'Litter',
  'Pc',
  'Pcs',
];
