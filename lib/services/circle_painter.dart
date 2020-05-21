//circle_painter.dart
import 'package:flutter/material.dart';
class Circle extends StatefulWidget {
  final Map<String, double> center;
  final double radius;
Circle({this.center, this.radius});
@override
  _CircleState createState() => _CircleState();
}
class _CircleState extends State<Circle> with SingleTickerProviderStateMixin {
  AnimationController _controller;
@override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }
@override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
@override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      painter: DrawCircle(center: widget.center, radius: widget.radius),
    );
  }
}    
class DrawCircle extends CustomPainter {
  Map<String, double> center;
  double radius;
DrawCircle({this.center, this.radius});
@override
  void paint(Canvas canvas, Size size) {
    Paint brush = new Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 30;

canvas.drawCircle(Offset(center["x"], center["y"]), radius, brush);
  }
@override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}


class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 100.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }
}
