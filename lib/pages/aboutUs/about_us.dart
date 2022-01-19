import 'package:blogs_area/size_configuration.dart';
import 'package:flutter/material.dart';

class AboutUS extends StatelessWidget {
  static const String aboutUsRoute = "/aboutUs";
  const AboutUS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("About Us"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Blogs Area",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: getProportionateScreenWidth(40),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                "Designed and Developed by",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                "Tech Beast",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
