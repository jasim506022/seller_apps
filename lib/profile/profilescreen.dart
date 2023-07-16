import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_apps/const/global.dart';
import 'package:seller_apps/model/profilemodel.dart';

import '../widget/textfieldformwidget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings_outlined,
                size: 25,
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .23,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('seller')
                  .doc(sharedPreference!.getString("uid"))
                  .get(),
              builder: (context, snapshot) {
                ProfileModel profileModel =
                    ProfileModel.fromMap(snapshot.data!.data()!);
                if (snapshot.hasData) {
                  return Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .20,
                        width: MediaQuery.of(context).size.height * .20,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(profileModel.imageurl!),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              profileModel.name!,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              profileModel.email!,
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.symmetric(
                                              horizontal: 50, vertical: 15)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Edit Profile",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      )
                    ],
                  );
                }

                return Text("Bangladesh");
              },
            ),
          )
        ],
      ),
    );
  }
}

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   TextEditingController nameTEC = TextEditingController();
//   TextEditingController addressTEC = TextEditingController();
//   TextEditingController phoneTEC = TextEditingController();
//   TextEditingController emailTEC = TextEditingController();

//   bool uploading = false;
//   String image = "";
//   final ImagePicker picker = ImagePicker();
//   XFile? imageFile;

//   bool isChangeProfilePicture = false;

//   getImageFromGaller() async {
//     imageFile = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       bool isChangeProfilePicture = true;
//       imageFile;
//     });
//   }

//   void initialize() async {
//     var document = await FirebaseFirestore.instance
//         .collection('seller')
//         .doc(sharedPreference!.getString("uid"))
//         .get();

//     nameTEC.text = document['name'];
//     emailTEC.text = document['email'];
//     addressTEC.text = document['address'];
//     phoneTEC.text = document['phone'];
//     image = document['imageurl'];
//     print(image);
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     initialize();
//     super.initState();
//   }

//   bool isEdit = false;
//   String? name;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Profile",
//           style: GoogleFonts.poppins(
//             color: Colors.black,
//             fontSize: 17,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: FutureBuilder(
//           future: FirebaseFirestore.instance
//               .collection('seller')
//               .doc(sharedPreference!.getString("uid"))
//               .get(),
//           builder: (context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               ProfileModel profileModel =
//                   ProfileModel.fromMap(snapshot.data!.data()!);
//               nameTEC.text = profileModel.name!;
//               emailTEC.text = profileModel.email!;
//               addressTEC.text = profileModel.address!;
//               phoneTEC.text = profileModel.phone!;
//               return Column(
//                 children: [
//                   ElevatedButton(
//                       onPressed: () async {
//                         {
//                           if (isEdit) {
//                             if (isChangeProfilePicture) {
//                               String fileName = DateTime.now()
//                                   .millisecondsSinceEpoch
//                                   .toString();

//                               Reference storageRef = FirebaseStorage.instance
//                                   .ref()
//                                   .child("userImage")
//                                   .child(fileName);

//                               UploadTask uploadTask =
//                                   storageRef.putFile(File(imageFile!.path));

//                               TaskSnapshot taskSnapshot =
//                                   await uploadTask.whenComplete(() {});
//                               taskSnapshot.ref
//                                   .getDownloadURL()
//                                   .then((downloadurl) {
//                                 image = downloadurl;
//                               });

//                               await FirebaseFirestore.instance
//                                   .collection("seller")
//                                   .doc(sharedPreference!.getString("uid"))
//                                   .update({
//                                 "name": nameTEC.text,
//                                 "email": emailTEC.text,
//                                 "address": addressTEC.text,
//                                 "phone": phoneTEC.text,
//                                 "imageurl": image,
//                               }).then((value) {
//                                 flutterToast(msg: "Bangladesh");
//                               }).catchError((error) {
//                                 flutterToast(msg: "Error $error");
//                               });
//                             } else {
//                               await FirebaseFirestore.instance
//                                   .collection("seller")
//                                   .doc(sharedPreference!.getString("uid"))
//                                   .update({
//                                 "name": nameTEC.text,
//                                 "email": emailTEC.text,
//                                 "address": addressTEC.text,
//                                 "phone": phoneTEC.text,
//                               }).then((value) {
//                                 flutterToast(msg: "indian");
//                               }).catchError((error) {
//                                 flutterToast(msg: "Error $error");
//                               });
//                             }
//                             isEdit = !isEdit;
//                             setState(() {});
//                           } else {
//                             isEdit = !isEdit;
//                             setState(() {});
//                           }
//                         }
//                       },
//                       child: Text(
//                           isEdit == false ? "Edit Profile " : "Save Profile")),
//                   isEdit == true
//                       ? Stack(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(color: Colors.black)),
//                               child: imageFile == null
//                                   ? CircleAvatar(
//                                       radius: 72,
//                                       backgroundImage: NetworkImage(image),
//                                     )
//                                   : CircleAvatar(
//                                       radius: 72,
//                                       backgroundImage:
//                                           FileImage(File(imageFile!.path)),
//                                     ),
//                             ),
//                             Positioned(
//                               bottom: 0,
//                               right: 0,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.red.shade400,
//                                     shape: BoxShape.circle),
//                                 child: IconButton(
//                                     onPressed: () {
//                                       getImageFromGaller();
//                                     },
//                                     icon: Icon(
//                                       Icons.camera_alt,
//                                       color: Colors.white,
//                                       size: 30,
//                                     )),
//                               ),
//                             ),
//                           ],
//                         )
//                       : Container(
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(color: Colors.black)),
//                           child: CircleAvatar(
//                             radius: 72,
//                             backgroundImage: NetworkImage(image),
//                           ),
//                         ),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.person,
//                       ),
//                       Text("Name")
//                     ],
//                   ),
//                   TextFieldForProfile(
//                     controller: nameTEC,
//                     enabled: isEdit == false ? false : true,
//                   ),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.person,
//                       ),
//                       Text("Phone")
//                     ],
//                   ),
//                   TextFieldForProfile(
//                     controller: phoneTEC,
//                     enabled: isEdit == false ? false : true,
//                   ),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.person,
//                       ),
//                       Text("Email")
//                     ],
//                   ),
//                   TextFieldForProfile(
//                     controller: emailTEC,
//                     enabled: isEdit == false ? false : true,
//                   ),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.person,
//                       ),
//                       Text("address")
//                     ],
//                   ),
//                   TextFieldForProfile(
//                     controller: addressTEC,
//                     enabled: isEdit == false ? false : true,
//                   ),
//                 ],
//               );
//             }
//             return Text("No Bangladesh");
//           },
//         ),
//       ),
//     );
//   }
// }
