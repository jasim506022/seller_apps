class AppStrings {
/*
   🏠 General App Strings
  */
  static const String appName = "JasiVendor";
  // static const String welcome = "Welcome";

  static const String permissionDenied = "Permission denied for notifications.";
  static const String fcmTokenError = "Error retrieving FCM token:";
  static const String noImageSelect = "No images selected";

  // 📌 Onboarding Titles & Descriptions
  static const String onboardingTitle1 = "Welcome to Grocery App";
  static const String onboardingDescription1 =
      "Welcome to best online grocery store. Here you will find all the groceries at one place.";
  static const String onboardingTitle2 = "Farm Fresh Produce";
  static const String onboardingDescription2 =
      "Buy farm fresh fruits & vegetables online at the best & affordable prices.";
  static const String onboardingTitle3 = "Fast Delivery";
  static const String onboardingDescription3 =
      "We offers speedy delivery of your groceries, bathroom supplies, baby care products, pet care items, stationary, etc within 30minutes at your doorstep.";

// 📌 App Titles And Bottom Bar
  static const String homeTitle = "Home";
  static const String productsTitle = "Products";
  static const String searchTitle = "Search";
  static const String profileTitle = "Profile";
  static const addNewProductTitle = "Add New Product";
  static const updateProductTitle = "Update Product";
  static const String allProductsTitle = "All Products";
  static const String totalSalesTitle = "Total Sales";
  static const String runningOrdersTitle = "Running Orders";
  static const similarProductTitle = "Similar Products";
  static const String aboutTitle = "About";
  static const String orderTitle = 'My Orders';
  static const String historyTitle = "History";

  // 📌 Authentication Titles & Messages
  static const String sellerLogInTitle = "JasiVendor Login";
  static const String signInTitle = "Sign In";
  static const String signUpTitle = "Sign Up";
  static String resetPasswordTitle = "Reset Password";
  static const String authPageDescription =
      "Check our fresh veggies from Jasim Grocery";
  static const String forgetPasswordTitle = "Forgot Password?";
  static String withOr = "with Or";
  static String forgetPasswordDescription =
      "Please Enter your mail address to reset you password";
  static String sellerRegistration = "JasiVender Registration";
  static const String createAccount = "Create Account";
  static const String alreadyHaveAccount = "Already have an account?";
  static const String dontHaveAccount = "Don't have an account?";
  static String youdontWantToReset = "If you don't want to reset Password? ";
  static const String passwordMatch = "Passwords do not match.";

  /*
  * 📸 Image Selection
  */

  static const String noImageSelected = "No Image Selected";

/*
  * 📞 Contact Information
  */

  static const String enterPhone = 'Please enter your phone number';

  static const String pleaseEnterAddress = "Please enter your Address";

/*
  * 🛒 Product Management
  */

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
  static const String btnAddProductImage = "Add Product Image";
  static const String btnCancel = "Cancel";
  static const String btnPickImage = "Pick Image";
  static const String btnUpdate = "Update";
  static const String btnDelete = "Delete";
  static const String btnReset = "Reset";
  static const String btnClose = "Close";
  static const String btnSave = 'Save';
  static const String btnSkip = "Skip";
  static const String btnNext = "Next";
  static const String btnFacebook = "Facebook";
  static const String btnGmail = "Gmail";
  static const String btnOkay = "Okay";
  static const String btnEditProfile = "Edit Profile";
  static const String btnCamera = "Camera";
  static const String btnGallery = "Gallery";

  // 📌 Success & Toast Messages
  static const String successSignUpMessage = "Sign up successful!";
  static const String successSignInMessage = "Sign in successful!";
  static const String errorUserNotFoundToast = "User not found.";
  static const String toastWaitForUploadMessage =
      "Please wait until upload completes.";
  static const String loginProcessOngoingToast =
      "Login process is in progress. Please wait...";
  static const String processOngoingToast = "Please wait.   progressing.";
  static const String pleaseSelectPhotoToast = "Please Select a Photo";
  static const String validPhoneNumberToast =
      'Please enter a valid phone number';
  static const String imageUploadFailToast =
      "Image upload failed. Please try again.";
  static const String selectOneImageToast = "Please Select at least One Image";
  static const updateProductToastMessage = "Succesfully update a New Product";
  static const uploadProductToastMessage = "Succesfully Upload a New Product";
  static const String minPriceExceedsMaxToast =
      'Minimum price cannot exceed maximum price.';
  static const String deleteSuccessToast = "Delete Succesffully";
  static String phoneNumberPromptToast = "Please Give your Phone Numer";
  static String profileUploadToast = "Profile Upload Successfully";
  static String profileUpdateToast = "Profile Updated Successfully.";
  static const String successfullySignedOutToast = "Successfully signed out.";

  // 📌 Form Field Labels
  static const productNameLabel = 'Product Name';
  static const String priceLabel = 'Price';
  static const String discountLabel = 'Discount';
  static const String ratingLabel = 'Rating';
  static const String descriptionLabel = 'Description';
  static const String emailLabel = "Email";
  static const String passwordLabel = "Password";
  static const String nameLabel = "Name";
  static const String passwordConfirmLabel = "Confirm Password";
  static const String phoneLabel = "Phone";
  static String darkLabel = "Dark";
  static String lightLabel = "Light";
  static const String signOutLabel = "Sign Out";
  static const String addressLabel = "Address";

  // 📌 Hint Texts (For Input Fields)
  static const String productNameHint = "Enter product name (e.g., Nike Shoes)";
  static const String productPriceHint = "Enter price (e.g., 99.99)";
  static const String productDiscountHint = "Enter discount (e.g., 10 for 10%)";
  static const String productRatingHint = "Enter rating (1 to 5)";
  static const String productDescriptionHint =
      "Write a short product description...";
  static const String emailHint = "Enter your email address";
  static const String passwordHint = "Enter your password";
  static const String confirmPasswordHint = "Re-enter your password";
  static const String nameHint = "Enter your full name";
  static const String addressHint = "Enter your address (Street, City, ZIP)";
  static const String phoneHint = "Phone Number";
  static const String searchHint = "Search...........";

  // 📌 Validation Messages
  // Product
  static const String emptyProductName = "Please enter a product name.";
  static const String productNameTooShort =
      "Product name must be at least 3 characters long.";
  static const String productNameTooLong =
      "Product name cannot exceed 100 characters.";
  static const String productNameInvalid =
      "Product name can only contain letters, numbers, and spaces.";
// Price
  static const String emptyPrice = "Please enter a product price.";
  static const String invalidPrice =
      "Invalid price! Please enter a valid numeric value.";
  static const String priceOutOfRange =
      "Price must be between 0.01 and 1,000,000.";
  static const String invalidPriceFormat =
      "Please enter a valid price with up to two decimal places.";
  // Ratting
  static const String emptyRating = "Please enter a rating before submitting.";
  static const String invalidRating =
      "Invalid rating! Please enter a numeric value between 1 and 5.";
  static const String ratingOutOfRange = "Rating must be between 1 and 5.";
  // Discount
  static const String emptyDiscount = "Please enter a discount value.";
  static const String invalidDiscount =
      "Invalid discount! Please enter a valid numeric value.";
  static const String discountNegative = "Discount cannot be negative.";
  static const String discountTooHigh =
      "Discount cannot be greater than the product price.";
  static const String discountOverLimit = "Discount cannot exceed 100%.";
  static const String invalidDiscountFormat =
      "Please enter a valid discount with up to two decimal places.";
  //Description
  static const String emptyDescription = "Please enter a product description.";
  static const String descriptionTooShort =
      "Product description must be at least 10 characters long.";
  static const String descriptionTooLong =
      "Product description cannot exceed 1000 characters.";
  // Email
  static const String emptyEmail = "Please enter your email address.";
  static const String invalidEmailFormat =
      "Invalid email format! Please enter a valid email.";
  static const String emailTooLong =
      "Email address is too long. Please enter a valid email.";
  // Password
  static const String emptyPassword = "Please enter your password.";
  static const String passwordTooShort =
      "Password must be at least 6 characters long.";
  static const String passwordTooLong = "Password cannot exceed 20 characters.";
  static const String passwordUppercase =
      "Password must contain at least one uppercase letter.";
  static const String passwordLowercase =
      "Password must contain at least one lowercase letter.";
  static const String passwordNumber =
      "Password must contain at least one number.";
  // Confirm Password
  static const String confirmPasswordRequired = "Please confirm your password.";
  static const String passwordMismatch =
      "Passwords do not match. Please re-enter.";
  // Name
  static const String emptyName = "Please enter your name.";
  static const String nameTooShort = "Name must be at least 2 characters long.";
  static const String nameTooLong = "Name cannot exceed 50 characters.";
  static const String nameInvalid = "Name can only contain letters and spaces.";
  // Address
  static const String emptyAddress = "Please enter your address.";
  static const String addressTooShort =
      "Address must be at least 5 characters long.";
  static const String addressTooLong = "Address cannot exceed 200 characters.";

  static String doYouwantSignout = "Do you want to sign out?";

  // 📌 Firebase Collections & Shared Preferences Keys
  static const String collectionUsers = "users";
  static const String collectionProducts = "products";
  static const String collectionOrders = "orders";
  static const String collectionSeller = "seller";
  static const String tokenFirebaseField = "token";
  static const String prefUserId = "uid";
  static const String prefUserEmail = "email";
  static const String prefUserName = "name";
  static const String prefUserPhone = "phone";
  static const String prefUserProfilePic = "imageurl";
  static const String prefUserEarnings = "earning";
  static const String prefOnboarding = 'onBoarding';

  static String approved = "approved";

  // Defauld Value:
  static const String defaultName = "Name Not Found";
  static const String defaultEmail = "email@example.com";
  static const String defaultPhone = "No phone number";
  static const String defaultImage =
      "https://www.example.com/default-profile.png";

// TextField Label Text

  static String orderDate = "or.Date";
  static String minium = "Minimum";
  static String maximum = "Maximum";

  // Textfleid String

  static String yourName = 'Your Name';
  static String enterName = 'Please enter your name';
  static String nameValid = 'Name must be longer than 2 characters';

  static String validConfirmPassword =
      'Confirm Password Must be geather then 6 Characteris';

  static String sendingMail = "Sending a mail. Please Check ur Email";

  //

  static String signupSuccessfull = "Sign up Successfully";

  static String loginWithGmailTitle =
      "Loading for sign with Gmail \n Pleasing Waiting........";

//

  //

  // sharepare

  static String pleaseWait = "Pleasing Waiting........";

  static String addresNoteFound = "Address Not Found";

  static String complete = "complete";
  static String orderComplete = "Order Complete";

  static String order = "Order";

  static String searchProductHere = "Search Product Here";

  static String off = "Off";

  // Firebase

  static const productsCollection = "products";

  //Error
  static String errorOccurred = "Error Occurred:";

  // Main Page

  // App Bar and Title

  static const String orderPage = "Order Page";
  static String orderOverview = "Order Overview";
  static String estimatedDelivery = "Estimated Delivery Date is";
  static String orderBreakdown = "Order Breakdown";
  static String deliveryAddress = "Delivery Address";
  static String completeOrder = "Complete Order";
  static String deliveryPartner = "Delivery Partner";
  static String trackingNumber = "Tracking Number";

  static String productPrice = 'Product Price';
  static String productCategory = 'Product Category';

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

  static const userDoesntExit = "User Doesn't Exit";

  static const noInternet = 'No Internet';
  static const noInternetMessage =
      'Please check your internet settings and try again.';

  //
  static const available = "available";
  // Firebase Message
  static const errorOccure = 'Error Occure';

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

  static const String pleaseEnterPrefix = "Please enter";
  static const homePage = "Home Page";

  static const pleaseEnterProduct = 'Please Enter Product';

  // 📌 Helper Functions for Dynamic Messages and Others
  static String pleaseEnterField(String fieldName) {
    return "Please enter $fieldName.";
  }

  static const String selectPhoto = "Select Photo";
  static const String goBack = "Go Back";

  // 📌 Error Messages
  static const String errorGeneric = "Something went wrong. Please try again.";
  static const String errorNoInternet =
      "No internet connection. Please check your network.";
  static String noDataAvaiableError = "No Data Available";

  static const String errorUnauthorized =
      "Unauthorized access. Please sign in again.";
  static const String errorImageUpload =
      "Image upload failed. Please try again.";
  static const String errorFetchingData = "Failed to fetch data.";
  static const String errorInvalidInput = "Invalid input provided.";
  static const String errorInvalidLogin = "Invalid email or password.";
  static const String errorProductNotFound = "Product not found.";
}
