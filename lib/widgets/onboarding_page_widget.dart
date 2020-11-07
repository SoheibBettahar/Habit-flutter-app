import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit/models/page.dart';
import 'package:habit/widgets/three_dots_widget.dart';

import 'next_button_widget.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget(
      {@required this.page, this.onPressed, this.buttonText = "Next"});

  final OnBoardingPage page;
  final Function onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Spacer(
          flex: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 27, right: 27),
          child: AspectRatio(
            aspectRatio: 1.27,
            child: SvgPicture.asset(
              page.imagePath,
              placeholderBuilder: (context) => Container(),
            ),
          ),
        ),
        Spacer(
          flex: 5,
        ),
        Text(
          page.title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: 8,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height / 7,
            child: Text(
              page.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ),
        ),
        Spacer(
          flex: 8,
        ),
        Padding(
          padding: EdgeInsets.only(right: 10, left: 20, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ThreeDotsWidget(step: page.id),
              NextButtonWidget(
                onPress: onPressed,
                text: buttonText,
              )
            ],
          ),
        )
      ],
    );
  }
}
