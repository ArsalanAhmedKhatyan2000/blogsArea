import 'dart:io';
import 'package:blogs_area/pages/LoginPage/components/user_detail.dart';
import 'package:blogs_area/pages/PostDetailsPage/post_details.dart';
import 'package:blogs_area/pages/addPostPage/add_post.dart';
import 'package:blogs_area/pages/homePage/home_page.dart';
import 'package:blogs_area/validations/field_validation.dart';
import 'package:blogs_area/widgets/build_dialogbox.dart';
import 'package:path/path.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:blogs_area/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  final Map _data;
  final String _documentID;
  const Body({Key? key, @required data, @required documentID})
      : _data = data,
        _documentID = documentID,
        super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? imagePath;
  File? selectedImageFile;
  bool _isDisableFields = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController? _titleController;
  TextEditingController? _descriptionController;

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final _image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImageFile = File(_image!.path);
      imagePath = _image.path;
    });
  }

  @override
  void initState() {
    if (widget._data.isNotEmpty) {
      _titleController = TextEditingController(text: widget._data['title']);
      _descriptionController =
          TextEditingController(text: widget._data['description']);
      imagePath = widget._data['image'];
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void updateBlog() async {
      final FormState? _key = _formKey.currentState!;
      bool isValidated = FieldValidations.validationOnButton(key: _key);
      if (isValidated) {
        setState(() {
          _isDisableFields = false;
        });
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
        try {
          String postTitle = _titleController!.text;
          String postDescription = _descriptionController!.text;
          FirebaseFirestore db = FirebaseFirestore.instance;
          await db.collection("blogs").doc(widget._documentID).update({
            "userid": UserDetails.getUserID(),
            "image": imagePath,
            "title": postTitle,
            "description": postDescription,
            "authorName": UserDetails.getName(),
            "publishedDate": widget._data['publishedDate']
          });
          _titleController!.clear();
          _descriptionController!.clear();
          imagePath = null;
          Navigator.pushNamed(context, Home.homePageRoute);
          setState(() {
            _isDisableFields = true;
          });
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Unexpected Error Found"),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      _titleController!.clear();
                      _descriptionController!.clear();
                      imagePath = null;
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      setState(() {
                        _isDisableFields = true;
                      });
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              );
            },
          );
        }
      }
    }

    void addBlog() async {
      final FormState? _key = _formKey.currentState!;
      bool isValidated = FieldValidations.validationOnButton(key: _key);
      if (isValidated) {
        setState(() {
          _isDisableFields = false;
        });
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
        try {
          FirebaseFirestore db = FirebaseFirestore.instance;
          int day = DateTime.now().day;
          int month = DateTime.now().month;
          int year = DateTime.now().year;

          String postPublishedDate = "$day/$month/$year";

          String postTitle = _titleController!.text;
          String postDescription = _descriptionController!.text;

          File file = File(imagePath!);

          String imageBaseName = basename(file.path);
          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref("Blog_Images/$imageBaseName");

          await ref.putFile(file);
          String downloadUrl = await ref.getDownloadURL();
          await db.collection("blogs").add({
            "userid": UserDetails.getUserID(),
            "image": downloadUrl,
            "title": postTitle,
            "description": postDescription,
            "authorName": UserDetails.getName(),
            "publishedDate": postPublishedDate
          });
          _titleController!.clear();
          _descriptionController!.clear();
          selectedImageFile = null;
          Navigator.pushNamed(context, Home.homePageRoute);
          // Navigator.of(context).pop();
          setState(() {
            _isDisableFields = true;
          });
        } catch (e) {
          dialogBoxError(context,
              e: e.toString(), routeName: Home.homePageRoute);
        }
      }
    }

    return SingleChildScrollView(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Material(
            child: Padding(
              padding: EdgeInsets.only(
                  right: getProportionateScreenWidth(10),
                  left: getProportionateScreenWidth(10)),
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(20)),
                  InkWell(
                    onTap: pickImage,
                    child: (selectedImageFile != null)
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: getProportionateScreenHeight(150),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.file(
                                selectedImageFile!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : (imagePath != null)
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: getProportionateScreenHeight(150),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    imagePath.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                height: getProportionateScreenHeight(150),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Icon(Icons.add_a_photo),
                              ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleController,
                          enabled: _isDisableFields,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            hintText: "Enter title",
                          ),
                          validator: (value) {
                            return FieldValidations.isBlogTitle(value: value);
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(5)),
                        TextFormField(
                          controller: _descriptionController,
                          enabled: _isDisableFields,
                          maxLines: 15,
                          decoration: const InputDecoration(
                            hintText: "Enter Description",
                          ),
                          validator: (value) {
                            return FieldValidations.isBlogDescription(
                                value: value);
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        DefaultButton(
                          text: widget._data.isNotEmpty
                              ? "Update Blog"
                              : "Upload Blog",
                          onTap: widget._data.isNotEmpty ? updateBlog : addBlog,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
