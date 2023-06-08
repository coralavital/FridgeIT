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

  CustomContainer({
    super.key,
    required this.title,
    required this.image,
    this.expiriation_date,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  DateTime currentDate = DateTime.now();
  late DateTime date;

    Color getExpirationDate(String date) {
    if (date == 'not founded' || date == 'not found') {
      return Colors.yellow;
    }
    var now = DateTime.now();
    if (date.length < 10 && date.length > 6) {
      var year = int.parse(date.substring(6));
      date = date.substring(0, 6);
      date += (year + 2000).toString();
    }
    date = '$date/${DateTime.now().year}';
    DateFormat format = DateFormat('d/M/y');
    DateTime expirationDate = format.parse(date);
    final bool isExpired = expirationDate.isBefore(now);
    if (isExpired) {
      return Colors.red;
    } else {
      var difference = expirationDate.difference(now).inDays;
      if (!isExpired && difference < 2) {
        return Colors.orange;
      } else {
        return Colors.green;
      }
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
              backgroundColor: ThemeColors().main.withOpacity(0),
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
                    ? Container(
                        height: Dimensions.size7,
                        width: Dimensions.size7,
                        decoration: BoxDecoration(
                          color: getExpirationDate(widget.expiriation_date!),
                          borderRadius:
                              BorderRadius.circular(Dimensions.size13),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  width: Dimensions.size5,
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
                    : SizedBox(
                        height: Dimensions.size10,
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
