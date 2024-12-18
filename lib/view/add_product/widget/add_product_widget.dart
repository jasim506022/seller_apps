import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/add_product_controller.dart';
import '../../../controller/category_controller.dart';

import '../../../res/app_constants.dart';
import '../../../res/apps_color.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/internet_utilis.dart';
import '../../../widget/drop_down_category_widget.dart';
import '../../../widget/text_field_form_widget.dart';
import 'grid_image_list_widget.dart';

class AddProductWidget extends StatefulWidget {
  const AddProductWidget({super.key, this.isUpdate});
  final bool? isUpdate;
  @override
  State<AddProductWidget> createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  final addProductController = Get.put(AddProductController());
  final categoryController = Get.find<CategoryController>();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          addProductController.handleBackNavigaion(didPop);
        },
        child: Scaffold(
            appBar: AppBar(
              title: widget.isUpdate == true
                  ? const Text(
                      "Update Product",
                    )
                  : const Text(
                      "Add New Product",
                    ),
              actions: [
                IconButton(
                  onPressed: () async {
                    if (_keyForm.currentState!.validate()) {
                      if (!(await NetworkUtili.verifyInternetStatus())) {
                        addProductController.uploadProduct(
                            isUpdate: widget.isUpdate!);
                      }
                    }
                  },
                  icon: const Icon(
                    Icons.cloud_upload,
                    color: AppColors.green,
                  ),
                )
              ],
            ),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Obx(
                  () => ListView(
                    children: [
                      if (addProductController.loadingController.loading.value)
                        const LinearProgressIndicator(
                          backgroundColor: AppColors.red,
                        ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 5.h),
                        child: Column(
                          children: [
                            const GridImageListWidget(),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.green,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.h, vertical: 10.w)),
                                onPressed: () {
                                  addProductController
                                      .uploadProductImage(ImageSource.gallery);
                                },
                                child: Text(
                                  "Pick Image",
                                  style: AppsTextStyle.buttonTextStyle,
                                )),
                            SizedBox(
                              height: 20.h,
                            ),
                            _productForm(),
                            SizedBox(height: 0.2.sh)
                          ],
                        ),
                      ),
                    ],
                  ),
                ))),
      ),
    );
  }

  Form _productForm() {
    return Form(
      key: _keyForm,
      child: Column(
        children: [
          DropdownCategoryWidget(
            list: AppConstants.categoryList,
            value: categoryController.category,
            onChanged: (value) {
              addProductController.addChangeListener();
              categoryController.setCategory(value!.toString());
            },
          ),
          _buildTextField(
              addProductController.nameTEC, 'Product Name', _validateName),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                    addProductController.priceTEC,
                    'Product Price',
                    (value) => _validateNotEmpty(value, 'Product Price'),
                    TextInputType.number),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                  child: DropdownCategoryWidget(
                onChanged: (value) {
                  addProductController.addChangeListener();
                  categoryController.setUnit(value!.toString());
                },
                list: AppConstants.unitList,
                value: categoryController.unit,
              )),
            ],
          ),
          _buildTextField(
              addProductController.discountTEC,
              'Discount',
              (value) => _validateNotEmpty(value, 'Discount'),
              TextInputType.number),
          _buildTextField(
              addProductController.ratingTEC,
              'Rating',
              (value) => _validateNotEmpty(value, 'Rating'),
              TextInputType.number),
          _buildTextField(
              addProductController.descriptionTEC,
              'Description',
              (value) => _validateNotEmpty(value, 'Description'),
              TextInputType.text,
              null),
        ],
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return "Please enter Product Name";
    if (value.length <= 2) {
      return "Product Name must be longer than 2 characters";
    }
    return null;
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) return "Please enter your $fieldName.";
    return null;
  }

  TextFormFieldWidget _buildTextField(TextEditingController controller,
      String hintText, String? Function(String?)? validator,
      [TextInputType text = TextInputType.text, int? maxLines = 1]) {
    return TextFormFieldWidget(
      onChanged: (p0) => addProductController.addChangeListener(),
      validator: validator,
      controller: controller,
      hintText: hintText,
      textInputType: text,
      maxLines: maxLines,
    );
  }
}
