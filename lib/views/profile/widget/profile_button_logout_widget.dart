part of '../profile_view.dart';

class ProfileButtonLogoutWidget extends StatelessWidget {
  const ProfileButtonLogoutWidget({super.key});

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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: ColorConstant.neutral100,
                  title: Text(
                    "Log Out",
                    style: TextStyleConstant.heading4
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  content: Text(
                    "Are you sure to logout?",
                    style: TextStyleConstant.subtitle,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "No",
                        style: TextStyleConstant.subtitle.copyWith(
                          color: ColorConstant.danger500,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await UserTokenPref.clearToken();
                        Get.back();
                        Get.offAllNamed(AppRoutes.auth);
                      },
                      child: Text(
                        "Yes",
                        style: TextStyleConstant.subtitle.copyWith(
                          color: ColorConstant.primary900,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Text(
            'Log Out',
            style: TextStyleConstant.subtitle.copyWith(
                fontWeight: FontWeight.w700, color: ColorConstant.danger500),
          ),
        ),
      ),
    );
  }
}
