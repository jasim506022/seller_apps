class AppStrings {
/*
   🏠 General App Strings
  */
  static const String appName = "JasiVendor";
  static const String welcome = "Welcome";
  static const String okay = "Okay";
  static const String about = "About";
  static const String permissionDenied = "Permission denied for notifications.";
  static const String fcmTokenError = "Error retrieving FCM token:";

// 📌 App Titles And Bottom Bar
  static const String homeTitle = "Home";
  static const String productsTitle = "Products";
  static const String searchTitle = "Search";
  static const String profileTitle = "Profile";
  static const addNewProductTitle = "Add New Product";
  static const updateProductTitle = "Update Product";

  static const String defaultName = "Name Not Found";
  static const String defaultEmail = "email@example.com";
  static const String defaultImage =
      "https://www.example.com/default-profile.png";

/*
  * 🔐 Authentication & User Account
  */
  static const String sellerLogIn = "Welcome, Admin!";
  static const String signIn = "Sign In";
  static const String signUp = "Sign Up";
  static const String createAccount = "Create Account";
  static const String alreadyHaveAccount = "Already have an account?";
  static const String dontHaveAccount = "Don't have an account?";
  static const String forgetPassword = "Forgot Password?";
  static const String enterEmailAddress = 'Please enter your email address';
  static const String validEmailAddress = 'Please enter a valid email address';
  static const String enterPassword = 'Please enter your password';
  static const String validPassword =
      'Password must be at least 6 characters long';
  static const String enterConfirmPassword =
      'Please enter your confirm password';
  static const String passwordMatch = "Passwords do not match.";
  static const String successfullySignedOut = "Successfully signed out.";

  /*
  * 📸 Image Selection
  */

  static const String noImageSelected = "No Image Selected";

  static const String pleaseSelectPhoto = "Please Select a Photo";

/*
  * 📞 Contact Information
  */

  static const String phone = "Phone";
  static const String enterPhone = 'Please enter your phone number';
  static const String validPhoneNumber = 'Please enter a valid phone number';
  static const String address = "Address";
  static const String pleaseEnterAddress = "Please enter your Address";

/*
  * 🛒 Product Management
  */

  static const String allProducts = "All Products";
  static const String totalSales = "Total Sales";
  static const String runningOrders = "Running Orders";

  /*
  * 📦 Orders & Delivery
  */

  // 📌 Dialog title & Messages
  static const String exitDialogTitle = "Exit Application";
  static const String selectPhotoTitle = "Select Photo";
  static const String takePhotoCameraTitle = "Take a Photo";
  static const String chooseFromGalleryTitle = "Choose from Gallery";
  static const String saveChangesTitle = "Save Changes?";
  static const String areYouWantDeleteTitle = "Do you want to delete?";

  static const String confirmExitMessage = "Are you sure  want to exit?";
  static const String saveMessage = "Do you want to save your changes?";
  static const String deleteMessage =
      "Do you want to delete the product? If you delete the product, it cannot be undone.";

  // 📌 Button Labels
  static const String btnYes = "Yes";
  static const String btnNo = "No";
  static const String btnaddProductImage = "Add Product Image";
  static const String btnCancel = "Cancel";
  static const String btnPickImage = "Pick Image";
  static const String btnUpdate = "Update";
  static const String btnDelete = "Delete";
  static const String btnReset = "Reset";
  static const String btnClose = "Close";
  static const String btnSave = 'Save';

  // 📌 Success & Toast Messages
  static const String toastWaitForUploadMessage =
      "Please wait until upload completes.";

  // 📌 Form Field Labels
  static const productNameLabel = 'Product Name';
  static const String priceLabel = 'Price';
  static const String discountLabel = 'Discount';
  static const String ratingLabel = 'Rating';
  static const String descriptionLabel = 'Description';

  // 📌 Hint Texts (For Input Fields)
  static const String productNameHint = "Enter product name (e.g., Nike Shoes)";
  static const String productPriceHint = "Enter price (e.g., 99.99)";
  static const String productDiscountHint = "Enter discount (e.g., 10 for 10%)";
  static const String productRatingHint = "Enter rating (1 to 5)";
  static const String productDescriptionHint =
      "Write a short product description...";

  // 📌 Validation Messages
  static const String emptyProductName = "Please enter a product name.";
  static const String productNameTooShort =
      "Product name must be at least 3 characters long.";
  static const String productNameTooLong =
      "Product name cannot exceed 100 characters.";
  static const String productNameInvalid =
      "Product name can only contain letters, numbers, and spaces.";
  static const String emptyPrice = "Please enter a product price.";
  static const String invalidPrice =
      "Invalid price! Please enter a valid numeric value.";
  static const String priceOutOfRange =
      "Price must be between 0.01 and 1,000,000.";
  static const String invalidPriceFormat =
      "Please enter a valid price with up to two decimal places.";
  static const String emptyRating = "Please enter a rating before submitting.";
  static const String invalidRating =
      "Invalid rating! Please enter a numeric value between 1 and 5.";
  static const String ratingOutOfRange = "Rating must be between 1 and 5.";
  static const String emptyDiscount = "Please enter a discount value.";
  static const String invalidDiscount =
      "Invalid discount! Please enter a valid numeric value.";
  static const String discountNegative = "Discount cannot be negative.";
  static const String discountTooHigh =
      "Discount cannot be greater than the product price.";
  static const String discountOverLimit = "Discount cannot exceed 100%.";
  static const String invalidDiscountFormat =
      "Please enter a valid discount with up to two decimal places.";
  static const String emptyDescription = "Please enter a product description.";
  static const String descriptionTooShort =
      "Product description must be at least 10 characters long.";
  static const String descriptionTooLong =
      "Product description cannot exceed 1000 characters.";

  static String doYouwantSignout = "Do you want to sign out?";

  static String selectPhoto = "Select Photo";
  static String camera = "Camera";
  static String gallery = "Gallery";

  // Auth Page
  static String logInPageSubjectTitle =
      'Check our fresh viggies from Jasim Grocery';

  static String withOr = "with Or";
  static String facebook = "Facebook";
  static String gmail = "Gmail";

// TextField Label Text
  static String email = "Email";
  static String password = "Password";

  static String name = "Name";
  static String orderDate = "or.Date";
  static String minium = "Minimum";
  static String maximum = "Maximum";

  // Textfleid String
  static String emailAddress = "Email Address";

  static String yourName = 'Your Name';
  static String enterName = 'Please enter your name';
  static String nameValid = 'Name must be longer than 2 characters';

  static String validConfirmPassword =
      'Confirm Password Must be geather then 6 Characteris';
  static String passwordConfirm = "Confirm Password";

  static String phoneNumber = "Phone Number";

  static String sendingMail = "Sending a mail. Please Check ur Email";

  //
  static String signInSuccessfully = "Sign in Successfully";

  static String adminRegistration = "Admin Registration";

  static String signupSuccessfull = "Sign up Successfully";

  static String entreEmailAddressForResetPassword =
      "Please Enter your mail address to reset you password";
  static String resetPassword = "Reset Password";
  static String youdontWantToReset = "If you don't want to reset Password? ";
  static String loginWithGmailTitle =
      "Loading for sign with Gmail \n Pleasing Waiting........";

//
  static String approved = "approved";
  static String uidSharedPreference = "uid";
  static String emailSharedPreference = "email";
  static String nameSharedPreference = "name";
  static String imageurlSharedPreference = "imageurl";
  static String phoneSharedPreference = "phone";
  static String earningSharedPreference = "earning";

  //

  // sharepare
  static String onBoardingShareKey = 'onBoarding';

  static String skip = "Skip";

  static String fresshFruis = "Fresh Fruits & Vegetables";
  static String quickDelivery = "Quick & Fast Delivery";
  static String firstOnboardingDescription =
      "Welcome to best online grocery store. Here you will find all the groceries at one place.";
  static String secondOnboardingDescription =
      "Buy farm fresh fruits & vegetables online at the best & affordable prices.";
  static String thirdOnboardingDescription =
      "We offers speedy delivery of your groceries, bathroom supplies, baby care products, pet care items, stationary, etc within 30minutes at your doorstep.";

  static String givemPhoneNumbeer = "Please Give your Phone Numer";
  static String pleaseWait = "Pleasing Waiting........";
  static String profileUpdate = "Profile Update";
  static String successfullyUpdate = "Profile updated successfully";

  static String historyPage = "History Page";

  static String addresNoteFound = "Address Not Found";

  static String complete = "complete";
  static String orderComplete = "Order Complete";

  static String order = "Order";

  static String searchProductHere = "Search Product Here";

  static String myOrder = 'My Orders';
  static String off = "Off";

  // Firebase
  static const sellersCollection = "seller";
  static const productsCollection = "products";

  //Error
  static String errorOccurred = "Error Occurred:";

  // Main Page

  // App Bar and Title
  static const String editProfile = "Edit Profile";
  static const String signOut = "Sign Out";

  static const String orderPage = "Order Page";
  static String orderOverview = "Order Overview";
  static String estimatedDelivery = "Estimated Delivery Date is";
  static String orderBreakdown = "Order Breakdown";
  static String deliveryAddress = "Delivery Address";
  static String completeOrder = "Complete Order";
  static String deliveryPartner = "Delivery Partner";
  static String trackingNumber = "Tracking Number";
  static String searchProducts = "Search Products";
  static String productPrice = 'Product Price';
  static String productCategory = 'Product Category';
  static const similarProducts = "Similar Products";

  // Heading
  static String userDetails = "User Details";
  static String filterSearch = "Filter Search";

  // argument;
  static const isUpdate = "isUpdate";
  static const productModel = "productModel";

  // Title

  //add Product

  // dialog

  // Toast
  static const imageUploadFail = "Image upload failed. Please try again.";
  static const selectOneImage = "Please Select at least One Image";
  static const updateProductToastMessage = "Succesfully update a New Product";
  static const uploadProductToastMessage = "Succesfully Upload a New Product";

  static const deleteSuccessFully = "Delete Succesffully";
  static const userDoesntExit = "User Doesn't Exit";

  static const noInternet = 'No Internet';
  static const noInternetMessage =
      'Please check your internet settings and try again.';

  //
  static const available = "available";
  // Firebase Message
  static const errorOccure = 'Error Occure';
  static String noDataAvaiable = "No Data Available";

  //
  static const currencyIcon = "৳.";

  // static const signOut = "Sign Out";

  // Order Status
  static const sendProductAdmin = "Please send your products to the admin";
  static const handoverProduct = "Handover the product to the admin";
  static const deliveryProduct = "Product ready for delivery";
  static const orderSuccesfullyCompleted =
      "The order has been successfully completed";

  //botton
  static const next = "Next";

  static String dark = "Dark";
  static String light = "Light";
  static const String pleaseEnterPrefix = "Please enter";
  static const homePage = "Home Page";

  static const pleaseEnterProduct = 'Please Enter Product';

  static String minumeAndMaximum = 'Minimum price cannot exceed maximum price.';

  // 📌 Helper Functions for Dynamic Messages
  static String pleaseEnterField(String fieldName) {
    return "Please enter $fieldName.";
  }

  static const String goBack = "Go Back";
  //
  static const String noImageSelect = "No images selected";

  // Hint
  static const String searchPlaceholder = "Search...........";
  // Product
  static const String uploadProduct = "Upload Your Product";
}
