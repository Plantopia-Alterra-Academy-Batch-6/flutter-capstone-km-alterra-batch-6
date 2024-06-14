part of '../profile_view.dart';

class ProfileAboutTheAppWidget extends StatelessWidget {
  const ProfileAboutTheAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About the App',
          style:
              TextStyleConstant.subtitle.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        ProfileSettingItemWidget(
          icon: IconConstant.appInfo,
          title: 'App Info',
          onTap: () {
            Get.snackbar(
              'Notice',
              'App Info coming soon',
              backgroundColor: ColorConstant.primary500,
              colorText: ColorConstant.neutral100,
              snackPosition: SnackPosition.BOTTOM,
              borderRadius: 16,
              margin: const EdgeInsets.all(16),
              borderWidth: 2,
              borderColor: ColorConstant.neutral100,
              isDismissible: true,
              duration: const Duration(seconds: 2),
              animationDuration: const Duration(milliseconds: 400),
              forwardAnimationCurve: Curves.fastOutSlowIn,
              reverseAnimationCurve: Curves.easeOut,
              icon: Icon(
                Icons.info_outline,
                color: ColorConstant.neutral0,
              ),
              shouldIconPulse: true,
            );
          },
        ),
        const Divider(),
        ProfileSettingItemWidget(
          icon: IconConstant.rateApp,
          title: 'Rate App',
          onTap: () {
            Get.snackbar(
              'Notice',
              'Rate App coming soon',
              backgroundColor: ColorConstant.primary500,
              colorText: ColorConstant.neutral100,
              snackPosition: SnackPosition.BOTTOM,
              borderRadius: 16,
              margin: const EdgeInsets.all(16),
              borderWidth: 2,
              borderColor: ColorConstant.neutral100,
              isDismissible: true,
              duration: const Duration(seconds: 2),
              animationDuration: const Duration(milliseconds: 400),
              forwardAnimationCurve: Curves.fastOutSlowIn,
              reverseAnimationCurve: Curves.easeOut,
              icon: Icon(
                Icons.info_outline,
                color: ColorConstant.neutral0,
              ),
              shouldIconPulse: true,
            );
          },
        ),
        const Divider(),
        ProfileSettingItemWidget(
          icon: IconConstant.privacyPolicy,
          title: 'Privacy Policy',
          onTap: () {
            Get.snackbar(
              'Notice',
              'Privacy Policy coming soon',
              backgroundColor: ColorConstant.primary500,
              colorText: ColorConstant.neutral100,
              snackPosition: SnackPosition.BOTTOM,
              borderRadius: 16,
              margin: const EdgeInsets.all(16),
              borderWidth: 2,
              borderColor: ColorConstant.neutral100,
              isDismissible: true,
              duration: const Duration(seconds: 2),
              animationDuration: const Duration(milliseconds: 400),
              forwardAnimationCurve: Curves.fastOutSlowIn,
              reverseAnimationCurve: Curves.easeOut,
              icon: Icon(
                Icons.info_outline,
                color: ColorConstant.neutral0,
              ),
              shouldIconPulse: true,
            );
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
