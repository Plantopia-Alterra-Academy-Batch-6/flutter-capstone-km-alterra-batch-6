part of 'current_weather_card_widget.dart';

class CurrentWeatherLocationWidget extends StatelessWidget {
  final String? locationName;
  final String? locationCode;

  const CurrentWeatherLocationWidget({
    super.key,
    required this.locationName,
    required this.locationCode,
  });

  @override
  Widget build(BuildContext context) {
    final countryName = CountryCode.fromCountryCode(
          locationCode ?? '',
        ).name ??
        '';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          IconConstant.locationAlt,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          '$locationName, $countryName',
          style: TextStyleConstant.paragraph.copyWith(
            fontWeight: FontWeight.w700,
            color: ColorConstant.neutral0,
          ),
        ),
      ],
    );
  }
}
