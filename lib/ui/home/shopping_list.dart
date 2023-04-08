import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fridge_it/theme/theme_colors.dart';
import '../../services/firestore_service.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/custom_toast.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingList();
}

class _ShoppingList extends State<ShoppingList> {
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
                'Shopping List',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          //Body
          Expanded(
            child: SizedBox(
              height: 200,
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
                      itemCount: snapshot.data!['shopping_list'].length,
                      itemBuilder: (_, index) {
                        return SizedBox(
                          height: Dimensions.size20 * 5,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(
                                child: Container(
                                  width: Dimensions.size20 * 4,
                                  height: Dimensions.size100,
                                  margin: EdgeInsets.only(
                                    bottom: Dimensions.size10,
                                    right: Dimensions.size30,
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            snapshot.data!['shopping_list']
                                                [index]['image'])),
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.size20,
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: Dimensions.size100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                          text: snapshot.data!['shopping_list']
                                              [index]['name'],
                                          color: ThemeColors().main,
                                          size: Dimensions.size20,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(
                                            Dimensions.size10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.size20,
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  fbS.removeItemToProduct(
                                                      snapshot.data![
                                                          'shopping_list'],
                                                      index);
                                                  toast = CustomToast(
                                                      message:
                                                          "The product has been removed\nfrom the shopping cart",
                                                      context: context);
                                                  toast?.showCustomToast();
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: ThemeColors().main,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5.0,
                                                ),
                                                child: BigText(
                                                  text: snapshot
                                                      .data!['shopping_list']
                                                          [index]['quantity']
                                                      .toString(),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  fbS.addItemToProduct(
                                                      snapshot.data![
                                                          'shopping_list'],
                                                      index);
                                                },
                                                child: Icon(
                                                  Icons.add,
                                                  color: ThemeColors().main,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
