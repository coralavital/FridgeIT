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
                                        size: Dimensions.size30,
                                        fontWeight: FontWeight.w900,
                                        color: ThemeColors().green1,
                                      ),
                                      message: SmallText(
                                        textAlign: TextAlign.center,
                                        text:
                                           "FridgeIT is a pioneering company that has developed a revolutionary app aimed" 
                                           "at promoting sustainability in everyday life. With a strong focus on reducing food"
                                           "waste and encouraging responsible consumption, fridgeIT has created a groundbreaking IoT " 
                                           "system that combines advanced cameras and a smart lighting system. \n\n"
                                           "Our innovative product is designed to be installed in home refrigerators, providing " 
                                           "users with valuable insights into their food consumption habits. Every time the " 
                                           "refrigerator door is opened, our intelligent system detects the activity and swiftly " 
                                           "captures a detailed picture of the contents inside. This feature enables users to monitor " 
                                           "their food inventory, track expiration dates, and make informed decisions about meal " 
                                           "planning and grocery shopping. \n\n"
                                           "At fridgeIT, we believe that small changes can make a big difference in creating a more " 
                                           "sustainable future. By leveraging cutting-edge technology, we empower individuals to take " 
                                           "proactive steps toward reducing food waste, saving money, and minimizing their environmental " 
                                           "impact. Our user-friendly app interface ensures a seamless experience, making it easy for users " 
                                           "to access information about their refrigerated items, manage their inventory, and make conscious " 
                                           "choices about their consumption habits. \n\n"
                                           "As a company, fridgeIT is committed to continuously improving our product and expanding its " 
                                           "capabilities. We prioritize data security and privacy, utilizing state-of-the-art encryption "
                                           "and adhering to strict industry standards. Our dedicated team of engineers and designers work " 
                                           "tirelessly to deliver a seamless, reliable, and eco-friendly solution that aligns with our "
                                           "customer's needs and values. \n\n" 
                                           "Join us on our mission to make sustainable living effortless and enjoyable. " 
                                           "With fridgeIT, managing your refrigerator and reducing food waste has never been " 
                                           "more convenient. Together, we can make a positive impact on our planet, one fridge at " 
                                           "a time.",
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
                            title: 'About Us',
                            // subtitle: "Learn more about Ziar'App",
                          ),
                          SettingsItem(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      title: BigText(
                                        text: 'Hou To Use',
                                        size: Dimensions.size30,
                                        fontWeight: FontWeight.w900,
                                        color: ThemeColors().green1,
                                      ),
                                      message: SmallText(
                                        textAlign: TextAlign.center,
                                        text:
                                            "Using the fridgeIT application is simple and intuitive. Once you're on the home page, "
                                            "you'll find a comprehensive overview of the products that were identified during the last " 
                                            "door opening. Each product in the list is accompanied by an identification score, indicating " 
                                            "the system's confidence level.\n\n"
                                            "For products with an expiration date, you can easily identify their status. A visible " 
                                            "expiration date is displayed alongside a check mark. If the mark appears green, it means "
                                            "the product is still within its validity period. However, if the mark appears red, it "
                                            "indicates that the expiration date has passed.\n\n"
                                            "To explore all the products that have been identified, simply navigate to the second "
                                            "screen using the bottom navigation bar. Here, you not only have access to the complete "
                                            "list of identified products but can also add items to your shopping list. This feature "
                                            "allows you to conveniently manage your shopping record within our application.\n\n"
                                            "Should you wish to view your shopping list directly, you can effortlessly switch to the "
                                            "third screen using the bottom navigation bar. Here, you can find all the products you have "
                                            "added to your shopping list, enabling you to stay organized during your grocery trips.\n\n"
                                            "On your personal page, accessible through the fourth button on the bottom navigation bar, "
                                            "you can take various actions. This includes obtaining detailed information about fridgeIT, "
                                            "disconnecting from the application, or even deleting your account if needed. We prioritize "
                                            "your control and flexibility in managing your fridgeIT experience.\n\n" 
                                            "In case you forget your password, we've got you covered. Simply access the app's login "
                                            "screen and utilize the \"Reset Password\" button. You'll be guided through the process of "
                                            "recovering your account using your registered email address. Rest assured, we make password "
                                            "recovery a hassle-free experience.",
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
