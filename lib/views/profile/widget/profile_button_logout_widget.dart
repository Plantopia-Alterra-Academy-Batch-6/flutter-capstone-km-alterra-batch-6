part of '../profile_view.dart';

class ProfileButtonLogoutWidget extends StatelessWidget {
  final ProfileController profileController;

  const ProfileButtonLogoutWidget({super.key, required this.profileController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 328,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.danger100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          onPressed: () {
            Get.dialog(
              Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: ColorConstant.neutral950.withOpacity(0.5),
                    ),
                  ),
                  Center(
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: ColorConstant.white,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            ImageConstant.g12,
                            width: 130,
                            height: 100,
                          ),
                          Text(
                            "Are you sure you want to log out?",
                            textAlign: TextAlign.center,
                            style: TextStyleConstant.heading4.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Don't worry, all of your progress will be saved",
                            textAlign: TextAlign.center,
                            style: TextStyleConstant.paragraph.copyWith(),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyleConstant.subtitle.copyWith(
                                    color: ColorConstant.primary500,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstant.danger500,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () async {
                                  await profileController
                                      .logout(); 
                                },
                                child: Text(
                                  "Log Out",
                                  style: TextStyleConstant.subtitle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              barrierDismissible: false,
            );
          },
          child: Text(
            'Log Out',
            style: TextStyleConstant.subtitle.copyWith(
              fontWeight: FontWeight.w700,
              color: ColorConstant.danger500,
            ),
          ),
        ),
      ),
    );
  }
}
