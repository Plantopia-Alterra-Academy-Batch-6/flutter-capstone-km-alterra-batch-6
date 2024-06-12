// import 'dart:math';
// import 'package:flutter/material.dart';

// class DashedContainerWidget extends StatelessWidget {
//   final double width;
//   final double height;
//   final Widget child;

//   const DashedContainerWidget({
//     super.key,
//     required this.width,
//     required this.height,
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(width, height),
//       painter: DashedRectPainter(),
//       child: Container(
//         width: width,
//         height: height,
//         child: child,
//       ),
//     );
//   }
// }

// class DashedRectPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 1.0
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     const double dashWidth = 20.0;
//     const double dashSpace = 20.0;
//     const double borderRadius = 16.0;

//     double startX = 0.0;
//     while (startX < size.width) {
//       canvas.drawLine(
//         Offset(startX, 0.0),
//         Offset(startX + dashWidth, 0.0),
//         paint,
//       );
//       startX += dashWidth + dashSpace;
//     }

//     double startY = 0.0;
//     while (startY < size.height) {
//       canvas.drawLine(
//         Offset(size.width, startY),
//         Offset(size.width, startY + dashWidth),
//         paint,
//       );
//       startY += dashWidth + dashSpace;
//     }

//     startX = size.width;
//     while (startX > 0.0) {
//       canvas.drawLine(
//         Offset(startX, size.height),
//         Offset(startX - dashWidth, size.height),
//         paint,
//       );
//       startX -= dashWidth + dashSpace;
//     }

//     startY = size.height;
//     while (startY > 0.0) {
//       canvas.drawLine(
//         Offset(0.0, startY),
//         Offset(0.0, startY - dashWidth),
//         paint,
//       );
//       startY -= dashWidth + dashSpace;
//     }

//     final borderPaint = Paint()
//       ..color = Colors.transparent
//       ..strokeWidth = 1.0
//       ..style = PaintingStyle.stroke;
//     final borderPath = Path()
//       ..moveTo(borderRadius, 0)
//       ..lineTo(size.width - borderRadius, 0)
//       ..arcTo(
//         Rect.fromCircle(
//           center: Offset(size.width - borderRadius, borderRadius),
//           radius: borderRadius,
//         ),
//         -0.5 * pi,
//         0.5 * pi,
//         false,
//       )
//       ..lineTo(size.width, size.height - borderRadius)
//       ..arcTo(
//         Rect.fromCircle(
//           center: Offset(size.width - borderRadius, size.height - borderRadius),
//           radius: borderRadius,
//         ),
//         0.0,
//         0.5 * pi,
//         false,
//       )
//       ..lineTo(borderRadius, size.height)
//       ..arcTo(
//         Rect.fromCircle(
//           center: Offset(borderRadius, size.height - borderRadius),
//           radius: borderRadius,
//         ),
//         0.5 * pi,
//         0.5 * pi,
//         false,
//       )
//       ..lineTo(0, borderRadius)
//       ..arcTo(
//         Rect.fromCircle(
//           center: const Offset(borderRadius, borderRadius),
//           radius: borderRadius,
//         ),
//         pi,
//         0.5 * pi,
//         false,
//       )
//       ..close();
//     canvas.drawPath(borderPath, borderPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
