import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/add_product_controller.dart';

import '../../../res/app_constants.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/validator.dart';
import '../../../widget/custom_elevated_widget.dart';
import '../../../widget/custom_drop_down_widget.dart';
import '../../../widget/text_field_form_widget.dart';
import 'grid_image_list_widget.dart';

class AddEditProductForm extends StatefulWidget {
  const AddEditProductForm({super.key, required this.isUpdate});
  final bool isUpdate;
  @override
  State<AddEditProductForm> createState() => _AddEditProductFormState();
}

class _AddEditProductFormState extends State<AddEditProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddProductController addProductController =
      Get.find<AddProductController>();

  // bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (addProductController.loadingController.loading.value) {
            AppsFunction.flutterToast(msg: AppString.waitUntilUpload);
          } else {
            addProductController.confirmUnsavedChangesOnBack(didPop);
          }
        },
        child: Scaffold(
            appBar: _buildAppBar(),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: ListView(
                  children: [
                    Obx(() {
                      return addProductController
                              .loadingController.loading.value
                          ? const LinearProgressIndicator(
                              backgroundColor: AppColors.red,
                            )
                          : const SizedBox
                              .shrink(); // Use this to avoid rendering anything when not loading.
                    }),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      child: Column(
                        children: [
                          const GridImageListWidget(),
                          AppsFunction.verticalSpace(10),
                          _buildImagePickerButton(),
                          AppsFunction.verticalSpace(20),
                          _buildProductForm(),
                          Obx(() {
                            return addProductController
                                    .loadingController.loading.value
                                ? const LinearProgressIndicator(
                                    backgroundColor: AppColors.red,
                                  )
                                : const SizedBox.shrink();
                          }),
                          AppsFunction.verticalSpace(120),
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
          widget.isUpdate ? AppString.updateProduct : AppString.addNewProduct),
      actions: [
        IconButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              
              /*
              if (!(await NetworkUtili.verifyInternetStatus())) {
                addProductController.uploadOrUpdateProduct(
                    isUpdate: widget.isUpdate);


                // setState(() {
                //   // addProductController.loadingController.loading.value = false;

                // });
              */
            }
          },
          icon: const Icon(
            Icons.cloud_upload,
            color: AppColors.green,
          ),
        )
      ],
    );
  }

  Widget _buildImagePickerButton() {
    return CustomElevatedButton(
      onPressed: () {
        addProductController.uploadProductImage(ImageSource.gallery);

        addProductController.isProductUpdated(true);
      },
      title: AppString.pickImage,
    );
  }

  Form _buildProductForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Obx(
            () => CustomDropdownWidget(
              items: AppConstants.categories,
              value: addProductController
                  .categoryController.selectedCategory.value,
              onChanged: (value) {
                addProductController.categoryController
                    .updateCategory(value!.toString());
                addProductController.isProductUpdated(true);
              },
            ),
          ),
          _buildTextField(addProductController.nameTEC, AppString.productName,
              Validators.validateProductName),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                    addProductController.priceTEC,
                    AppString.price,
                    (value) => Validators.validateProductNotEmpty(
                        value, AppString.price),
                    TextInputType.number),
              ),
              AppsFunction.horizontalSpace(20),
              Expanded(
                  child: Obx(
                () => CustomDropdownWidget(
                  onChanged: (value) {
                    addProductController.categoryController
                        .updateUnit(value!.toString());
                    addProductController.isProductUpdated(true);
                  },
                  items: AppConstants.units,
                  value: addProductController
                      .categoryController.selectedUnit.value,
                ),
              )),
            ],
          ),
          _buildTextField(
              addProductController.discountTEC,
              AppString.discount,
              (value) =>
                  Validators.validateProductNotEmpty(value, AppString.discount),
              TextInputType.number),
          _buildTextField(
              addProductController.ratingTEC,
              AppString.ratting,
              (value) =>
                  Validators.validateProductNotEmpty(value, AppString.ratting),
              TextInputType.number),
          _buildTextField(
              addProductController.descriptionTEC,
              AppString.description,
              (value) => Validators.validateProductNotEmpty(
                  value, AppString.description),
              TextInputType.text,
              null),
        ],
      ),
    );
  }

  TextFormFieldWidget _buildTextField(TextEditingController controller,
      String hintText, String? Function(String?)? validator,
      [TextInputType text = TextInputType.text, int? maxLines = 1]) {
    return TextFormFieldWidget(
      onChanged: (value) => addProductController.trackInputChanges(),
      validator: validator,
      controller: controller,
      hintText: hintText,
      textInputType: text,
      maxLines: maxLines,
    );
  }
}
