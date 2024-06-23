part of '../home_view.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({super.key});
  String getGreeting() {
    final DateTime now = DateTime.now();
    final int hour = now.hour;

    if (hour >= 6 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 18) {
      return 'Good Afternoon';
    } else if (hour >= 18 && hour < 22) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    authController.getUser();
    String greeting = getGreeting();
    print('user  id ${authController.currentUser.value?.id}');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => authController.isLoading.value
              ? Row(
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
                          "$greeting,",
                          style: TextStyleConstant.subtitle.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const ShimmerContainerGlobalWidget(
                          width: 100,
                          height: 18,
                          radius: 0,
                        ),
                      ],
                    ),
                  ],
                )
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
                          "$greeting,",
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
