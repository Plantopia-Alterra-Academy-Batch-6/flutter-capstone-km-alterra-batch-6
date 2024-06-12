part of '../profile_view.dart';

class ProfileSettingItemWidget extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const ProfileSettingItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        width: 15,
        height: 20,
      ),
      title: Text(title, style: TextStyleConstant.subtitle),
      onTap: onTap,
    );
  }
}
