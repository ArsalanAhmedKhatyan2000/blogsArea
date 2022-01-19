import 'package:blogs_area/pages/addPostPage/components/body.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:flutter/material.dart';

class AddPost extends StatelessWidget {
  static const String addPostRoute = "/addPostPage";
  final Map _data;
  final String _documentID;
  const AddPost({Key? key, @required data, @required documentID})
      : _data = data,
        _documentID = documentID,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: _data.isNotEmpty
            ? const Text(
                "Update Blog",
              )
            : const Text(
                "Upload Blog",
              ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Body(
        data: _data,
        documentID: _documentID,
      ),
    );
  }
}
