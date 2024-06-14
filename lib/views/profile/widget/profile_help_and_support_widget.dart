part of '../profile_view.dart';

class ProfileHelpAndSupportWidget extends StatelessWidget {
  const ProfileHelpAndSupportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Help & Support',
          style:
              TextStyleConstant.subtitle.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        ProfileSettingItemWidget(
          icon: IconConstant.plantBot,
          title: 'Talk with PlantBot',
          onTap: () {},
        ),
        const Divider(),
        ProfileSettingItemWidget(
          icon: IconConstant.help,
          title: 'Help',
          onTap: () {
            Get.snackbar(
              'Notice',
              'Help coming soon',
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
          icon: IconConstant.faq,
          title: 'FAQ',
          onTap: () {
            Get.snackbar(
              'Notice',
              'FAQ coming soon',
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
