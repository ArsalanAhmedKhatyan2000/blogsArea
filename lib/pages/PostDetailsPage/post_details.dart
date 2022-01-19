import 'package:blogs_area/pages/PostDetailsPage/components/body.dart';
import 'package:blogs_area/pages/addPostPage/add_post.dart';
import 'package:blogs_area/pages/myBlogs/my_blogs.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:blogs_area/widgets/build_dialogbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostDetails extends StatelessWidget {
  static const String postDetailsPageRoute = "/postDetails";
  final Map _data;
  final String _documentID;
  final bool? _isEditDeleteVisible;
  const PostDetails(
      {Key? key, @required data, @required documentID, isEditDeleteVisible})
      : _data = data,
        _documentID = documentID,
        _isEditDeleteVisible = isEditDeleteVisible,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Blog Details"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            Visibility(
              visible: _isEditDeleteVisible!,
              child: InkWell(
                onTap: () {
                  dialogBoxWithFunctions(
                    context,
                    title: "Edit Blog",
                    description:
                        "Are you sure you want to edit this blog permanently.",
                    onYes: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddPost(
                            data: _data,
                            documentID: _documentID,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.edit),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            Visibility(
              visible: _isEditDeleteVisible!,
              child: InkWell(
                onTap: () {
                  dialogBoxWithFunctions(context,
                      title: "Delete Blog",
                      description:
                          "Are you sure you want to delete this blog permanently.",
                      onYes: () {
                    deletePost(_documentID, context);
                  });
                },
                child: const Icon(Icons.delete),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(10)),
          ],
        ),
        body: Body(data: _data, documentID: _documentID),
      ),
    );
  }
}

void deletePost(String documentID, BuildContext context) async {
  try {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection("blogs").doc(documentID).delete();
    // Navigator.of(context).pop();
    // Navigator.pushReplacementNamed(context, MyBlogs.myBlogsRoute);
    Navigator.popAndPushNamed(context, MyBlogs.myBlogsRoute);
  } catch (e) {
    dialogBoxError(context,
        e: e.toString(), routeName: PostDetails.postDetailsPageRoute);
  }
}
