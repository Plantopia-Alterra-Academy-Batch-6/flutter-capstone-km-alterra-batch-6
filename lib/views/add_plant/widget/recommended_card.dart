import 'package:flutter/material.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/views/global_widgets/card_global_widget.dart';

class RecommendedCardWidget extends StatelessWidget {
  const RecommendedCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recommended",
          style: TextStyleConstant.title.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemExtent: 156,
              itemBuilder: (context, int index) {
                return const Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: CardGlobalWidget(
                      plantName: '',
                      plantCategory: '',
                      plantImageUrl: '',
                    ));
              }),
        )
      ],
    );
  }
}
