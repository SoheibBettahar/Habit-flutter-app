import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItemNumberOfDaysWidget extends StatelessWidget {
  ListItemNumberOfDaysWidget(
      {@required this.days, @required this.color, this.size});

  final int days;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 6 / 5,
      height: size,
      child: LayoutBuilder(builder: (context, boxConstraints) {
        return Stack(
          children: [
            Positioned(
              child: Text(
                "$days",
                style: GoogleFonts.poppins(
                    fontSize: size / 1.8,
                    fontWeight: FontWeight.bold,
                    color: color),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Transform.rotate(
                    angle: pi / 8,
                    child: Text(
                      "/",
                      style: TextStyle(
                          fontSize: boxConstraints.maxHeight / 1.5,
                          fontWeight: FontWeight.bold,
                          color: color),
                    ),
                  ),
                  Text(
                    "90",
                    style: TextStyle(
                        fontSize: boxConstraints.maxHeight / 3, color: color),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
