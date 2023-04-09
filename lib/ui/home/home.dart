import 'package:fridge_it/widgets/custom_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fridge_it/theme/theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List? allNotifications;
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
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
              StreamBuilder(
                stream: _firestore
                    .collection(_auth.currentUser!.uid)
                    .doc('user_data')
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return BigText(
                        text:
                            'Hello, ${snapshot.data!.get('user_name')} ${snapshot.data!.get('sur_name')}',
                        size: Dimensions.size20,
                        fontWeight: FontWeight.bold,
                        color: ThemeColors().main);
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
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: Dimensions.size20),
                    decoration: BoxDecoration(
                      color: ThemeColors().light2,
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
                        width: Dimensions.size160,
                        decoration: BoxDecoration(
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
                              if (snapshot.data!['products'].length == 0) {
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
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.size15,
                  ),
                  // //In progress Stream bulder.
                  Center(
                    child: SizedBox(
                      height: Dimensions.size150,
                      child: StreamBuilder(
                        stream: _firestore
                            .collection(_auth.currentUser!.uid)
                            .doc('user_data')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          } else {
                            int count = 0;
                            if ((snapshot.data!['products'].length >
                                        0 &&
                                    snapshot.data!['products'].length <= 5)){
                              count = snapshot.data!['products'].length;
                            } else if (snapshot.data!['products'].length > 5) {
                              count = 5;
                              }
                              else if (snapshot.data!['products'].length == 0) {
                              return Center(
                                  child: Column(children: [
                                SizedBox(
                                  height: Dimensions.size30,
                                ),
                                AnimatedIcon(
                                  icon: AnimatedIcons.list_view,
                                  color: ThemeColors().light1,
                                  progress: animation,
                                  size: Dimensions.size30,
                                  semanticLabel: 'Show menu',
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
                              ]));
                            }
                            return ListView.builder(
                              itemCount: count,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                if (snapshot.data!['products'][index]
                                        ['expiry_date'] !=
                                    null) {
                                  var a = DateTime.parse(snapshot
                                      .data!['products'][index]['expiry_date']
                                      .toString());
                                  var time = DateFormat('dd/MM/yyyy').format(a);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'History',
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
                        width: Dimensions.size160,
                        decoration: BoxDecoration(
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
                              if (snapshot.data!['products_history'].length ==
                                  0) {
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
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.size15,
                  ),
                  // //In progress Stream bulder.
                  Center(
                    child: SizedBox(
                      height: Dimensions.size150,
                      child: StreamBuilder(
                        stream: _firestore
                            .collection(_auth.currentUser!.uid)
                            .doc('user_data')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          } else {
                            int count = 0;
                            if ((snapshot.data!['products_history'].length >
                                        0 &&
                                    snapshot.data!['products_history'].length <= 5)){
                              count = snapshot.data!['products_history'].length;
                            } else if (snapshot.data!['products_history'].length > 5) {
                              count = 5;
                              }
                              else if (snapshot.data!['products'].length == 0) {
                              return Center(
                                  child: Column(children: [
                                SizedBox(
                                  height: Dimensions.size30,
                                ),
                                AnimatedIcon(
                                  icon: AnimatedIcons.list_view,
                                  color: ThemeColors().light1,
                                  progress: animation,
                                  size: Dimensions.size30,
                                  semanticLabel: 'Show menu',
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
                              ]));
                            }
                            return ListView.builder(
                              itemCount: count,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                if (snapshot.data!['products_history'][index]
                                        ['expiry_date'] !=
                                    null) {
                                  var a = DateTime.parse(snapshot
                                      .data!['products_history'][index]
                                          ['expiry_date']
                                      .toString());
                                  var time = DateFormat('dd/MM/yyyy').format(a);
                                  return CustomContainer(
                                    title: snapshot.data!['products_history']
                                        [index]['name'],
                                    image: snapshot.data!['products_history']
                                        [index]['image'],
                                    expiriation_date: time,
                                  );
                                } else {
                                  return CustomContainer(
                                    title: snapshot.data!['products_history']
                                        [index]['name'],
                                    image: snapshot.data!['products_history']
                                        [index]['image'],
                                  );
                                }
                              }),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
