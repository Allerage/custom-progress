import 'package:flutter/material.dart';
import 'package:ispeak/utils/constant.dart';

class CustomLinearProgress extends StatefulWidget {
  final double width;
  final double height;
  final double progress;
  final LinearGradient gradient;
  final Color unprogress;
  final bool isanimated;

  const CustomLinearProgress(
      {required this.height,
      required this.progress,
      required this.width,
      required this.gradient,
      required this.unprogress,
      required this.isanimated});
  @override
  _CustomLinearProgressState createState() => _CustomLinearProgressState();
}

class _CustomLinearProgressState extends State<CustomLinearProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _linearProgress;
  late Animation<double> _progressvalue;
  double? percentage;
  @override
  void initState() {
    super.initState();
    _linearProgress =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _progressvalue = Tween(begin: 0.0, end: widget.progress)
        .animate(CurvedAnimation(parent: _linearProgress, curve: Curves.easeIn))
          ..addListener(() {
            setState(() {
              percentage = _progressvalue.value;
            });
          });
    if (widget.isanimated) {
      _linearProgress.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isanimated) {
      var animated = (percentage! / 100) * widget.width;
      return Container(
        decoration: BoxDecoration(
            color: widget.unprogress,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        width: widget.width,
        height: widget.height,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: widget.gradient,
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              width: animated,
            )
          ],
        ),
      );
    } else {
      percentage = (widget.progress / 100) * widget.width;
      print(percentage);
      return Container(
        decoration: BoxDecoration(
            color: widget.unprogress,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        width: widget.width,
        height: widget.height,
        child: AnimatedContainer(
          duration: Duration(seconds: 3),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: widget.gradient,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                width: percentage,
              )
            ],
          ),
        ),
      );
    }
  }
}
