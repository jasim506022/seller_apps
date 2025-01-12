import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Enum declared at the top level
enum ProductAction { delete, edit }

class AppConstants {
  // Global Variables
  static double previousEarning = 0.0;
  static int? isViewed;

  // Shared Preferences
  static SharedPreferences? sharedPreference;

  // Default Height Space
  static final double defaultHeightSpace = 10.h;

  // Categories
  static const categories = [
    "Fruits",
    "Vegetables",
    "Dairy & Egg",
    "Dry & Canned",
    "Drinks",
    "Meat & Fish",
    "Candy & Chocolate"
  ];

// If "All" is needed:
  static const allCategories = ["All", ...categories];

// Order Status
  static const List<String> orderStatuses = ["normal", "handover"];

  // Units
  static const units = ["Per Kg", "Per Dozen", "Litter", "Pc", "Pcs"];
}



/*
1. SharedPreferences initialization should be done in a lifecycle method, with null safety checks and async handling.
2.
Use const for immutable values, improving performance and reducing memory overhead.
Modularized constants make the codebase more navigable and reusable.
3.
Use Static Members for Shared Access
To prevent unnecessary instantiations, make constants and variables static. This ensures that you can access 
them directly via the class name without creating an instance.

*/
