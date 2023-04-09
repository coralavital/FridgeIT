// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../theme/theme_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection(_auth.currentUser!.uid)
          .doc('user_data')
          .snapshots(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          return Scaffold(backgroundColor: ThemeColors().background, body:Padding(
              padding: EdgeInsets.all(Dimensions.size15),
              child: ListView(
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.size20),
                        child: Image(
                          image: NetworkImage(
                              snapshot.data!['profile_picture_url']),
                        ),
                      ),
                      BigText(
                        text: snapshot.data!['user_name'] +
                            ' ' +
                            snapshot.data!['sur_name'],
                        color: ThemeColors().main,
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.size20,
                  ),
                  SettingsGroup(
                    items: [
                      SettingsItem(
                        backgroundColor: ThemeColors().background,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  title: 'About',
                                  message:
                                      "At FridgeIT, we're building new and innovative ways to help people understand and talk about sustainability"
                                      "and the makeup of our company reflects the diverse perspectives of the people who use our technologies."
                                      "The product is designed to record products that are in the refrigerator and in addition to allow products to" 
                                      "be scanned in order to get the expiration date of products and to help people keep track of the products they" 
                                      "have and the expiration date of these products.",
                                );
                              });
                        },
                        icons: Icons.info_rounded,
                        iconStyle: IconStyle(
                          backgroundColor: ThemeColors().green1,
                        ),
                        title: 'About',
                        // subtitle: "Learn more about Ziar'App",
                      ),
                      SettingsItem(
                        onTap: () {
                          // BabyDialog();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  title: 'Help',
                                  message:
                                      "In the personal area you can view your user's details"
                                      "and perform actions such as changing the password,"
                                      "logging out of the system and deleting the account",
                                );
                              });
                        },
                        icons: Icons.help_center_rounded,
                        iconStyle: IconStyle(
                          backgroundColor: ThemeColors().green2,
                        ),
                        title: 'Help',
                        // subtitle: "Learn more about Ziar'App",
                      ),
                    ],
                  ),
                  // You can add a settings title
                  SettingsGroup(
                    
                    items: [
                      SettingsItem(
                        backgroundColor: ThemeColors().background,
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                        icons: Icons.exit_to_app_rounded,
                        title: "Sign Out",
                      ),
                      SettingsItem(
                        backgroundColor: ThemeColors().background,
                        onTap: () {
                          User user = FirebaseAuth.instance.currentUser!;
                          user.delete();
                        },
                        icons: CupertinoIcons.delete_solid,
                        title: "Delete account",
                        titleStyle: TextStyle(
                          color: ThemeColors().main,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              )));
        }
      }),
    );
  }
}
