import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const TWO_PI = pi * 2;

class CustomProgressWidget extends StatelessWidget {
  const CustomProgressWidget({
    Key key,
    @required this.fillSize,
    @required this.completedProgressColor,
    @required this.emptyProgressColor,
    @required this.strokeSize,
    @required this.fillColor,
    @required this.textColor,
    @required this.textSize,
    @required this.topNumber,
    @required this.progress,
    @required this.onTap,
  }) : super(key: key);

  final double fillSize;
  final Color completedProgressColor;
  final Color emptyProgressColor;
  final int strokeSize;
  final Color fillColor;
  final Color textColor;
  final double textSize;
  final int topNumber;
  final double progress;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: fillSize,
          height: fillSize,
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (Rect rect) {
                  return SweepGradient(
                    startAngle: 0.0,
                    endAngle: TWO_PI,
                    //0.0 => 0.5 & 0.5 => 1.0
                    stops: [progress / 100, progress / 100],
                    center: Alignment.center,
                    colors: [
                      completedProgressColor,
                      emptyProgressColor,
                    ],
                  ).createShader(rect);
                },
                child: Container(
                  width: fillSize,
                  height: fillSize,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
              Center(
                child: Container(
                  height: fillSize - strokeSize,
                  width: fillSize - strokeSize,
                  decoration:
                      BoxDecoration(color: fillColor, shape: BoxShape.circle),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DetailNumberOfDaysWidget(
                      topNumber: topNumber,
                      color: textColor,
                      size: textSize,
                    ),
                    SizedBox(
                      height: textSize / 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailNumberOfDaysWidget extends StatelessWidget {
  DetailNumberOfDaysWidget(
      {@required this.topNumber,
      this.bottomNumber = 90,
      @required this.color,
      this.size});

  final int topNumber;
  final int bottomNumber;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 20 / 15,
      height: size * 20 / 16,
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$topNumber",
                  style:
                      GoogleFonts.poppins(fontSize: size / 1.25, color: color),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Transform.rotate(
                      angle: pi / 6,
                      child: Text(
                        "|",
                        style: TextStyle(
                            fontSize: size / 3,
                            fontWeight: FontWeight.bold,
                            color: color),
                      ),
                    ),
                    Text(
                      "$bottomNumber",
                      style: TextStyle(fontSize: size / 5, color: color),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
