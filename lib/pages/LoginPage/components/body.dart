import 'package:blogs_area/pages/LoginPage/components/login_form.dart';
import 'package:blogs_area/pages/signupPage/signup.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:blogs_area/widgets/no_account_strp.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
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
                "Lets's get start",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.purple,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
              LoginForm(),
              SizedBox(height: getProportionateScreenHeight(20)),
              BuildNoAccountStrip(
                onTap: () {
                  Navigator.pushNamed(context, Signup.signupPageRoute);
                },
                firstText: "Don't have an account? ",
                lastText: "Sign Up",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
