import 'package:flutter/widgets.dart';

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();

    //start: top left point
    path.lineTo(width * 1 / 15, 0);

    //top left point -> top right point
    path.lineTo(width, 0);

    //top right point -> bottom right point
    path.lineTo(width * 14 / 15, height);

    //bottom right point -> bottom left point
    path.lineTo(0, height);

    //bottom left point -> top left point
    path.lineTo(width * 1 / 15, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
