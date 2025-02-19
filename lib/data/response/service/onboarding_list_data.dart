import '../../../model/onboard_model.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../res/app_string.dart';

class OnBoardingListData {
  static List<OnboardModel> getOnboardingData() => [
        OnboardModel(
          image: AppImage.onboardingFirstImage,
          title: AppStrings.welcome,
          description: AppStrings.firstOnboardingDescription,
        ),
        OnboardModel(
          image: AppImage.onboardingSecondImage,
          title: AppStrings.fresshFruits,
          description: AppStrings.secondOnboardingDescription,
        ),
        OnboardModel(
          image: AppImage.onboardingThirdImage,
          title: AppStrings.quickDelivery,
          description: AppStrings.thirdOnboardingDescription,
        )
      ];
}
