import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fridge_it/theme/theme_colors.dart';
import '../../services/firestore_service.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/custom_toast.dart';
import '../../widgets/small_text.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsList();
}

class _ProductsList extends State<ProductsList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFirestoreService fbS = FirebaseFirestoreService();

  CustomToast? toast;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            //Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Products List',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
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
                      return ListView.builder(
                          itemCount: snapshot.data!['products'].length,
                          itemBuilder: (_, index) {
                            return SizedBox(
                              height: Dimensions.size90,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      width: Dimensions.size80,
                                      height: Dimensions.size80,
                                      margin: EdgeInsets.only(
                                        bottom: Dimensions.size5,
                                        right: Dimensions.size10,
                                      ),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              snapshot.data!['products'][index]
                                                  ['image']),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          Dimensions.size20,
                                        ),
                                        color: Colors.white,
                                      ),
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
                                              text: snapshot.data!['products']
                                                  [index]['name'],
                                              size: Dimensions.size20,
                                              color: ThemeColors().main,
                                            ),
                                          ],
                                        ),
                                        if (snapshot.data!['products'][index]
                                                ['expiry_date'] !=
                                            null)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SmallText(
                                                text: "Expiry Date",
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w500,
                                                size: Dimensions.size10,
                                              ),
                                              SmallText(
                                                text: snapshot.data!['products']
                                                        [index]['expiry_date']
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
                                                                'products']
                                                            [index]['name']) ==
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
                                                                  'products']
                                                              [index]['name'],
                                                          snapshot.data![
                                                                  'products']
                                                              [index]['image'],
                                                          1);
                                                      toast = CustomToast(
                                                          message:
                                                              "The product has been added\nto the shopping cart",
                                                          context: context);
                                                      toast?.showCustomToast();
                                                      //***************************** */
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
                  }),
            ),
          ],
        ),
      );
  }
}
