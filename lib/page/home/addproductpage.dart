import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/database/firebasedatabase.dart';

import '../../const/const.dart';
import '../../const/global.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../model/productsmodel.dart';
import '../../service/provider/addupdateproductprovider.dart';
import '../../widget/textfieldformwidget.dart';
import '../main/mainscreen.dart';

// ignore: must_be_immutable
class AddProductPage extends StatefulWidget {
  AddProductPage({super.key, this.isUpdate, this.productModel});

  bool? isUpdate;
  ProductModel? productModel;

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController productTEC = TextEditingController();
  TextEditingController priceTEC = TextEditingController();
  TextEditingController ratingTEC = TextEditingController();
  TextEditingController descriptionTEC = TextEditingController();
  TextEditingController discountTEC = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();

  var keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.isUpdate == true) {
      Future.delayed(Duration.zero, () {
        var myData =
            Provider.of<AddUpdadateProductProvider>(context, listen: false);
        myData.setImageUrl(photo: []);
        productTEC.text = widget.productModel!.productname!;
        priceTEC.text = widget.productModel!.productprice!.toString();
        ratingTEC.text = widget.productModel!.productrating!.toString();
        descriptionTEC.text = widget.productModel!.productdescription!;
        discountTEC.text = widget.productModel!.discount!.toString();
        productId = widget.productModel!.productId!;
        myData.categorySet(cateory: widget.productModel!.productcategory!);
        myData.setUnit(unitValue: widget.productModel!.productunit!);
        for (String images in widget.productModel!.productimage!) {
          myData.imageUrl.add(images);
          setState(() {});
        }
      });
    } else {
      Future.delayed(Duration.zero, () {
        var myData =
            Provider.of<AddUpdadateProductProvider>(context, listen: false);
        myData.setImage(photo: []);
        myData.setImageUrl(photo: []);
        myData.categorySet(cateory: category.first);
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    priceTEC.dispose();
    productTEC.dispose();
    ratingTEC.dispose();
    descriptionTEC.dispose();
    discountTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Theme.of(context).brightness));
    return Consumer<AddUpdadateProductProvider>(
      builder: (context, uploadprovider, child) {
        if (uploadprovider.imagesListXfile.isEmpty &&
            widget.isUpdate == false) {
          return defaultPage();
        }

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: WillPopScope(
            onWillPop: () async {
              bool stayOnScreen = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Theme.of(context).cardColor,
                    title: Text("Do You Want to Save",
                        style: GoogleFonts.poppins(
                            color: greenColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    content: Text("Do you Want to Unsave Product Changes",
                        style: GoogleFonts.poppins(
                            color: Theme.of(context).primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w700)),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Okay")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text("No"))
                    ],
                  );
                },
              );
              return Future.value(stayOnScreen);
            },
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Theme.of(context).cardColor,
                            title: Text("Do You Want to Save",
                                style: GoogleFonts.poppins(
                                    color: greenColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            content: Text(
                                "Do you Want to Unsave Product Changes",
                                style: GoogleFonts.poppins(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700)),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Okay")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No"))
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).primaryColor,
                    )),
                title: widget.isUpdate == true
                    ? const Text(
                        "Update Product",
                      )
                    : const Text(
                        "Add New Product",
                      ),
                actions: [
                  IconButton(
                      onPressed: widget.isUpdate == true
                          ? () async {
                              try {
                                if (uploadprovider.imageUrl.isNotEmpty) {
                                  if (keyForm.currentState!.validate()) {
                                    Provider.of<AddUpdadateProductProvider>(
                                            context,
                                            listen: false)
                                        .setUploading(value: true);

                                    Map<String, dynamic> updateproductMap = {
                                      "productId": productId,
                                      "sellerId":
                                          sharedPreference!.getString("uid"),
                                      "sellerName":
                                          sharedPreference!.getString("name"),
                                      "productname": productTEC.text,
                                      "productcategory":
                                          uploadprovider.categoryName,
                                      "productprice":
                                          double.parse(priceTEC.text),
                                      "productunit": uploadprovider.unit,
                                      "productrating":
                                          double.parse(ratingTEC.text),
                                      "productdescription": descriptionTEC.text,
                                      "publishDate": DateTime.now(),
                                      "discount": int.parse(discountTEC.text),
                                      "productimage": uploadprovider.imageUrl,
                                      "stutus": "avaible"
                                    };

                                    FirebaseDatabase
                                            .updateFirebaseFirestoreProductData(
                                                productId: productId,
                                                map: updateproductMap)
                                        .catchError((error) {
                                      globalMethod.flutterToast(
                                          msg: " Error Occured: $error ");
                                    });

                                    if (mounted) {
                                      Provider.of<AddUpdadateProductProvider>(
                                              context,
                                              listen: false)
                                          .setUploading(value: false);
                                      globalMethod.flutterToast(
                                          msg: " Update Successfully ");

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainScreen(),
                                          ));
                                    }
                                  }
                                } else {
                                  globalMethod.flutterToast(
                                      msg: "Please Select atleast One Image");
                                }
                              } catch (error) {
                                globalMethod.flutterToast(
                                    msg: "An Error Occured: $error");
                              }
                            }
                          : () async {
                              try {
                                if (uploadprovider.imagesListXfile.isNotEmpty) {
                                  if (keyForm.currentState!.validate()) {
                                    Provider.of<AddUpdadateProductProvider>(
                                            context,
                                            listen: false)
                                        .setUploading(value: true);

                                    for (XFile imageFile
                                        in uploadprovider.imagesListXfile) {
                                      String fileName = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString();

                                      Reference reference =
                                          FirebaseDatabase.storageReference(
                                              catogryName:
                                                  uploadprovider.categoryName,
                                              fileName: fileName);

                                      await reference
                                          .putFile(File(imageFile.path));

                                      String imageurl =
                                          await reference.getDownloadURL();
                                      uploadprovider.imageUrl.add(imageurl);
                                    }
                                    Map<String, dynamic> productMapData = {
                                      "productId": productId,
                                      "sellerId":
                                          sharedPreference!.getString("uid"),
                                      "sellerName":
                                          sharedPreference!.getString("name"),
                                      "productname": productTEC.text,
                                      "productcategory":
                                          uploadprovider.categoryName,
                                      "productprice":
                                          double.parse(priceTEC.text),
                                      "productunit": uploadprovider.unit,
                                      "productrating":
                                          double.parse(ratingTEC.text),
                                      "productdescription": descriptionTEC.text,
                                      "publishDate": DateTime.now(),
                                      "discount": int.parse(discountTEC.text),
                                      "productimage": uploadprovider.imageUrl,
                                      "stutus": "avaible"
                                    };
                                    FirebaseDatabase
                                            .pushFirebaseFirestoreProductData(
                                                productId: productId,
                                                map: productMapData)
                                        .catchError((error) {
                                      globalMethod.flutterToast(
                                          msg: " Error Occured: $error ");
                                    });
                                    if (mounted) {
                                      Provider.of<AddUpdadateProductProvider>(
                                              context,
                                              listen: false)
                                          .setUploading(value: false);
                                      globalMethod.flutterToast(
                                          msg: " Add Successfully ");

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainScreen(),
                                          ));
                                    }
                                  }
                                } else {
                                  globalMethod.flutterToast(
                                      msg: "Please Select atleast One Image");
                                }
                              } catch (error) {
                                globalMethod.flutterToast(
                                    msg: "An Error Occured: $error");
                              }
                            },
                      icon: Icon(
                        Icons.cloud_upload,
                        color: greenColor,
                      ))
                ],
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: ListView(
                  children: [
                    uploadprovider.uploading == true
                        ? LinearProgressIndicator(
                            backgroundColor: red,
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Column(
                        children: [
                          widget.isUpdate == true
                              ? Container(
                                  height: mq.height * .25,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(3),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: greenColor, width: 3)),
                                  child: GridView.builder(
                                    itemCount: uploadprovider.imageUrl.length,
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      width: 1)),
                                              child: Image.network(
                                                  height: mq.height * .25,
                                                  width: mq.height * .25,
                                                  fit: BoxFit.fill,
                                                  uploadprovider
                                                      .imageUrl[index]),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Provider.of<AddUpdadateProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .removieImageUrl(
                                                      index: index);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              margin: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  shape: BoxShape.circle),
                                              child: Icon(
                                                Icons.close,
                                                color: red,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1.5,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 2,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: mq.height * .25,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: greenColor, width: 1)),
                                  child: GridView.builder(
                                    itemCount:
                                        uploadprovider.imagesListXfile.length,
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      width: 1)),
                                              child: Image.file(
                                                File(uploadprovider
                                                    .imagesListXfile[index]
                                                    .path),
                                                height: mq.height * .25,
                                                width: mq.height * .25,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Provider.of<AddUpdadateProductProvider>(
                                                      context,
                                                      listen: false)
                                                  .removieImage(index: index);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              margin: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  shape: BoxShape.circle),
                                              child: Icon(
                                                Icons.close,
                                                color: red,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1.5,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 2,
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: greenColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10)),
                              onPressed: widget.isUpdate == true
                                  ? () async {
                                      try {
                                        final List<XFile> pickImage =
                                            await imagePicker.pickMultiImage();
                                        if (pickImage.isNotEmpty) {
                                          uploadprovider.imagesListXfile
                                              .addAll(pickImage);
                                          for (XFile imageFile in pickImage) {
                                            String fileName = DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString();

                                            Reference storageRef =
                                                FirebaseDatabase
                                                    .storageReference(
                                                        catogryName:
                                                            uploadprovider
                                                                .categoryName,
                                                        fileName: fileName);

                                            await storageRef
                                                .putFile(File(imageFile.path));
                                            String imageUrl = await storageRef
                                                .getDownloadURL();
                                            uploadprovider.imageUrl
                                                .add(imageUrl);
                                          }
                                          setState(() {});
                                        } else {
                                          globalMethod.flutterToast(
                                              msg: "No Image Selected");
                                        }
                                      } catch (error) {
                                        globalMethod.flutterToast(
                                            msg: "An Error Occured: $error");
                                      }
                                    }
                                  : () async {
                                      final List<XFile> pickImage =
                                          await imagePicker.pickMultiImage();
                                      if (pickImage.isNotEmpty) {
                                        uploadprovider.imagesListXfile
                                            .addAll(pickImage);
                                        setState(() {});
                                      } else {
                                        globalMethod.flutterToast(
                                            msg: "Now Image Selected");
                                      }
                                    },
                              child: Text(
                                "Pick Image",
                                style: GoogleFonts.poppins(
                                    color: white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: keyForm,
                            child: Column(
                              children: [
                                DropdownButtonFormField(
                                  decoration: globalMethod
                                      .decorationDropDownButtonForm(context),
                                  value: uploadprovider.categoryName,
                                  isExpanded: true,
                                  iconEnabledColor:
                                      Theme.of(context).primaryColor,
                                  style: GoogleFonts.poppins(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  focusColor: Theme.of(context).primaryColor,
                                  elevation: 16,
                                  items: category.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value, child: Text(value));
                                  }).toList(),
                                  onChanged: (value) {
                                    Provider.of<AddUpdadateProductProvider>(
                                            context,
                                            listen: false)
                                        .categorySet(cateory: value!);
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
                                        decoration: globalMethod
                                            .decorationDropDownButtonForm(
                                                context),
                                        value: uploadprovider.unit,
                                        dropdownColor:
                                            Theme.of(context).cardColor,
                                        isExpanded: true,
                                        iconEnabledColor:
                                            Theme.of(context).primaryColor,
                                        style: GoogleFonts.poppins(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                        focusColor:
                                            Theme.of(context).primaryColor,
                                        elevation: 16,
                                        items: unitList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                              value: value, child: Text(value));
                                        }).toList(),
                                        onChanged: (value) {
                                          Provider.of<AddUpdadateProductProvider>(
                                                  context,
                                                  listen: false)
                                              .setUnit(unitValue: value!);
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

// Default Page
  Scaffold defaultPage() {
    Textstyle textstyle = Textstyle(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New  Product",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: mq.height * .23,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    backgroundColor: greenColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  globalMethod.obtainImageDialog(
                      context: context, imagePicker: imagePicker);
                },
                child: Text(
                  "Add New Product",
                  style: textstyle.largeText.copyWith(
                    color: white,
                    letterSpacing: 1.3,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
