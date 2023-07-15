import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_apps/main/mainscreen.dart';
import '../const/global.dart';
import '../widget/textfieldformwidget.dart';

const List<String> categorylist = <String>[
  'Fruits',
  'Vegetables',
  'Dairy & Egg',
  'Dry & Canned',
  "Drinks",
  "Meat & Fish",
  "Candy & Chocolate"
];
const List<String> unit = <String>[
  'Per Kg',
  'Per Dozen',
  'Litter',
  'Pc',
  'Pcs',
];

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String dropdownValue = categorylist.first;
  String unitValue = unit.first;

  TextEditingController productTEC = TextEditingController();
  TextEditingController priceTEC = TextEditingController();
  TextEditingController ratingTEC = TextEditingController();
  TextEditingController descriptionTEC = TextEditingController();
  TextEditingController discountTEC = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  List<XFile> imgeFileLIst = [];
  String productId = DateTime.now().millisecondsSinceEpoch.toString();

  var keyForm = GlobalKey<FormState>();
  bool uploading = false;
  List<String> imageUrls = [];

  captureimagewithgallery() async {
    Navigator.pop(context);
    imgeFileLIst = await imagePicker.pickMultiImage();
    setState(() {
      imgeFileLIst;
    });
  }

  captureimagewithcamera() async {
    Navigator.pop(context);
    var imgeFile = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgeFileLIst.add(imgeFile!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Add Items",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (imgeFileLIst.isNotEmpty) {
                  if (keyForm.currentState!.validate()) {
                    setState(() {
                      uploading = true;
                    });

                    for (XFile imageFile in imgeFileLIst) {
                      String fileName =
                          DateTime.now().millisecondsSinceEpoch.toString();

                      Reference storageRef = FirebaseStorage.instance
                          .ref()
                          .child("productimage")
                          .child(dropdownValue)
                          .child(fileName);

                      TaskSnapshot uploadTask =
                          await storageRef.putFile(File(imageFile.path));

                      String imageurl = await storageRef.getDownloadURL();
                      imageUrls.add(imageurl);
                    }
                    FirebaseFirestore.instance
                        .collection("seller")
                        .doc(sharedPreference!.getString("uid"))
                        .collection("products")
                        .doc(productId)
                        .set({
                      "productId": productId,
                      "sellerId": sharedPreference!.getString("uid"),
                      "sellerName": sharedPreference!.getString("name"),
                      "productname": productTEC.text,
                      "productcategory": dropdownValue,
                      "productprice": double.parse(priceTEC.text),
                      "productunit": unitValue,
                      "productrating": double.parse(ratingTEC.text),
                      "productdescription": descriptionTEC.text,
                      "publishDate": DateTime.now(),
                      "discount": int.parse(discountTEC.text),
                      "productimage": imageUrls,
                      "stutus": "avaible"
                    }).then((value) {
                      FirebaseFirestore.instance
                          .collection("products")
                          .doc(productId)
                          .set({
                        "productId": productId,
                        "sellerId": sharedPreference!.getString("uid"),
                        "sellerName": sharedPreference!.getString("name"),
                        "productname": productTEC.text,
                        "productcategory": dropdownValue,
                        "productprice": double.parse(priceTEC.text),
                        "productunit": unitValue,
                        "productrating": double.parse(ratingTEC.text),
                        "discount": int.parse(discountTEC.text),
                        "productdescription": descriptionTEC.text,
                        "publishDate": DateTime.now(),
                        "productimage": imageUrls,
                        "stutus": "avaible"
                      });
                    }).catchError((error) {
                      flutterToast(msg: " Error Occured: $error ");
                    });

                    setState(() {
                      uploading = false;
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ));
                  }
                } else {
                  flutterToast(msg: "Please Select atleast One Image");
                }
              },
              icon: Icon(
                Icons.cloud_upload,
                color: Color(0xff00b761),
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              uploading == true
                  ? LinearProgressIndicator(
                      color: Colors.black,
                    )
                  : Container(),
              imgeFileLIst.isNotEmpty
                  ? Container(
                      height: 300,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2)),
                      child: GridView.builder(
                        itemCount: imgeFileLIst.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.red, width: 1)),
                                  child: Image.file(
                                    File(imgeFileLIst[index].path),
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  imgeFileLIst.removeAt(index);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  margin: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        obtainImageDialog();
                      },
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Color(0xff00b761),
                        size: 200,
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  var selectImage = await imagePicker.pickMultiImage();

                  if (selectImage.isNotEmpty) {
                    imgeFileLIst.addAll(selectImage);
                    setState(() {});
                  } else {
                    flutterToast(msg: 'No Image Selected');
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  decoration: BoxDecoration(
                      color: const Color(0xff00b761),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Pick Image",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: keyForm,
                child: Column(
                  children: [
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        fillColor: const Color(0xfff2f2f8),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                      ),
                      value: dropdownValue,
                      isExpanded: true,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      focusColor: Colors.black,
                      elevation: 16,
                      items: categorylist
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                    ),
                    TextFieldFormWidget(
                      controller: productTEC,
                      hintText: 'Product Name',
                      textInputType: TextInputType.text,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: TextFieldFormWidget(
                            controller: priceTEC,
                            hintText: 'Product Price',
                            textInputType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex: 3,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              fillColor: const Color(0xfff2f2f8),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                            ),
                            value: unitValue,
                            isExpanded: true,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                            focusColor: Colors.black,
                            elevation: 16,
                            items: unit
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                unitValue = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFieldFormWidget(
                      controller: discountTEC,
                      hintText: 'Discount',
                      textInputType: TextInputType.number,
                    ),
                    TextFieldFormWidget(
                      controller: ratingTEC,
                      hintText: 'Rating',
                      textInputType: TextInputType.number,
                    ),
                    TextFieldFormWidget(
                      controller: descriptionTEC,
                      hintText: 'Description',
                      maxLines: 6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  obtainImageDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          title: Text("Selected Image"),
          children: [
            SimpleDialogOption(
              onPressed: () {
                captureimagewithcamera();
              },
              child: Text("Capture image with Camera"),
            ),
            SimpleDialogOption(
              onPressed: () {
                captureimagewithgallery();
              },
              child: Text("Capture image with Galler"),
            ),
            SimpleDialogOption(
              onPressed: () {},
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
