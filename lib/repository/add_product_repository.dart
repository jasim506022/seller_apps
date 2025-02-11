import 'package:image_picker/image_picker.dart';

import '../data/response/service/data_firebase_service.dart';
import '../model/product_model.dart';
import '../res/app_function.dart';

class AddProductRepository {
  final _dataFirebaseService = DataFirebaseService();
  ImagePicker imagePicker = ImagePicker();

  Future<List<XFile>> captureImage(ImageSource source) async {
    try {
      List<XFile> imageXFileList = source == ImageSource.camera
          ? [(await imagePicker.pickImage(source: ImageSource.camera))!]
          : await imagePicker.pickMultiImage();

      return imageXFileList;
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<List<String>> uploadImagesToStorage(
      {required List<XFile> imageList, required String productID}) async {
    try {
      return _dataFirebaseService.uploadImagesToStorage(
          images: imageList, productID: productID);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Future<void> saveProductToDatabase(
      {required ProductModel productModel, required bool isUpdate}) async {
    try {
      _dataFirebaseService.saveProductToDatabase(
          productModel: productModel, isUpdate: isUpdate);
    } catch (e) {
      AppsFunction.handleException(e);
    }
  }
}
