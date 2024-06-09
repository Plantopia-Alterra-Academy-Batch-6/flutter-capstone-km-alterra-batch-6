import 'package:flutter/material.dart';
import 'package:plantopia/views/global_widgets/card_global_widget.dart';

class ListRecomendedPlantWidget extends StatelessWidget {
  const ListRecomendedPlantWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
