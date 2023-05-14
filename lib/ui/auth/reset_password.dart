// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:email_validator/email_validator.dart';
import 'package:fridge_it/widgets/custom_button.dart';
import 'package:fridge_it/widgets/custom_loader.dart';
import 'package:fridge_it/resources/auth_res.dart';
import 'package:fridge_it/widgets/text_field.dart';
import 'package:fridge_it/utils/dimensions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/theme_colors.dart';
import '../../widgets/small_text.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  final TextEditingController _email = TextEditingController();
  final CustomLoader _loader = CustomLoader();
  bool showEmailError = false;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void validateEmail(String email) {
    if (!EmailValidator.validate(email) || email.isEmpty) {
      showEmailError = true;
    } else {
      showEmailError = false;
    }
  }

  String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      default:
        return "Login failed. Please try again.";
    }
  }

  resetPass() async {
    String email = _email.text.trim().toString();
    String res = await AuthRes().resetPassword(email);
    if (res == 'success') {
      _loader.hideLoader();
      Fluttertoast.showToast(
        msg: 'Password reset link sent to your mail',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ThemeColors().background,
        textColor: ThemeColors().main,
        fontSize: Dimensions.size15,
      );
      Navigator.pop(context);
    } else {
      setState(() {});
      _loader.hideLoader();
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: ThemeColors().background,
          child: Column(
            children: [
              Text(
                'Forgot Password',
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
                'Enter your email to reset password',
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
                  validateEmail(email);
                  setState(() {});
                },
                child: TextFieldWidget(
                  controller: _email,
                  hintText: 'Email',
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/email.svg',
                    fit: BoxFit.none,
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.size5,
              ),
              showEmailError == true
                  ? SmallText(
                      color: Colors.red,
                      textAlign: TextAlign.start,
                      text: 'Please enter email')
                  : SizedBox(
                      height: Dimensions.size10,
                    ),
              SizedBox(
                height: Dimensions.size20,
              ),
              CustomButton(
                text: 'Reset password',
                onTap: () {
                  String email = _email.text.toString().trim();
                  _loader.showLoader(context);
                  validateEmail(email);
                  resetPass();
                },
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
