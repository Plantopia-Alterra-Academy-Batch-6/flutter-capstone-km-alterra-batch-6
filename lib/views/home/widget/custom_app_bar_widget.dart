part of '../home_view.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
                Text("Username", style: TextStyleConstant.subtitle),
              ],
            ),
          ],
        ),
        SvgPicture.asset(
          IconConstant.notification,
          height: 24,
          width: 24,
        ),
      ],
    );
  }
}
