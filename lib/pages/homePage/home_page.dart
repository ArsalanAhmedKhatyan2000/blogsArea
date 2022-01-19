import 'package:blogs_area/pages/addPostPage/add_post.dart';
import 'package:blogs_area/pages/homePage/components/body.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:blogs_area/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Map _data = {};
  final String _documentID = "";
  static const String homePageRoute = "/homePage";
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Blogs Area"),
          centerTitle: true,
        ),
        body: const Body(),
        drawer: const MyDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddPost(
                          data: _data,
                          documentID: _documentID,
                        )));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
