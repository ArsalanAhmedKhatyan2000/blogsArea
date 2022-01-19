import 'package:blogs_area/pages/LoginPage/login_page.dart';
import 'package:blogs_area/pages/signupPage/components/signup_form.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:blogs_area/widgets/no_account_strp.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          padding: EdgeInsets.only(
            right: getProportionateScreenWidth(30),
            left: getProportionateScreenWidth(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Sign up",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.purple,
                  letterSpacing: 1,
                ),
              ),
              SignupForm(),
              BuildNoAccountStrip(
                onTap: () {
                  Navigator.pushNamed(context, LoginPage.loginPageRoute);
                },
                firstText: "Already have a account? ",
                lastText: "Sign in",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
