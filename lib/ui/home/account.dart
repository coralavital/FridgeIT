// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../theme/theme_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/dialog.dart';
import '../../widgets/small_text.dart';

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
          return Scaffold(
              backgroundColor: ThemeColors().background,
              body: Padding(
                  padding: EdgeInsets.all(Dimensions.size15),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(Dimensions.size20),
                            child: Image(
                              image: NetworkImage(
                                  snapshot.data!['profile_picture_url']),
                            ),
                          ),
                          BigText(
                            text: snapshot.data!['first_name'] +
                                ' ' +
                                snapshot.data!['last_name'],
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
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      title: BigText(
                                        text: "About Us",
                                        size: Dimensions.size20,
                                        fontWeight: FontWeight.w900,
                                        color: ThemeColors().green1,
                                      ),
                                      message: SmallText(
                                        textAlign: TextAlign.center,
                                        text:
                                            "At FridgeIT, we build new and innovative ways to help people understand and talk about sustainability and the structure of our company reflects the diverse perspectives of the people who use our technologies."
                                            "The product is designed to identify products that are in the refrigerator and in addition to enable identification of expiration dates and thus help people track the products in their possession and the expiration date of these products.",
                                        color: ThemeColors().black,
                                        size: Dimensions.size15,
                                      ),
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
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      title: BigText(
                                        text: 'Hou to use',
                                        size: Dimensions.size20,
                                        fontWeight: FontWeight.w900,
                                        color: ThemeColors().green1,
                                      ),
                                      message: SmallText(
                                        textAlign: TextAlign.center,
                                        text:
                                            "In the personal area you can view your user's details"
                                            "and perform actions such as changing the password,"
                                            "logging out of the system and deleting the account",
                                        color: ThemeColors().black,
                                        size: Dimensions.size15,
                                      ),
                                    );
                                  });
                            },
                            icons: Icons.help_center_rounded,
                            iconStyle: IconStyle(
                              backgroundColor: ThemeColors().light1,
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
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                            },
                            icons: Icons.exit_to_app_rounded,
                            iconStyle: IconStyle(
                              backgroundColor: ThemeColors().light2,
                            ),
                            title: "Sign Out",
                          ),
                          SettingsItem(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      title: BigText(text: 'Delete Account', size: Dimensions.size20,
                                        fontWeight: FontWeight.w900,
                                        color: ThemeColors().green1,),
                                      message: SmallText(
                                        textAlign: TextAlign.center,
                                        text: "Are you sure you want to delete your account?",
                                        color: ThemeColors().black,
                                        size: Dimensions.size15,
                                      ),
                                      button1: CustomButton(                     
                                              text: 'Yes',
                                              size: Dimensions.size60,
                                              onTap: () {
                                                User user = _auth.currentUser!;
                                                user.delete();
                                              },
                                            ),
                                      button2: CustomButton(
                                              text: 'No',
                                              size: Dimensions.size60,
                                              onTap: () {
                                                Navigator.pop(
                                                    context, 'Cancel');
                                              },
                                            ),
                                    );
                                  });
                            },

                            icons: CupertinoIcons.delete_solid,
                            iconStyle: IconStyle(
                              backgroundColor: ThemeColors().green2,
                            ),
                            title: "Delete account",
                            titleStyle: TextStyle(
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
