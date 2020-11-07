import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit/cubit/habits/habits_cubit.dart';
import 'package:habit/models/domain_habit.dart';
import 'package:habit/screens/detail_screen.dart';
import 'package:habit/utils/styles.dart';
import 'package:habit/utils/utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'list_item_number_of_days_widget.dart';

class ListItem extends StatelessWidget {
  final DomainHabit habit;
  final int index;

  ListItem({@required this.habit, @required this.index});

  Future<void> deleteHabit(BuildContext context) async {
    HabitsCubit cubit = BlocProvider.of<HabitsCubit>(context);
    await cubit.deleteByIndex(index);
    await cancelNotificationTask(habit.id);
  }

  @override
  Widget build(BuildContext context) {
    print(habit.toString());
    return Padding(
      padding: EdgeInsets.only(bottom: listItemPaddingVertical),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailScreen(habit.id)));
        },
        child: Dismissible(
          key: Key(habit.name),
          onDismissed: (direction) async {
            await deleteHabit(context);
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              decoration: BoxDecoration(
                  color: listItemBackgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.0, top: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  habit.name,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      "Consecutive Days:",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(width: 5),
                                    ListItemNumberOfDaysWidget(
                                      days: habit.days,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text("Status: "),
                                    Text(
                                      habit.getStatus,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          flex: 3,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 2,
                          child: habit.imageUrl == null
                              ? Container(
                                  height: 118,
                                )
                              : SvgPicture.asset(
                                  habit.imageUrl,
                                  height: 118,
                                  placeholderBuilder: (context) => Container(
                                    height: 118,
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                  CustomProgressIndicator(percentage: habit.days / 90),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomProgressIndicator extends StatelessWidget {
  final double percentage;

  CustomProgressIndicator({this.percentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
      child: LinearPercentIndicator(
        lineHeight: 10,
        backgroundColor: listItemProgressBarEmptyColor,
        progressColor: listProgressBarFilledColor,
        linearStrokeCap: LinearStrokeCap.roundAll,
        percent: percentage,
      ),
    );
  }
}
