import 'package:blogs_area/pages/signupPage/components/body.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  static const String signupPageRoute = "/signup";
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const SafeArea(
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
