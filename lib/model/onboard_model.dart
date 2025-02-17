import 'package:seller_apps/res/app_asset/image_asset.dart';
import 'package:seller_apps/res/app_string.dart';

class OnboardModel {
  String img;
  String text;
  String desc;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
  });
}

List<OnboardModel> onboardingData = [
  OnboardModel(
    img: AppImage.groceryImage,
    text: AppStrings.welcome,
    desc: AppStrings.firstOnboardingDescription,
  ),
  OnboardModel(
    img: AppImage.allGroceryImage,
    text: AppStrings.fresshFruis,
    desc: AppStrings.secondOnboardingDescription,
  ),
  OnboardModel(
    img: AppImage.deliveryImage,
    text: AppStrings.quickDelivery,
    desc: AppStrings.thirdOnboardingDescription,
  )
];
