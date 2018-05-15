import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Gauge Test',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: new Scaffold(
        // appBar: new AppBar(
        //   title: const Text('Gague'),
        // ),
        body: new Container(
          decoration: new BoxDecoration(
            color: Colors.black,
            border: new Border.all(
              color: Colors.black,
            ),
          ),
          child: new Center(
            child: new Gauge()
          ),
        ),
      )
    );
  }
}

class Gauge extends StatefulWidget {
  @override
  GaugePosition createState() => new GaugePosition();
}

class GaugePosition extends State<Gauge> {
  double xPos = 170.0;
  double yPos = 160.0;
  
  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: new BoxConstraints.expand(),
      child: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: new CustomPaint(
          size: new Size(xPos, yPos),
          painter: new GaugePainter(xPos, yPos),
        ),
      ),
    );
  }
}

class GaugePainter extends CustomPainter {
  static const markerRadius = 120.0;
  final double xPos;
  final double yPos;

  GaugePainter(this.xPos, this.yPos);

  @override
  void paint(Canvas canvas, Size size) {

    final paintCircle = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final paintScale = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      // ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;
    
    final paintNeedle = new Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0;

    // Gauge Scale 
    Path path = new Path();
    path.addArc(new Rect.fromCircle(center: new Offset(xPos, yPos), radius: markerRadius-30), 90.0, 225.0);
    path.addArc(new Rect.fromCircle(center: new Offset(xPos*3, yPos), radius: markerRadius-30), 90.0, 225.0);
    canvas.drawPath(path, paintScale);
    
    canvas.drawCircle(new Offset(xPos, yPos), markerRadius, paintCircle);
    canvas.drawLine(new Offset(xPos, yPos), new Offset(xPos-90, yPos), paintNeedle);

    canvas.drawCircle(new Offset(xPos*3, yPos), markerRadius, paintCircle);
    canvas.drawLine(new Offset(xPos*3, yPos), new Offset((xPos*3)-90, yPos), paintNeedle);
  }


  @override
  bool shouldRepaint(GaugePainter old) => xPos != old.xPos && yPos !=old.yPos;
}