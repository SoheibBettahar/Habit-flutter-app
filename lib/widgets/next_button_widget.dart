import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit/utils/styles.dart';

class NextButtonWidget extends StatelessWidget {
  final Function onPress;
  final String text;
  const NextButtonWidget({@required this.onPress, @required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                  color: onBoardingButtonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(
              width: 4,
            ),
            Icon(
              FontAwesomeIcons.chevronRight,
              size: 12,
              color: onBoardingButtonColor,
            )
          ],
        ),
      ),
    );
  }
}
