// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:email_validator/email_validator.dart';
import 'package:fridge_it/widgets/custom_button.dart';
import 'package:fridge_it/widgets/custom_loader.dart';
import 'package:fridge_it/resources/auth_res.dart';
import 'package:fridge_it/widgets/small_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/custom_radio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../theme/theme_colors.dart';
import '../../widgets/text_field.dart';
import '../../utils/dimensions.dart';
import 'dart:math';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final CustomLoader _loader = CustomLoader();
  String _gender = "";

  bool showEmailError = false;
  bool showPasswordError = false;
  bool showFirstNameError = false;
  bool showLastNameError = false;
  bool showGenderError = false;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
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

  String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      default:
        return "Signup failed. Please try again.";
    }
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  createAccount() async {
    String firstName = _firstName.text.toString().trim();
    String lastName = _lastName.text.toString().trim();
    String email = _email.text.toString().trim();
    String password = _password.text.toString().trim();
    String gender = _gender.toString().trim();
    String avatar;
    List all_detected_products = [];
    List shopping_list = [];
    List recently_detected_products = [];

    if (_gender.toString().trim() == 'male') {
      avatar = maleAvatars[Random().nextInt(maleAvatars.length)];
    } else {
      avatar = femaleAvatars[Random().nextInt(femaleAvatars.length)];
    }

    String res = await AuthRes().createAccount(
        firstName,
        lastName,
        email,
        gender,
        avatar,
        password,
        all_detected_products,
        shopping_list,
        recently_detected_products);

    if (res == 'success') {
      _loader.hideLoader();
      Navigator.pop(context);
    } else {
      _loader.hideLoader();
      setState(() {});
      Fluttertoast.showToast(
        msg: getMessageFromErrorCode(res),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ThemeColors().background,
        textColor: ThemeColors().main,
        fontSize: Dimensions.size15,
      );
    }
  }

  void validatePassword(String password) {
    RegExp regex = RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{6,}$');
    if (!regex.hasMatch(password) || password.isEmpty) {
      showPasswordError = true;
    } else {
      showPasswordError = false;
    }
  }

  void validateEmail(String email) {
    if (!EmailValidator.validate(email) || email.isEmpty) {
      showEmailError = true;
    } else {
      showEmailError = false;
    }
  }

  void validateFirstName(String firstName) {
    if (firstName.isEmpty) {
      showFirstNameError = true;
    } else {
      showFirstNameError = false;
    }
  }

  void validateLastName(String lastName) {
    if (lastName.isEmpty) {
      showLastNameError = true;
    } else {
      showLastNameError = false;
    }
  }

  void validateGender(String gender) {
    if (gender.isEmpty) {
      showGenderError = true;
    } else {
      showGenderError = false;
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
                'Create account to continue',
                style: TextStyle(
                  fontSize: Dimensions.size15,
                  color: ThemeColors().main,
                ),
              ),
              SizedBox(
                height: Dimensions.size20,
              ),
              Form(
                  onChanged: () {
                    String email = _email.text.toString().trim();
                    String password = _password.text.toString().trim();
                    String firstName = _firstName.text.toString().trim();
                    String lastName = _lastName.text.toString().trim();
                    String gender = _gender.toString().trim();
                    validateEmail(email);
                    validatePassword(password);
                    validateFirstName(firstName);
                    validateLastName(lastName);
                    validateGender(gender);
                    setState(() {});
                  },
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(children: [
                    TextFieldWidget(
                      controller: _firstName,
                      hintText: 'First Name',
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/person.svg',
                        fit: BoxFit.none,
                      ),
                    ),
                    showFirstNameError == true
                        ? SmallText(
                            color: Colors.red,
                            textAlign: TextAlign.right,
                            text: 'Please enter first name')
                        : SizedBox(
                            height: Dimensions.size10,
                          ),
                    TextFieldWidget(
                      controller: _lastName,
                      hintText: 'Last Name',
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/person.svg',
                        fit: BoxFit.none,
                      ),
                    ),
                    showLastNameError == true
                        ? SmallText(
                            color: Colors.red,
                            textAlign: TextAlign.right,
                            text: 'Please enter last name')
                        : SizedBox(
                            height: Dimensions.size10,
                          ),
                    TextFieldWidget(
                      controller: _email,
                      hintText: 'Email',
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/email.svg',
                        fit: BoxFit.none,
                      ),
                    ),
                    showEmailError == true
                        ? SmallText(
                            color: Colors.red,
                            textAlign: TextAlign.start,
                            text:
                                'Please enter emaill in the following format:\n'
                                '\u2022 a@a.a')
                        : SizedBox(
                            height: Dimensions.size10,
                          ),
                    TextFieldWidget(
                      controller: _password,
                      hintText: 'Password',
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/lock.svg',
                        fit: BoxFit.none,
                      ),
                    ),
                    showPasswordError == true
                        ? SmallText(
                            color: Colors.red,
                            textAlign: TextAlign.start,
                            text:
                                'Please enter password with at least 6 characters and digits\n')
                        : SizedBox(
                            height: Dimensions.size10,
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
                          borderRadius:
                              BorderRadius.circular(Dimensions.size15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CustomRadioWidget(
                              title: SmallText(
                                text: "Male",
                                size: Dimensions.size15,
                                fontWeight: FontWeight.w300,
                                color: Colors.black54,
                              ),
                              value: "male",
                              groupValue: _gender,
                              onChanged: (String value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            SizedBox(
                              width: Dimensions.size50,
                            ),
                            CustomRadioWidget(
                              title: SmallText(
                                text: "Female",
                                size: Dimensions.size15,
                                fontWeight: FontWeight.w300,
                                color: Colors.black54,
                              ),
                              value: "female",
                              groupValue: _gender,
                              onChanged: (String value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    showGenderError == true
                        ? SmallText(
                            color: Colors.red,
                            textAlign: TextAlign.start,
                            text: 'Please please selecet an option\n')
                        : SizedBox(
                            height: Dimensions.size10,
                          ),
                  ])),
              SizedBox(
                height: Dimensions.size20,
              ),
              CustomButton(
                text: 'Create Account',
                onTap: () {
                  _loader.showLoader(context);
                  String email = _email.text.toString().trim();
                  String password = _password.text.toString().trim();
                  String firstName = _firstName.text.toString().trim();
                  String lastName = _lastName.text.toString().trim();
                  validateEmail(email);
                  validatePassword(password);
                  validateFirstName(firstName);
                  validateLastName(lastName);
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
                    child: Text('Back To Login'),
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
