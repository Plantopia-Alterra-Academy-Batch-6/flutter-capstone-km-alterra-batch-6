import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';

class PlantFilterResultSkeletonWidget extends StatelessWidget {
  const PlantFilterResultSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => const ShimmerContainerGlobalWidget(
          width: 156,
          height: 200,
          radius: 30,
        ),
      ),
    );
  }
}
