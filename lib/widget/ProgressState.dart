import 'package:flutter/material.dart';
import 'package:wan_flutter/widget/MyProgressPainter.dart';

class MyProgress extends StatefulWidget {
  final count;
  final milliseconds;
  final size;

  const MyProgress({Key key, this.count, this.milliseconds, this.size}) : super(key: key);



  @override
  State<StatefulWidget> createState() => ProgressState();
}

class ProgressState extends State<MyProgress> with TickerProviderStateMixin {
  List<Animation<double>> animators = [];
  List<AnimationController> _animationControllers = [];



  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.count; i++) {
      var animationController = new AnimationController(
          vsync: this,
          duration: Duration(milliseconds: widget.milliseconds * widget.count));
      animationController.value = 0.8 * i / widget.count;
      _animationControllers.add(animationController);
      Animation<double> animation =
          new Tween(begin: 0.1, end: 1.9).animate(animationController);
      animators.add(animation);
    }
    animators[0].addListener(_change);
    try {
      var mi = (widget.milliseconds ~/ (animators.length - 1));
      for (int i = 0; i < animators.length; i++) {
        print((mi * i).toString());
        dodelay(_animationControllers[i], mi * i);
      }
    } on Exception {}
  }

  void dodelay(AnimationController _animationControllers, int delay) async {
    Future.delayed(Duration(milliseconds: delay), () {
      _animationControllers..repeat().orCancel;
    });
  }

  void _change() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new CustomPaint(
      painter: new MyProgressPainter(Colors.red, widget.count, animators),
      size: widget.size,
    );
  }

  @override
  void dispose() {
    super.dispose();
    animators[0].removeListener(_change);
    for (AnimationController _animationController in _animationControllers) {
      _animationController.dispose();
    }
  }
}
