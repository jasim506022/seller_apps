import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPageProvider with ChangeNotifier {
  XFile? _imageXFile;

  XFile? get imageXFile => _imageXFile;

  void setImageFile({required XFile photo}) {
    _imageXFile = photo;
    _isChangeProfilePicture = true;
    notifyListeners();
  }

  bool _isChangeProfilePicture = false;
  bool get isChangeProfilePicture => _isChangeProfilePicture;

  //Image urls
  String _imageurl = "";

  String get imageurl => _imageurl;

  void setSinglePhotoUrl({required String imageUrl}) {
    _imageurl = imageUrl;
    notifyListeners();
  }
}
