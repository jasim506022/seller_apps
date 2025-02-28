import 'package:shared_preferences/shared_preferences.dart';

/// Enum representing product actions (delete, edit).
enum ProductAction { delete, update }

/// A class that holds globally used constants throughout the app.
class AppConstants {
  /// Previous earning amount (default: 0.0).
  static double previousEarning = 0.0;

  /// A flag to track if a specific action/view has been completed.
  static int isViewed = 0;

  /// SharedPreferences instance (  initialized in main)
  static SharedPreferences? sharedPreference;

// ─────────────────────────────────────────────────────────────
  /// Predefined product categories.
  static const categories = [
    "Fruits",
    "Vegetables",
    "Dairy & Egg",
    "Dry & Canned",
    "Drinks",
    "Meat & Fish",
    "Candy & Chocolate"
  ];

  /// List of all categories, including an "All" option.
  static const allCategories = ["All", ...categories];

// ─────────────────────────────────────────────────────────────

  /// Order status types.
  static const List<String> orderStatuses = ["normal", "handover"];

  /// Measurement units for products.
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
4. Understand  static const allCategories = ["All", ...categories];

*/
