// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fridge_it/resources/auth_res.dart';
import 'package:fridge_it/widgets/custom_button.dart';
import 'package:fridge_it/widgets/custom_loader.dart';
import 'package:fridge_it/widgets/small_text.dart';

import '../../theme/theme_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _surname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final CustomLoader _loader = CustomLoader();
  String _gender = "";
  String _avatar = "";

  @override
  void dispose() {
    _username.dispose();
    _surname.dispose();
    _surname.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  var maleAvatars = [
    'https://firebasestorage.googleapis.com/v0/b/fridgeit-d17ae.appspot.com/o/users_avatar%2Fface2.png?alt=media&token=eb330f9b-8149-42e0-ab51-741472a4cd8f',
    'https://firebasestorage.googleapis.com/v0/b/fridgeit-d17ae.appspot.com/o/users_avatar%2Fface3.png?alt=media&token=fbeab66b-35cd-46fc-a039-f7b8a011ea3a',
    'https://firebasestorage.googleapis.com/v0/b/fridgeit-d17ae.appspot.com/o/users_avatar%2Fface6.png?alt=media&token=caf2ac19-94ff-45ef-bcea-b5f86f12aad2',
  ];
  var femaleAvatars = [
    'https://firebasestorage.googleapis.com/v0/b/fridgeit-d17ae.appspot.com/o/users_avatar%2Fface1.png?alt=media&token=7be54431-612e-4cb2-ac61-92c2f1e1023c',
    'https://firebasestorage.googleapis.com/v0/b/fridgeit-d17ae.appspot.com/o/users_avatar%2Fface4.png?alt=media&token=5036c8c1-0866-42d3-bfac-506caeb39c80',
    'https://firebasestorage.googleapis.com/v0/b/fridgeit-d17ae.appspot.com/o/users_avatar%2Fface5.png?alt=media&token=1fae0fc6-64f2-40f2-a9ee-338e61c2cd0f',
  ];
  createAccount() async {
    String userName = _username.text.toString().trim();
    String surName = _surname.text.toString().trim();
    String email = _email.text.toString().trim();
    String password = _password.text.toString().trim();
    String gender = _gender.toString().trim();
    String avatar;
    List products = [];
    List shopping_list = [];
    List products_history = [];

    if (_gender.toString().trim() == 'male') {
      avatar = maleAvatars[Random().nextInt(maleAvatars.length)];
    } else {
      avatar = femaleAvatars[Random().nextInt(femaleAvatars.length)];
    }

    String res = await AuthRes().createAccount(userName, surName, email, gender,
        avatar, password, products, shopping_list, products_history);

    if (res == 'success') {
      _loader.hideLoader();
      Navigator.pop(context);
    } else {
      _loader.hideLoader();
      Fluttertoast.showToast(
        msg: res,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ThemeColors().background,
        textColor: ThemeColors().main,
        fontSize: Dimensions.size15,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors().background,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          systemNavigationBarColor: ThemeColors().background,
          statusBarColor: ThemeColors().background,
        ),
        backgroundColor: ThemeColors().background,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: ThemeColors().background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: Dimensions.size25,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors().green2,
                ),
              ),
              SizedBox(
                height: Dimensions.size20,
              ),
              Text(
                'Create account to continue...',
                style: TextStyle(
                  fontSize: Dimensions.size15,
                  color: ThemeColors().main,
                ),
              ),
              SizedBox(
                height: Dimensions.size20,
              ),
              TextFieldWidget(
                controller: _username,
                hintText: 'Name',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/person.svg',
                  fit: BoxFit.none,
                ),
              ),
              TextFieldWidget(
                controller: _surname,
                hintText: 'surName',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/person.svg',
                  fit: BoxFit.none,
                ),
              ),
              TextFieldWidget(
                controller: _email,
                hintText: 'Email',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/email.svg',
                  fit: BoxFit.none,
                ),
              ),
              TextFieldWidget(
                controller: _password,
                hintText: 'Password',
                prefixIcon: SvgPicture.asset(
                  'assets/icons/lock.svg',
                  fit: BoxFit.none,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.size20,
                  right: Dimensions.size20,
                  top: Dimensions.size10,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors().main.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(Dimensions.size15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          title: SmallText(text: "Male"),
                          value: "male",
                          activeColor: ThemeColors().main,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value.toString();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          title: SmallText(text: "Female"),
                          value: "female",
                          activeColor: ThemeColors().main,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.size20,
              ),
              CustomButton(
                text: 'Create Account',
                onTap: () {
                  _loader.showLoader(context);
                  createAccount();
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.size15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: Dimensions.size50,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Center(
                    child: Text('Login'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
