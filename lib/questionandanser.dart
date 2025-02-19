
/*

##########################Splash Page###########################

##########################Onboarding Page###########################
#: Question-1: 







Question:1:- What is different between single qotation and double qutation
Answer: 
In Flutter (which uses Dart as its programming language), single quotes (' ') and double quotes (" ") are functionally the same when defining string literals.
Use triple single (''' ''') or triple double (""" """) quotes for multiline strings.
If you need to use both types of quotes within a string, you can escape them using a backslash (\).


Question: Why do we use const in Flutter?
Answer: 
When a widget is declared as const, 
Flutter ensures that it is created only once in memory and 
reused instead of being rebuilt multiple times.

Question: Why do we use final in Flutter and Dart: 
Answer: 
In Flutter (and Dart), the final keyword is used to create variables 
whose values cannot be reassigned after being initialized
2. Difference Between final and const
Feature	final	const
Can be assigned only once?	✅ Yes	✅ Yes
Value known at compile-time?	❌ No	✅ Yes
Can be assigned dynamically at runtime?	✅ Yes	❌ No
Used for class fields?	✅ Yes	✅ Yes
Reduces unnecessary rebuilds in Flutter?	❌ No	✅ Yes
he title variable is final because its value is assigned when the widget is created and should not change.


Question: final ProfileController profileController = Get.find<ProfileController>(); is good practice to use:
Answer: is not the best practice in all cases. Let’s break it down:

If we are inside a StatelessWidget, it's fine to use final because ProfileController does not change.

If you declare final ProfileController profileController = Get.find<ProfileController>(); inside a StatefulWidget directly, it is not recommended because Get.find() might run before dependencies are ready.
late ProfileController profileController;

  @override
  void initState() {
    super.initState();
    profileController = Get.find<ProfileController>(); // ✅ Best practice
  }
  Using late ensures that profileController is initialized only after the widget is created.

When Using Get.put() Instead of Get.find()
If you are initializing the controller inside the widget, use Get.put() inside initState() instead of Get.find():


#: Why do we use _ in dart?
Answer: 
The underscore use means that _ is private and cann't access outside of class or others


#: Why do we use static in flutter and Dart:
✅ Shared Data → One copy of the variable for all objects.
✅ Memory Optimization → Prevents duplicate copies in each instance.
✅ Access Without Creating an Object → No need to instantiate the class.
✅ Utility Functions → Useful for helper methods.

#: Null Understand 
10. Summary Table ✅
Feature	Example	Purpose
Nullable Type ?	String? name;	Allows null
Null Check != null	if (name != null) {}	Prevents null errors
Null-Aware Access ?.	print(name?.length);	Calls only if not null
Null Assertion !	name!.length	Forces non-null (⚠️ risky)
Default Value ??	print(name ?? "Guest");	Uses fallback value
Assign If Null ??=	name ??= "Default";	Assigns only if null
Late Initialization late	late String name;	Delays initialization
Required Parameter required	({required String name})	Ensures a value


///// Home Page

#: Why do we use SafeArea:
Answer: SafeArea is a Flutter widget that helps prevent UI elements from being hidden behind system bars, notches, or status bars on different devices.

#: What is Stack in Flutter?
Answer: Stack is a Flutter widget that allows overlaying widgets on top of each other. It is useful when you need elements positioned relative to each other.
The Flutter Stack widget follows LIFO (Last In, First Out) ordering.

#: AspectRatio Widget in Flutter
The AspectRatio widget maintains a specific width-to-height ratio for its child. It ensures that the child scales while preserving the given aspect ratio.
aspectRatio: 16 / 11,: This means for every 16 width units, there will be 11 height units.
✅ If width = 160 pixels, height will be 110 pixels.


#: What is Expanded in Flutter?
Answer: The Expanded widget in Flutter is used inside a Row, Column, or Flex to make a child widget take up all available space. It helps in creating responsive layouts by distributing space dynamically.
Don't use Inside ListView or SingleChildScrollView (use shrinkWrap instead)

✔ Use Expanded when you want a widget to fill the space completely.
✔ Use Flexible if you want the widget to resize but not forcefully occupy all space

#: Difference Between FutureBuilder and StreamBuilder
Answer :  FutureBuilder: Fetches data once when the widget is built or when setState() is called. It’s used for single asynchronous calls.
StreamBuilder: Listens to a continuous stream of data updates and rebuilds the UI whenever new data is received


@@ Manage Product

#: Understand Clearly Final:
Answer: Final variable can't ressaing but can modify

#: What is Necessary to Use WidgetsBinding.instance.addPostFrameCallback?
Answer: To use WidgetsBinding.instance.addPostFrameCallback, you must ensure:
Flutter framework is initialized (it should be used within a widget lifecycle, not before runApp).
WidgetsBinding.instance.addPostFrameCallback allows executing code after the first frame is rendered but before the next frame begins.
এটি শুধুমাত্র তখন ব্যবহার করতে হবে যখন আপনি প্রথম ফ্রেম রেন্ডার হওয়ার পর কোনো অ্যাকশন চালাতে চান, যেমনঃ উইজেটের সাইজ বের করা, অ্যানিমেশন ট্রিগার করা, অথবা BuildContext নির্ভর কোনো কাজ করা।


#: Why is the class named ProductImagePlaceholder;
Answer: The class named  ProductImagePlaceholder because it represent a placeholder  Ui for 
a product Image . It is likely used when a product doesn't have an image yet, promiting the user to add one. 

#: What is SimpleDialog, and when and why is it use?
Answer: A SimpleDialog is a type of modal Dialog in flutter that present a list of option
to user . it is typically used when you need to select option or confirm 
❌ When you need more buttons (e.g., OK/Cancel) → Use AlertDialog instead.
❌ When complex widgets are needed inside the dialog → Use a showModalBottomSheet or Dialog.

#: When do we use onPressed(), and when it used OnPressed; 
Answer: 
Onpress: When you pass a function reference (without parentheses), it means the function will be executed later when the button or option is tapped.
❌ Incorrect when used directly in a widget’s property because it executes the function immediately, instead of waiting for user interaction.// Calling the passed function

#: Why Use formKey in Flutter?
formKey is used with the Form widget to manage form state and validate input fields. It allows you to:

#: Why Use const SizedBox.shrink(); in Flutter?
Answer: SizedBox.shrink() is a special SizedBox that has zero width and zero height. It is used to create an empty, invisible widget that does not take up any space in the UI.



###################Product:####################

#:  automaticallyImplyLeading: false,
Answer: Automatically use for hiding Leading AppBar

#: Descripitve this code: ProductModel productModel = ProductModel.fromMap(productDocs[index].data());
Answer: This code retrieves Firestore document data (as a map), converts it into a ProductModel instance, and stores it in the productModel variable.

#: List<QueryDocumentSnapshot<Map<String, dynamic>>> productDocs understand this code
Answer:  list of Firestore document snapshots, where each document contains structured data in the form of a Map<String, dynamic>

#: Understanding fromMap Factory Constructor
Answer: This is a factory constructor, meaning it does not create a new instance directly but instead returns an instance of ProductModel after processing map.

#: productDocs[index].data() why use .data()
Why Is .data() Needed?
Firestore’s QueryDocumentSnapshot does not directly hold the field values; instead, it provides methods to access them.
.data() extracts the fields as a Map<String, dynamic>, making it easier to use in models.

#: Why do we use shrinkWrap.true
Answer:
When shrinkWrap: true is Used
The GridView (or ListView) only takes up space required by its children instead of expanding indefinitely.
This is useful inside a column, single-child scroll view, or nested scrollable widgets.

#: Understanding List.generate(3, (index) => someValue) in Dart
Answer: The List.generate() function in Dart is used to create a list with a 
fixed number of elements and initialize each element using a function.

#: why do we use false in provider  (Provider.of<ProductModel>(context, false);
Answer:   Flutter's Provider package, the Provider.of<T>(context, listen: false) method is used to access an instance of T without listening for changes.
listen: false → The widget does not rebuild when the provider’s data changes.

#: What is difference between ... and .. in dart and flutter 
Answer: .. (Cascade Operator)
The cascade operator (..) is used to perform multiple operations on the same object without needing to reference the object multiple times.

... (Spread Operator)
The spread operator (...) is used to insert multiple elements from one collection (e.g., a list or set) into another collection. It’s primarily used with collections like lists and sets.

#: What is Memory: Dispose controllers to prevent memory leaks
Dispose controllers: Always call the dispose() method on controllers like TextEditingController, ScrollController, etc., in a StatefulWidget to prevent memory leaks.
dispose() method: This is where you free up any resources the controller is using.
Avoid memory leaks: Properly managing resources helps avoid memory leaks, improving the performance and stability of your app.

*/

























































  /*
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFormMessage = message.data['routes'];
        print(routeFormMessage);
      }
    });
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }

      LocalServiceNotification.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFormMessage = message.data['routes'];
      print(routeFormMessage);
    });
    
    */


// message.getFcmToken();
    // FirebaseDatabase.iniNotification();
    // LocalServiceNotification.initialize(context);