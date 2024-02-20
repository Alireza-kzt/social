import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class ShimmerShape extends StatelessWidget {
  final double? height, width, radius;


  const ShimmerShape({Key? key, this.height,  this.width, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: ShapeDecoration(
        color: Colors.grey,
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: radius ?? 16,
            cornerSmoothing: 1,
          ),
        ),
      ),
    );
  }
}
