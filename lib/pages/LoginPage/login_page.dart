import 'package:blogs_area/pages/LoginPage/components/body.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const String loginPageRoute = "/loginPage";
  const LoginPage({Key? key}) : super(key: key);

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
