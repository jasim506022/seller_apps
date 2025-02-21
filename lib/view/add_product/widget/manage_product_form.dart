import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_apps/res/network_utilis.dart';

import '../../../controller/manage_product_controller.dart';

import '../../../res/app_constants.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_color.dart';
import '../../../res/validator.dart';
import '../../../widget/app_button.dart';
import '../../../widget/custom_drop_down_widget.dart';
import '../../../widget/custom_text_form_field.dart';
import 'grid_image_list_widget.dart';

/// Screen for adding or editing a product.
/// Uses [GetX] for state management.
class ManageProductForm extends StatefulWidget {
  const ManageProductForm({
    super.key,
    required this.isEditMode,
  });

  /// Indicates whether the form is in edit mode.
  final bool isEditMode;

  @override
  State<ManageProductForm> createState() => _ManageProductFormState();
}

class _ManageProductFormState extends State<ManageProductForm> {
  /// Form key for validation.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Controller for managing product-related operations.
  late final ManageProductController manageProductController;

  @override
  void initState() {
    manageProductController = Get.find<ManageProductController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap.
      child: PopScope(
        canPop: false,
        //Hand Unsave Change On Back
        onPopInvoked: (didPop) =>
            manageProductController.handleUnsavedChangesOnBack(didPop),
        child: Scaffold(
            appBar: _buildAppBar(),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: ListView(
                  children: [
                    // Show loading indicator when uploading.
                    Obx(() {
                      return manageProductController
                              .loadingController.loading.value
                          ? const LinearProgressIndicator()
                          // Use this to avoid rendering anything when not loading.
                          : const SizedBox.shrink();
                    }),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      child: Column(
                        children: [
                          const GridImageListWidget(),
                          AppsFunction.verticalSpacing(10),
                          _buildImagePickerButton(),
                          AppsFunction.verticalSpacing(20),
                          _buildProductForm(),
                          AppsFunction.verticalSpacing(120),
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }

  /// Builds the app bar with title and upload action.
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(widget.isEditMode
          ? AppStrings.updateProductTitle
          : AppStrings.addNewProductTitle),
      actions: [
        IconButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                NetworkUtils.executeWithInternetCheck(
                    action: () => manageProductController.saveProduct(
                        isUpdate: widget.isEditMode));
              }
            },
            icon: const Icon(
              Icons.cloud_upload,
              color: AppColors.green,
            ))
      ],
    );
  }

  Widget _buildImagePickerButton() {
    return AppButton(
        title: AppStrings.btnPickImage,
        onPressed: () {
          manageProductController.pickProductImage(ImageSource.gallery);
        });
  }

  Form _buildProductForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomDropdownWidget(
            items: AppConstants.categories,
            value: manageProductController
                .categoryController.selectedCategory.value,
            onChanged: (value) {
              manageProductController.categoryController
                  .updateCategory(value!.toString());
              manageProductController.hasProductsChanged(true);
            },
          ),
          AppsFunction.verticalSpacing(10),
          CustomTextFormField(
              onChanged: (value) => manageProductController.trackInputChanges(),
              controller: manageProductController.nameController,
              label: AppStrings.productNameLabel,
              hintText: AppStrings.productNameHint,
              validator: Validators.validateProductName),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: CustomTextFormField(
                    onChanged: (value) =>
                        manageProductController.trackInputChanges(),
                    controller: manageProductController.priceController,
                    label: AppStrings.priceLabel,
                    hintText: AppStrings.productPriceHint,
                    validator: Validators.validatePrice,
                    textInputType: TextInputType.number),
              ),
              AppsFunction.horizontalSpacing(20),
              Expanded(
                  flex: 5,
                  child: CustomDropdownWidget(
                    onChanged: (value) {
                      manageProductController.categoryController
                          .updateUnit(value!.toString());
                      manageProductController.hasProductsChanged(true);
                    },
                    items: AppConstants.units,
                    value: manageProductController
                        .categoryController.selectedUnit.value,
                  )),
            ],
          ),
          CustomTextFormField(
              onChanged: (value) => manageProductController.trackInputChanges(),
              controller: manageProductController.discountController,
              label: AppStrings.discountLabel,
              hintText: AppStrings.productDiscountHint,
              validator: Validators.validateRating,
              textInputType: TextInputType.number),
          CustomTextFormField(
              onChanged: (value) => manageProductController.trackInputChanges(),
              controller: manageProductController.ratingController,
              hintText: AppStrings.ratingLabel,
              label: AppStrings.productRatingHint,
              validator: Validators.validateDiscount,
              textInputType: TextInputType.number),
          CustomTextFormField(
              onChanged: (value) => manageProductController.trackInputChanges(),
              controller: manageProductController.descriptionController,
              label: AppStrings.descriptionLabel,
              hintText: AppStrings.productDescriptionHint,
              validator: Validators.validateProductDescription,
              textInputType: TextInputType.text,
              maxLines: 7),
        ],
      ),
    );
  }
}
