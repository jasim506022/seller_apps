import '../../../model/onboard_model.dart';
import '../../../res/app_asset/image_asset.dart';
import '../../../res/app_string.dart';

class OnBoardingListData {
  static List<OnboardModel> getOnboardingData() => [
        OnboardModel(
          image: AppImage.onboardingFirstImage,
          title: AppStrings.onboardingTitle1,
          description: AppStrings.onboardingDescription1,
        ),
        OnboardModel(
          image: AppImage.onboardingSecondImage,
          title: AppStrings.onboardingTitle2,
          description: AppStrings.onboardingDescription2,
        ),
        OnboardModel(
          image: AppImage.onboardingThirdImage,
          title: AppStrings.onboardingTitle3,
          description: AppStrings.onboardingDescription3,
        )
      ];
}
