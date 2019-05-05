import 'package:flutter/material.dart';
class MyProgressPainter extends CustomPainter {
  final Color color;
  final int count;
  final List<Animation<double>>animators;

  MyProgressPainter(this.color, this.count, this.animators);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = size.width / (3 * count + 1);
    var paint = new Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    for (int i = 1; i < count + 1; i++) {
      double value = animators[i - 1].value;
      canvas.drawCircle(
          new Offset(radius * i * 3 - radius, size.height / 2),
          radius * (value > 1 ? (2 - value) : value), paint);
    }
  }
 
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }







}
