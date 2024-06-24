part of '../profile_view.dart';

class ProfileAccountWidget extends StatelessWidget {
  const ProfileAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style:
              TextStyleConstant.subtitle.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        ProfileSettingItemWidget(
          icon: IconConstant.profile,
          title: 'Account Settings',
          onTap: () {
            Get.snackbar(
              'Notice',
              'Account Settings coming soon',
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
          icon: IconConstant.manageNotification,
          title: 'Manage Notification',
          onTap: () {
            Get.toNamed(AppRoutes.notification);
          },
        ),
        const Divider(),
        ProfileSettingItemWidget(
          icon: IconConstant.setLanguage,
          title: 'Set Language',
          onTap: () {
            Get.snackbar(
              'Notice',
              'Set Language  coming soon',
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
          icon: IconConstant.inviteFriends,
          title: 'Invite Friends',
          onTap: () {
            Get.snackbar(
              'Notice',
              'Invite Friends coming soon',
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
