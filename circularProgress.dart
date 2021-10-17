import 'package:flutter/material.dart';
import 'package:ispeak/utils/constant.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class CustomCircularProgress extends StatefulWidget {
  final double progress;
  final double height;
  final Color nonprogresscolor;
  final LinearGradient gradient;
  final double? strokeWidth;

  const CustomCircularProgress(
      {Key? key,
      required this.progress,
      required this.height,
      required this.nonprogresscolor,
      required this.gradient,
      this.strokeWidth})
      : super(key: key);
  @override
  _CustomCircularProgressState createState() => _CustomCircularProgressState();
}

//TODO Implement circualr image follower
class _CustomCircularProgressState extends State<CustomCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _circularProgress;
  late Animation<double> _progressvalue;
  double progressDegree = 0;
  @override
  void initState() {
    super.initState();
    _circularProgress =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _progressvalue = Tween(begin: 0.0, end: 360.0).animate(
        CurvedAnimation(parent: _circularProgress, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          progressDegree = widget.progress * _progressvalue.value;
          print(progressDegree);
        });
      });
    _circularProgress.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _circularProgress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPaint(
              child: Container(
                width: widget.height,
                height: widget.height,
              ),
              painter: CircularPainter(progressDegree, widget.gradient,
                  widget.nonprogresscolor, widget.strokeWidth ?? 20.0))
        ],
      ),
    );
  }
}

class CircularPainter extends CustomPainter {
  final double progressinDegree;
  final LinearGradient gradient;
  final Color unprogress;
  final double strokewidth;

  CircularPainter(
    this.progressinDegree,
    this.gradient,
    this.unprogress,
    this.strokewidth,
  );
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = unprogress
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokewidth;
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);
    Paint progressPaint = Paint()
      ..shader = gradient
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokewidth;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressinDegree),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
