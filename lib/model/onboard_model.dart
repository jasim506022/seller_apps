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
    text: AppString.welcome,
    desc: AppString.firstOnboardingDescription,
  ),
  OnboardModel(
    img: AppImage.allGroceryImage,
    text: AppString.fresshFruis,
    desc: AppString.secondOnboardingDescription,
  ),
  OnboardModel(
    img: AppImage.deliveryImage,
    text: AppString.quickDelivery,
    desc: AppString.thirdOnboardingDescription,
  )
];
