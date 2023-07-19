import 'package:flutter/material.dart';

class CustomeImage extends StatelessWidget {
  final String image;
  final double? height, width;
  final BorderRadiusGeometry? borderRadius;
  const CustomeImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * .25,
      width: width ?? MediaQuery.of(context).size.width * .25,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(image),
        ),
      ),
    );
  }
}
