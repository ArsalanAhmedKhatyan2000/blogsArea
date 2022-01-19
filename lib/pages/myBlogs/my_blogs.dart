import 'package:blogs_area/pages/myBlogs/components/body.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:flutter/material.dart';

class MyBlogs extends StatelessWidget {
  static const String myBlogsRoute = "/myBlogs";
  const MyBlogs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Blogs"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: const Body(),
      ),
    );
  }
}
