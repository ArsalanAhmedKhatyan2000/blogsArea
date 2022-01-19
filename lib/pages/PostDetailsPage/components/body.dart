import 'package:blogs_area/pages/homePage/components/post_tile.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final Map _data;
  final String _documentID;
  const Body({Key? key, @required data, @required documentID})
      : _data = data,
        _documentID = documentID,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(getProportionateScreenWidth(15)),
        child: Column(
          children: [
            BuildPostImage(
              imageURL: _data["image"],
              documentID: _documentID,
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            BuildPostTitle(
              title: _data["title"],
              titleColor: Colors.black,
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            BuildPostDescription(text: _data["description"]),
            SizedBox(height: getProportionateScreenHeight(10)),
            BuildPostPublishedDetails(
              authorName: _data["authorName"],
              publishedDate: _data["publishedDate"],
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class BuildPostDescription extends StatelessWidget {
  final String? _text;
  const BuildPostDescription({
    Key? key,
    @required text,
  })  : _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text!,
      softWrap: true,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
