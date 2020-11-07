import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class ThreeDotsWidget extends StatelessWidget {
  final int step;

  const ThreeDotsWidget({@required this.step});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          step == 0 ? "dev_images/fill_dot.svg" : "dev_images/empty_dot.svg",
          width: 8,
          height: 8,
          placeholderBuilder: (context) => Container(),
        ),
        SizedBox(
          width: 3,
        ),
        SvgPicture.asset(
          step == 1 ? "dev_images/fill_dot.svg" : "dev_images/empty_dot.svg",
          width: 8,
          height: 8,
          placeholderBuilder: (context) => Container(),
        ),
        SizedBox(
          width: 3,
        ),
        SvgPicture.asset(
          step == 2 ? "dev_images/fill_dot.svg" : "dev_images/empty_dot.svg",
          width: 8,
          height: 8,
          placeholderBuilder: (context) => Container(),
        ),
      ],
    );
  }
}
