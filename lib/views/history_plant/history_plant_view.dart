import 'package:flutter/material.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoryPlantView extends StatelessWidget {
  const HistoryPlantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Planting History",
          style: TextStyleConstant.heading4.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              IconConstant.emptyHistoryPlant,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "No Results",
              style: TextStyleConstant.heading4.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Sorry, there are no results for this search.\nPlease try another phrase",
              style: TextStyleConstant.paragraph,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
