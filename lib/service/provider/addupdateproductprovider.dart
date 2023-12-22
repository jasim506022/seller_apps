import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../const/global.dart';

class AddUpdadateProductProvider with ChangeNotifier {
  bool uploading = false;
  bool get getUploading => uploading;
  setUploading({required bool value}) {
    uploading = value;
    notifyListeners();
  }

  // Xfile image List
  List<XFile> _imagesListXfile = [];

  List<XFile> get imagesListXfile => _imagesListXfile;

  void setImage({required List<XFile> photo}) {
    _imagesListXfile = photo;
    notifyListeners();
  }

  void removieImage({required int index}) {
    _imagesListXfile.removeAt(index);
    notifyListeners();
  }

//Image urls
  List<String> _imageUrls = [];

  List<String> get imageUrl => _imageUrls;

  void setImageUrl({required List<String> photo}) {
    _imageUrls = photo;
    notifyListeners();
  }

  void removieImageUrl({required int index}) {
    _imageUrls.removeAt(index);
    notifyListeners();
  }

//Cateogry
  String _categoryName = category.first;

  String get categoryName => _categoryName;

  categorySet({required String cateory}) {
    _categoryName = cateory;
    notifyListeners();
  }

  String _unit = unitList.first;

  String get unit => _unit;

  setUnit({required String unitValue}) {
    _unit = unitValue;
    notifyListeners();
  }

  //Single Image Select
  XFile? _imageXFile;

  XFile? get imageXFile => _imageXFile;

  void setSingleImage({required XFile photo}) {
    _imageXFile = photo;
    _isChangeProfilePicture = true;

    notifyListeners();
  }

  bool _isChangeProfilePicture = false;

  bool get isChangeProfilePicture => _isChangeProfilePicture;

  //Image urls
  String _singlePhoto = "";

  String get singlePhoto => _singlePhoto;

  void setSinglePhotoUrl({required String photo}) {
    _singlePhoto = photo;
    notifyListeners();
  }
}
