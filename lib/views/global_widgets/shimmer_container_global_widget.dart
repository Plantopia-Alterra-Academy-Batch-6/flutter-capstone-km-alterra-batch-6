import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainerGlobalWidget extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  
  const ShimmerContainerGlobalWidget({
    super.key, required this.width, required this.height, required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        // rectangleiAQ (12:690)
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: const LinearGradient(
            begin: Alignment(-1.484, -0.15),
            end: Alignment(1.319, -0.218),
            colors: <Color>[
              Color(0xfff1efef),
              Color(0xfff8f7f7),
              Color(0xffe7e5e5)
            ],
            stops: <double>[0, 0.531, 0.992],
          ),
        ),
      ),
    );
  }
}