import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fridge_it/theme/theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../services/firestore_service.dart';
import '../../widgets/custom_toast.dart';
import '../../widgets/small_text.dart';
import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsList();
}

class _ProductsList extends State<ProductsList>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFirestoreService fbS = FirebaseFirestoreService();

  CustomToast? toast;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )
      ..forward()
      ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

    Color getExpirationDate(String date) {
    if (date == 'not founded') {
      return Colors.yellow;
    }
    var now = DateTime.now();
    if (date.length < 10) {
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
      padding: EdgeInsets.all(Dimensions.size15),
      child: Column(
        children: [
          //Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Dimensions.size50,
              ),
              BigText(
                  text: 'All Detected Products',
                  size: Dimensions.size25,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors().main),
            ],
          ),
          SizedBox(
            height: Dimensions.size25,
          ),
          //Body
          Expanded(
            child: StreamBuilder(
                stream: _firestore
                    .collection(_auth.currentUser!.uid)
                    .doc('user_data')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    if (snapshot.data!['all_detected_products'].length == 0) {
                      return Center(
                        child: Column(children: [
                          SizedBox(
                            height: Dimensions.size160,
                          ),
                          AnimatedIcon(
                            icon: AnimatedIcons.list_view,
                            color: ThemeColors().light1,
                            progress: animation,
                            size: Dimensions.size30,
                            semanticLabel: 'Loadding',
                          ),
                          SizedBox(
                            height: Dimensions.size15,
                          ),
                          SmallText(
                            text: 'There is no products yet',
                            size: Dimensions.size15,
                            fontWeight: FontWeight.w500,
                            color: ThemeColors().main,
                          ),
                        ]),
                      );
                    } else {
                      return ListView.builder(
                          itemCount:
                              snapshot.data!['all_detected_products'].length,
                          itemBuilder: (_, index) {
                            return SizedBox(
                              height: Dimensions.size100,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        ThemeColors().main.withOpacity(0),
                                    radius: Dimensions.size40, // Image radius
                                    backgroundImage: NetworkImage(
                                      snapshot.data!['all_detected_products']
                                          [index]['image'],
                                    ),
                                  ),
                                  Expanded(
                                      child: SizedBox(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            BigText(
                                              text: snapshot.data![
                                                      'all_detected_products']
                                                  [index]['name'],
                                              size: Dimensions.size20,
                                              color: ThemeColors().main,
                                            ),
                                          ],
                                        ),
                                    
                                      if(snapshot.data!['all_detected_products']
                                                                  [index][
                                                              'expiration_date'] !=
                                                          null)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SmallText(
                                                text: "Expiration Date",
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w500,
                                                size: Dimensions.size10,
                                              ),
                                              // ignore: unnecessary_null_comparison

                                              SizedBox(
                                                width: Dimensions.size5,
                                              ),
                                      
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  snapshot.data!['all_detected_products']
                                                                  [index][
                                                              'expiration_date'] !=
                                                          null
                                                      ? Container(
                                                          height:
                                                              Dimensions.size7,
                                                          width:
                                                              Dimensions.size7,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: getExpirationDate(
                                                                snapshot.data![
                                                                            'all_detected_products']
                                                                        [index][
                                                                    'expiration_date']),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .size13),
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                  SizedBox(
                                                    width: Dimensions.size5,
                                                  ),
                                                  snapshot.data!['all_detected_products']
                                                                  [index][
                                                              'expiration_date'] !=
                                                          null
                                                      ? Text(
                                                          snapshot.data![
                                                                      'all_detected_products']
                                                                  [index][
                                                              'expiration_date'],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .size10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      : SizedBox(
                                                          height:
                                                              Dimensions.size10,
                                                        )
                                                ],
                                              )
                                              // : Row(children: [Text(
                                              //             'Not Founded.',
                                              //             textAlign:
                                              //                 TextAlign.center,
                                              //             style: TextStyle(
                                              //                 fontSize:
                                              //                     Dimensions
                                              //                         .size10,
                                              //                 fontWeight:
                                              //                     FontWeight
                                              //                         .w600),
                                              //             overflow: TextOverflow
                                              //                 .ellipsis,
                                              //           )
                                                     
                                              //   ],)
                                            ],
                                          ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SmallText(
                                              text: "Score",
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w500,
                                              size: Dimensions.size10,
                                            ),
                                            SmallText(
                                              text: snapshot.data![
                                                      'all_detected_products']
                                                      [index]['score']
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w600,
                                              size: Dimensions.size10,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            (snapshot.data!['shopping_list']
                                                        .toString()
                                                        .contains(snapshot
                                                            .data![
                                                                'all_detected_products']
                                                                [index]
                                                                ['created_date']
                                                            .toString()) ==
                                                    false)
                                                ? TextButton(
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      Dimensions
                                                                          .size20),
                                                        ),
                                                      ),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<
                                                                      Color>(
                                                                  ThemeColors()
                                                                      .main),
                                                    ),
                                                    onPressed: () {
                                                      fbS.addToShoppingList(
                                                          snapshot.data![
                                                                  'all_detected_products']
                                                              [index]['name'],
                                                          snapshot.data![
                                                                  'all_detected_products']
                                                              [index]['image'],
                                                          1,
                                                          snapshot.data![
                                                                      'all_detected_products']
                                                                  [index]
                                                              ['created_date']);
                                                      toast = CustomToast(
                                                          message:
                                                              "The product has been added\nto the shopping cart",
                                                          context: context);
                                                      toast?.showCustomToast();
                                                    },
                                                    child: SmallText(
                                                      text:
                                                          "Add To Shopping List",
                                                      color: Colors.white,
                                                      size: Dimensions.size10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                : const SizedBox()
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            );
                          });
                    }
                  }
                }),
          ),
        ],
      ),
    );
  }
}
