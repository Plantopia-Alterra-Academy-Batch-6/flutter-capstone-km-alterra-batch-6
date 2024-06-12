part of '../profile_view.dart';

class ProfileCustomAppBarWidget extends StatelessWidget {
  const ProfileCustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile',
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    32,
                  ),
                  color: ColorConstant.primary400,
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: ColorConstant.neutral0,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authController.currentUser.value?.name ?? '',
                    style: TextStyleConstant.title
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '10 Plants Owned',
                    style: TextStyleConstant.subtitle
                        .copyWith(color: ColorConstant.neutral500),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: SvgPicture.asset(
                  IconConstant.editPencil,
                  width: 20,
                  height: 20,
                ),
                onPressed: () {
                  Get.snackbar(
                    'Notice',
                    'Edit profile coming soon',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
