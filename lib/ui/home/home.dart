// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fridge_it/theme/theme_colors.dart';
import 'package:fridge_it/widgets/custom_widget.dart';
import 'package:intl/intl.dart';
import '../../utils/dimensions.dart';
import '../../widgets/small_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List? allNotifications;
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(Dimensions.size15),
        child: Column(
          children: [
            //Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(_auth.currentUser!.uid)
                      .doc('user_data')
                      .snapshots(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return Text(
                        'Hello, ${snapshot.data!.get('name')}',
                        style: TextStyle(
                            fontSize: Dimensions.size20,
                            fontWeight: FontWeight.bold,
                            color: ThemeColors().main),
                      );
                    }
                  }),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.size20,
            ),
            //Body layout.
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //Blue top card.
                    Container(
                      padding: EdgeInsets.only(top: Dimensions.size20),
                      decoration: BoxDecoration(
                        color: ThemeColors().main,
                        borderRadius: BorderRadius.circular(Dimensions.size20),
                      ),
                      height: Dimensions.size110,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: Dimensions.size10,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.size5,
                          ),
                          Text(
                            currentDate,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: Dimensions.size30,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.size20,
                    ),
                    //In progress section.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Products',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: Dimensions.size15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.size15,
                        ),
                        Container(
                          height: Dimensions.size20,
                          width: Dimensions.size150,
                          decoration: BoxDecoration(
                            color: ThemeColors().main.withOpacity(0.5),
                            borderRadius:
                                BorderRadius.circular(Dimensions.size10),
                          ),
                          child: StreamBuilder(
                            stream: _firestore
                                .collection(_auth.currentUser!.uid)
                                .doc('user_data')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              } else {
                                return Center(
                                  child: SmallText(
                                    text: 'The last 5 detected products',
                                    color: ThemeColors().main,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.size20,
                    ),
                    // //In progress Stream bulder.
                    Center(
                      child: SizedBox(
                        height: Dimensions.size160,
                        child: StreamBuilder(
                          stream: _firestore
                              .collection(_auth.currentUser!.uid)
                              .doc('user_data')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              return ListView.builder(
                                itemCount: 5,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) {
                                  if (snapshot.data!['products'][index]
                                          ['expiry_date'] !=
                                      null) {
                                    var a = DateTime.parse(snapshot
                                        .data!['products'][index]['expiry_date']
                                        .toString());
                                    var time = DateFormat('dd/MM/yyyy HH:mm')
                                        .format(a);
                                    return CustomContainer(
                                      title: snapshot.data!['products'][index]
                                          ['name'],
                                      image: snapshot.data!['products'][index]
                                          ['image'],
                                      expiriation_date: time,
                                    );
                                  } else {
                                    return CustomContainer(
                                      title: snapshot.data!['products'][index]
                                          ['name'],
                                      image: snapshot.data!['products'][index]
                                          ['image'],
                                    );
                                  }
                                }),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // SizedBox(
                    //   height: 200,
                    //   child: StreamBuilder(
                    //     stream: FirebaseFirestore.instance
                    //         .collection('users')
                    //         .doc(_auth.currentUser!.uid)
                    //         .snapshots(),
                    //     builder: (context, snapshot) {
                    //       if (!snapshot.hasData) {
                    //         return Container();
                    //       } else {
                    //         List<dynamic> list =
                    //             snapshot.data!['notifications'];
                    //         return CustomNotification(
                    //           notifications: list,
                    //           count: 5,
                    //           fontSize: 15,
                    //           title: 'Notifications',
                    //         );
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}
