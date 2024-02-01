import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:seller_apps/const/approutes.dart';
import 'package:seller_apps/service/provider/loadingprovider.dart';

import '../../const/const.dart';
import '../../const/global.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../service/database/firebasedatabase.dart';
import '../../model/productsmodel.dart';
import '../../service/provider/imageaddremoveprovider.dart';
import '../../widget/capture_image_selection_dialog_widget.dart';
import '../../widget/custom_show_dialog_widget.dart';
import '../../widget/textfieldformwidget.dart';

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

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    final addUpdadateProductProvider =
        Provider.of<ImageAddRemoveProvider>(context, listen: false);
    final productModel = widget.productModel;
    if (widget.isUpdate == true) {
      Future.delayed(Duration.zero, () {
        addUpdadateProductProvider
          ..setImageListUrl(imageListUrl: [])
          ..setCategory(cateory: productModel!.productcategory!)
          ..setUnit(unitValue: productModel.productunit!)
          ..imageListUrl.addAll(productModel.productimage!.cast<String>());

        productTEC.text = productModel.productname!;
        priceTEC.text = productModel.productprice!.toString();
        ratingTEC.text = productModel.productrating!.toString();
        descriptionTEC.text = productModel.productdescription!;
        discountTEC.text = productModel.discount!.toString();
        productId = productModel.productId!;
      });
    } else {
      Future.delayed(Duration.zero, () {
        addUpdadateProductProvider
          ..setImageListXfile(imageListXfile: [])
          ..setImageListUrl(imageListUrl: [])
          ..setCategory(cateory: category.first);
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

// Upload Image in
  Container buildImageGrid(
      bool isUpdate, ImageAddRemoveProvider provider, BuildContext context) {
    final borderColor = isUpdate ? greenColor : greenColor.withOpacity(0.5);

    return Container(
      height: mq.height * 0.25,
      width: mq.width,
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: isUpdate ? 3 : 1),
      ),
      child: GridView.builder(
        itemCount: isUpdate
            ? provider.imageListUrl.length
            : provider.imagesListXfile.length,
        itemBuilder: (context, index) =>
            buildSingleImageShowAndDelete(isUpdate, provider, context, index),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
        ),
      ),
    );
  }

  Widget buildSingleImageShowAndDelete(bool isUpdate,
      ImageAddRemoveProvider provider, BuildContext context, int index) {
    dynamic imageUrl = isUpdate
        ? provider.imageListUrl[index]
        : File(provider.imagesListXfile[index].path);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 1),
            ),
            child: isUpdate
                ? Image.network(
                    imageUrl,
                    height: mq.height * 0.25,
                    width: mq.height * 0.25,
                    fit: BoxFit.fill,
                  )
                : Image.file(
                    imageUrl,
                    height: mq.height * 0.25,
                    width: mq.height * 0.25,
                    fit: BoxFit.contain,
                  ),
          ),
        ),
        Positioned(
          top: 2,
          right: 2,
          child: InkWell(
            onTap: () => isUpdate
                ? provider.removieImageUrl(imageUrl: index)
                : provider.removieImageXfile(indexImageXfile: index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: red,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }

// Upload Image and Product Product
  Future<void> uploadImagesAndUpdateProduct(
      ImageAddRemoveProvider imageAddRemoveProvider) async {
    for (XFile imageFile in imageAddRemoveProvider.imagesListXfile) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseDatabase.storageReference(
        catogryName: imageAddRemoveProvider.getCategory,
        fileName: fileName,
      );

      await reference.putFile(File(imageFile.path));
      String imageUrl = await reference.getDownloadURL();
      imageAddRemoveProvider.imageListUrl.add(imageUrl);
    }

    Map<String, dynamic> productMapData =
        _buildProductMap(imageAddRemoveProvider);

    try {
      await FirebaseDatabase.pushFirebaseFirestoreProductData(
        productId: productId,
        map: productMapData,
      );
      _buildSuccess("Add Successfully");
    } catch (error) {
      globalMethod.flutterToast(msg: "Error Occurred: $error");
    }
  }

  Future<void> addNewProduct(
      ImageAddRemoveProvider imageAddRemoveProvider) async {
    if (imageAddRemoveProvider.imagesListXfile.isEmpty) {
      globalMethod.flutterToast(msg: "Please Select at least One Image");
      return;
    }

    if (!_keyForm.currentState!.validate()) return;

    _buldSetLoading(true);

    await uploadImagesAndUpdateProduct(imageAddRemoveProvider);

    _buldSetLoading(false);
  }

  Future<void> updateProduct(
      ImageAddRemoveProvider imageAddRemoveProvider) async {
    if (imageAddRemoveProvider.imageListUrl.isEmpty) {
      globalMethod.flutterToast(msg: "Please Select at least One Image");
      return;
    }

    if (!_keyForm.currentState!.validate()) return;

    _buldSetLoading(true);

    Map<String, dynamic> updateproductMap =
        _buildProductMap(imageAddRemoveProvider);

    try {
      await FirebaseDatabase.updateFirebaseFirestoreProductData(
        productId: productId,
        map: updateproductMap,
      );
      _buildSuccess("Update Successfully");
    } catch (error) {
      globalMethod.flutterToast(msg: "Error Occurred: $error");
    }
  }

  void _buildSuccess(String message) {
    _buldSetLoading(false);
    globalMethod.flutterToast(msg: message);
    Navigator.pushReplacementNamed(context, AppRouters.mainPage);
  }

  void _buldSetLoading(bool isLoading) {
    Provider.of<LoadingProvider>(context, listen: false)
        .setLoading(loading: isLoading);
  }

  Map<String, dynamic> _buildProductMap(
      ImageAddRemoveProvider imageAddRemoveProvider) {
    return {
      "productId": productId,
      "sellerId": sharedPreference!.getString("uid"),
      "sellerName": sharedPreference!.getString("name"),
      "productname": productTEC.text,
      "productcategory": imageAddRemoveProvider.getCategory,
      "productprice": double.parse(priceTEC.text),
      "productunit": imageAddRemoveProvider.getUnit,
      "productrating": double.parse(ratingTEC.text),
      "productdescription": descriptionTEC.text,
      "publishDate": DateTime.now(),
      "discount": int.parse(discountTEC.text),
      "productimage": imageAddRemoveProvider.imageListUrl,
      "stutus": "available",
    };
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Theme.of(context).brightness));

    return Consumer<ImageAddRemoveProvider>(
      builder: (context, imageAddRemoveProvider, child) {
        if (imageAddRemoveProvider.imagesListXfile.isEmpty &&
            widget.isUpdate == false) {
          return defaultPage();
        }

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: WillPopScope(
            onWillPop: () async {
              return Future.value(stayOnScreenFunction(context));
            },
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomDialogWidget(
                            title: 'Save Upload Product',
                            content: 'Do you Want to Save Product Changes',
                            isBackScreenButton: true,
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
                    onPressed: () {
                      widget.isUpdate!
                          ? updateProduct(imageAddRemoveProvider)
                          : addNewProduct(imageAddRemoveProvider);
                    },
                    icon: Icon(
                      Icons.cloud_upload,
                      color: greenColor,
                    ),
                  )
                ],
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Consumer<LoadingProvider>(
                  builder: (context, loadingProvider, child) {
                    return ListView(
                      children: [
                        loadingProvider.isLoading == true
                            ? LinearProgressIndicator(
                                backgroundColor: red,
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: Column(
                            children: [
                              widget.isUpdate!
                                  ? buildImageGrid(
                                      true, imageAddRemoveProvider, context)
                                  : buildImageGrid(
                                      false, imageAddRemoveProvider, context),
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
                                                await imagePicker
                                                    .pickMultiImage();

                                            if (pickImage.isNotEmpty) {
                                              imageAddRemoveProvider
                                                  .imagesListXfile
                                                  .addAll(pickImage);
                                              for (XFile imageFile
                                                  in pickImage) {
                                                String fileName = DateTime.now()
                                                    .millisecondsSinceEpoch
                                                    .toString();

                                                Reference storageRef =
                                                    FirebaseDatabase
                                                        .storageReference(
                                                            catogryName:
                                                                imageAddRemoveProvider
                                                                    .getCategory,
                                                            fileName: fileName);

                                                await storageRef.putFile(
                                                    File(imageFile.path));
                                                String imageUrl =
                                                    await storageRef
                                                        .getDownloadURL();
                                                imageAddRemoveProvider
                                                    .imageListUrl
                                                    .add(imageUrl);
                                              }
                                              setState(() {});
                                            } else {
                                              globalMethod.flutterToast(
                                                  msg: "No Image Selected");
                                            }
                                          } catch (error) {
                                            globalMethod.flutterToast(
                                                msg:
                                                    "An Error Occured: $error");
                                          }
                                        }
                                      : () async {
                                          final List<XFile> pickImage =
                                              await imagePicker
                                                  .pickMultiImage();
                                          if (pickImage.isNotEmpty) {
                                            imageAddRemoveProvider
                                                .imagesListXfile
                                                .addAll(pickImage);
                                            setState(() {});
                                          } else {
                                            globalMethod.flutterToast(
                                                msg: "No Image Selected");
                                          }
                                        },
                                  child: Text(
                                    "Pick Image",
                                    style: GoogleFonts.poppins(
                                        color: white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  )),
                              SizedBox(
                                height: mq.height * .024,
                              ),
                              Form(
                                key: _keyForm,
                                child: Column(
                                  children: [
                                    DropdownButtonFormField(
                                      decoration: globalMethod
                                          .decorationDropDownButtonForm(
                                              context),
                                      value: imageAddRemoveProvider.getCategory,
                                      isExpanded: true,
                                      iconEnabledColor:
                                          Theme.of(context).primaryColor,
                                      style: GoogleFonts.poppins(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                      focusColor:
                                          Theme.of(context).primaryColor,
                                      elevation: 16,
                                      items: category
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (value) {
                                        Provider.of<ImageAddRemoveProvider>(
                                                context,
                                                listen: false)
                                            .setCategory(cateory: value!);
                                      },
                                    ),
                                    TextFieldFormWidget(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter Product Name';
                                        }
                                        return null;
                                      },
                                      controller: productTEC,
                                      hintText: 'Product Name',
                                      textInputType: TextInputType.text,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 4,
                                          child: TextFieldFormWidget(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter Product Price';
                                              }
                                              return null;
                                            },
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
                                            value:
                                                imageAddRemoveProvider.getUnit,
                                            dropdownColor:
                                                Theme.of(context).cardColor,
                                            isExpanded: true,
                                            iconEnabledColor:
                                                Theme.of(context).primaryColor,
                                            style: GoogleFonts.poppins(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                            focusColor:
                                                Theme.of(context).primaryColor,
                                            elevation: 16,
                                            items: unitList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value));
                                            }).toList(),
                                            onChanged: (value) {
                                              Provider.of<ImageAddRemoveProvider>(
                                                      context,
                                                      listen: false)
                                                  .setUnit(unitValue: value!);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextFieldFormWidget(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter Discount';
                                        }
                                        return null;
                                      },
                                      controller: discountTEC,
                                      hintText: 'Discount',
                                      textInputType: TextInputType.number,
                                    ),
                                    TextFieldFormWidget(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter Ratting';
                                        }
                                        return null;
                                      },
                                      controller: ratingTEC,
                                      hintText: 'Rating',
                                      textInputType: TextInputType.number,
                                    ),
                                    TextFieldFormWidget(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter Description';
                                        }
                                        return null;
                                      },
                                      controller: descriptionTEC,
                                      hintText: 'Description',
                                      textInputAction: TextInputAction.newline,
                                      maxLines: null,
                                      textInputType: TextInputType.multiline,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> stayOnScreenFunction(BuildContext context) async {
    bool stayOnScreen = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialogWidget(
          title: 'Save Upload Product',
          content: 'Do you Want to Save Product Changes',
        );
      },
    );

    return stayOnScreen;
  }

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
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.width * .066,
                        vertical: mq.height * .012),
                    backgroundColor: greenColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) => CaptureImageSelectionDialogWidget(
                          imagePicker: imagePicker),
                    ),
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
