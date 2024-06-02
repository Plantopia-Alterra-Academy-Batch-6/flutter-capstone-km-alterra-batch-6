import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

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
          style: TextStyleConstant.regular,
        ),
      ],
    );
  }
}
