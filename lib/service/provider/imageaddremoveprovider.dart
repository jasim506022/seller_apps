import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../res/app_constants.dart';

class ImageAddRemoveProvider with ChangeNotifier {
  // Use for Image List
  List<XFile> _imagesListXfile = [];

  // get All ImageXfile
  List<XFile> get imagesListXfile => _imagesListXfile;

  // set List of Image XFile
  void setImageListXfile({required List<XFile> imageListXfile}) {
    _imagesListXfile = imageListXfile;
    notifyListeners();
  }

  // To remove an image from a list based on its index,
  void removieImageXfile({required int indexImageXfile}) {
    _imagesListXfile.removeAt(indexImageXfile);
    notifyListeners();
  }

  // Use4 Image List Url
  List<String> _imageListUrl = [];
  // get All List Image url
  List<String> get imageListUrl => _imageListUrl;

  // set List of Image url
  void setImageListUrl({required List<String> imageListUrl}) {
    _imageListUrl = imageListUrl;
    notifyListeners();
  }

  // To remove an image from a list based on its index,
  void removieImageUrl({required int imageUrl}) {
    _imageListUrl.removeAt(imageUrl);
    notifyListeners();
  }

  // Cateogry

  String _categoryName = AppConstants.categories.first;

  // get Category Item
  String get getCategory => _categoryName;

  // set Category
  setCategory({required String cateory}) {
    _categoryName = cateory;
    notifyListeners();
  }

  // Unit
  String _unit = AppConstants.units.first;

  // getUnit
  String get getUnit => _unit;
  // set Unit
  setUnit({required String unitValue}) {
    _unit = unitValue;
    notifyListeners();
  }

  //Single Image Select
  XFile? _singleImageXFile;

  XFile? get singleImageXFile => _singleImageXFile;

  void setSingleImageXFile(
      {required XFile? singleImageXFile, bool isChange = false}) {
    _singleImageXFile = singleImageXFile;
    _isChangeProfilePicture = isChange;
    notifyListeners();
  }

  bool _isChangeProfilePicture = false;
  bool get isChangeProfilePicture => _isChangeProfilePicture;

  //Image urls
  String _singleImageUrl = "";
  String get singleImageUrl => _singleImageUrl;
  void setSingleImageUrl({required String singleImageUrl}) {
    _singleImageUrl = singleImageUrl;
    notifyListeners();
  }
}
