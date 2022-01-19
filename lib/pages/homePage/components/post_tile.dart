import 'package:blogs_area/pages/PostDetailsPage/post_details.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final Map _data;
  final String _documentID;
  final bool? _isEditDeleteVisible;

  const PostTile(
      {Key? key, @required data, @required documentID, isEditDeleteVisible})
      : _data = data,
        _documentID = documentID,
        _isEditDeleteVisible = isEditDeleteVisible,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetails(
              data: _data,
              documentID: _documentID,
              isEditDeleteVisible: _isEditDeleteVisible!,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(getProportionateScreenHeight(9)),
        child: Stack(
          children: [
            BuildPostImage(
              imageURL: _data['image'],
              documentID: _documentID,
            ),
            const BuildPostImageOverlay(),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(9)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildPostTitle(
                    title: _data['title'],
                    titleColor: Colors.white,
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  BuildPostPublishedDetails(
                    authorName: _data['authorName'],
                    publishedDate: _data['publishedDate'],
                    textColor: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildPostPublishedDetails extends StatelessWidget {
  final String? _authorName;
  final String? _publishedDate;
  final Color? _textColor;
  const BuildPostPublishedDetails({
    Key? key,
    @required authorName,
    @required publishedDate,
    @required textColor,
  })  : _authorName = authorName,
        _publishedDate = publishedDate,
        _textColor = textColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BuildPostAuthorNAmeAndDate(
          icon: Icons.person,
          text: _authorName!,
          textColor: _textColor,
        ),
        BuildPostAuthorNAmeAndDate(
          icon: Icons.timelapse_rounded,
          text: _publishedDate,
          textColor: _textColor,
        ),
      ],
    );
  }
}

class BuildPostAuthorNAmeAndDate extends StatelessWidget {
  final IconData? _icon;
  final String? _text;
  final Color? _textColor;
  const BuildPostAuthorNAmeAndDate({
    Key? key,
    @required icon,
    @required text,
    @required textColor,
  })  : _icon = icon,
        _text = text,
        _textColor = textColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              _icon,
              color: _textColor,
            ),
            SizedBox(
              width: getProportionateScreenWidth(5),
            ),
            Text(
              _text!,
              style: TextStyle(
                color: _textColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BuildPostTitle extends StatelessWidget {
  final String? _title;
  final Color? _titleColor;

  const BuildPostTitle({Key? key, @required title, @required titleColor})
      : _title = title,
        _titleColor = titleColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: SizeConfig.screenWidth,
      alignment: Alignment.center,
      child: Text(
        _title!,
        // textScaleFactor: 1.4,
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _titleColor,
          fontSize: getProportionateScreenWidth(20),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class BuildPostImageOverlay extends StatelessWidget {
  const BuildPostImageOverlay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(150),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

class BuildPostImage extends StatelessWidget {
  final String? _imageURL;
  final String _documentID;

  const BuildPostImage({Key? key, @required imageURL, @required documentID})
      : _imageURL = imageURL,
        _documentID = documentID,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _documentID,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image.network(
          _imageURL!,
          height: getProportionateScreenHeight(150),
          width: SizeConfig.screenWidth,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
