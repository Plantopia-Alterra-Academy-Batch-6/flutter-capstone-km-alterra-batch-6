part of '../weather_view.dart';

class PermissionLocationWidget extends StatelessWidget {
  final Function()? onPressed;
  const PermissionLocationWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Izin Lokasi Ditolak",
            style: TextStyleConstant.paragraph.copyWith(
              color: ColorConstant.danger500,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: ColorConstant.primary500,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: onPressed,
            child: Text(
              "Minta Izin Lokasi Lagi",
              style: TextStyleConstant.paragraph.copyWith(
                color: ColorConstant.link50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
