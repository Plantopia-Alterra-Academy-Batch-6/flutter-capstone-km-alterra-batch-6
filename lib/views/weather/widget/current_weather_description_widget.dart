part of 'current_weather_card_widget.dart';

class CurrentWeatherDescriptionWidget extends StatelessWidget {
  final String? description;

  const CurrentWeatherDescriptionWidget({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: ColorConstant.neutral0.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(_toTitleCase(description ?? ''),
          style: TextStyleConstant.caption.copyWith(
            color: ColorConstant.neutral0,
          )),
    );
  }

  String _toTitleCase(String str) {
    if (str.isEmpty) return str;
    return str.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
