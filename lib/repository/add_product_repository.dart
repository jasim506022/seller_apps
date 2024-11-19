import 'package:image_picker/image_picker.dart';

import '../data/response/service/data_firebase_service.dart';
import '../model/productsmodel.dart';

class AddProductRepository {
  final _dataFirebaseService = DataFirebaseService();
  ImagePicker imagePicker = ImagePicker();
  Future<List<XFile>> captureImage(ImageSource source) async {
    List<XFile> imageXFileList = source == ImageSource.camera
        ? [(await imagePicker.pickImage(source: ImageSource.camera))!]
        : await imagePicker.pickMultiImage();

    return imageXFileList;
  }

  Future<List<String>> uploadImageStorage(
      {required List<XFile> imageList}) async {
    return _dataFirebaseService.uploadImageStorage(imageList: imageList);
  }

  Future<void> uploadProductSnapshot(
      {required ProductModel productModel, required bool isUpdate}) async {
    _dataFirebaseService.uploadProductSnapshot(
        productModel: productModel, isUpdate: isUpdate);
  }
}
