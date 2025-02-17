
/*
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