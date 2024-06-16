part of '../home_view.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    authController.getUser();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => authController.isLoading.value
              ? const CircularProgressIndicator()
              : Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
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
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning,",
                          style: TextStyleConstant.subtitle.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text("${authController.currentUser.value?.name}",
                            style: TextStyleConstant.subtitle),
                      ],
                    ),
                  ],
                ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.notification);
          },
          child: SvgPicture.asset(
            IconConstant.notification,
            height: 24,
            width: 24,
          ),
        ),
      ],
    );
  }
}
