// ignore_for_file: prefer_const_constructors
import 'package:fridge_it/theme/theme_colors.dart';
import 'package:fridge_it/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/dimensions.dart';

class CustomContainer extends StatefulWidget {
  final String title;
  final String image;
  String? expiriation_date;
  String? score;

  CustomContainer({
    super.key,
    required this.title,
    required this.image,
    this.expiriation_date,
    this.score,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  DateTime currentDate = DateTime.now();
  late DateTime date;

  bool getExpirationDate(String date) {
    var now = DateTime.now();
    date = date + '/' + DateTime.now().year.toString();
    print(date);
    DateFormat format = DateFormat('d/M/y');
    DateTime expirationDate = format.parse(date);
    print(expirationDate);
    final bool isExpired = expirationDate.isBefore(now);
    if (isExpired == true) {
      print(isExpired);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(right: Dimensions.size10, bottom: Dimensions.size5),
      child: Container(
        width: Dimensions.size130,
        padding: EdgeInsets.all(Dimensions.size15),
        decoration: BoxDecoration(
          color: ThemeColors().main.withOpacity(0.5),
          borderRadius: BorderRadius.circular(Dimensions.size20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SmallText(
                text: widget.title,
                color: Colors.black54,
                size: Dimensions.size15,
                fontWeight: FontWeight.w600),
            SizedBox(
              height: Dimensions.size5,
            ),
            CircleAvatar(
              radius: Dimensions.size30, // Image radius
              backgroundImage: NetworkImage(
                widget.image.toString(),
              ),
            ),
            SizedBox(
              height: Dimensions.size5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.expiriation_date != null
                    ? getExpirationDate(widget.expiriation_date!) != true
                        ? Container(
                            height: Dimensions.size7,
                            width: Dimensions.size7,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size13),
                            ),
                          )
                        : Container(
                            height: Dimensions.size7,
                            width: Dimensions.size7,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.size13),
                            ),
                          )
                    : SizedBox(),
                SizedBox(
                  width: 6,
                ),
                widget.expiriation_date != null
                    ? Text(
                        widget.expiriation_date!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Dimensions.size10,
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      )
                    : SizedBox()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallText(
                  text: "Score",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                  size: Dimensions.size10,
                ),
                SmallText(
                  text: widget.score!,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  size: Dimensions.size10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
