import 'package:fridge_it/widgets/custom_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fridge_it/theme/theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/small_text.dart';
import 'package:flutter/material.dart';
import '../../widgets/big_text.dart';
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
                            'Hello, ${snapshot.data!.get('first_name')} ${snapshot.data!.get('last_name')}',
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
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.size5),
                    child: BigText(
                      text: 'Recently Detected Products',
                      textAlign: TextAlign.center,
                      color: ThemeColors().main,
                      size: Dimensions.size15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.size15,
                  ),
                  // //In progress Stream bulder.
                  SizedBox(
                    height: Dimensions.size500,
                    child: StreamBuilder(
                      stream: _firestore
                          .collection(_auth.currentUser!.uid)
                          .doc('user_data')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          if (snapshot
                                  .data!['recently_detected_products'].length ==
                              0) {
                            return Padding(
                                padding:
                                    EdgeInsets.only(left: Dimensions.size5),
                                child: Column(children: [
                                  SizedBox(
                                    height: Dimensions.size70,
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
                                    textAlign: TextAlign.center,
                                    text:
                                        'There is no recently\ndetected products yet',
                                    size: Dimensions.size15,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeColors().main,
                                  ),
                                ]));
                          } else {
                            return GridView.builder(
                              padding: EdgeInsets.only(left: Dimensions.size5),
                              itemCount: snapshot
                                  .data!['recently_detected_products'].length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: ((context, index) {
                                if (snapshot.data!['recently_detected_products']
                                        [index]['expiry_date'] !=
                                    null) {
                                  var a = DateTime.parse(snapshot
                                      .data!['recently_detected_products']
                                          [index]['expiry_date']
                                      .toString());
                                  var time = DateFormat('dd/MM/yyyy').format(a);
                                  return CustomContainer(
                                    title: snapshot
                                            .data!['recently_detected_products']
                                        [index]['name'],
                                    image: snapshot
                                            .data!['recently_detected_products']
                                        [index]['image'],
                                    expiriation_date: time,
                                  );
                                } else {
                                  return CustomContainer(
                                    title: snapshot
                                            .data!['recently_detected_products']
                                        [index]['name'],
                                    image: snapshot
                                            .data!['recently_detected_products']
                                        [index]['image'],
                                  );
                                }
                              }),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio:
                                    Dimensions.size80 / Dimensions.size80,
                                crossAxisCount: 2,
                              ),
                            );
                          }
                        }
                      },
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
