import 'package:blogs_area/pages/LoginPage/components/user_detail.dart';
import 'package:blogs_area/pages/MyProfile/my_profile.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:blogs_area/validations/field_validation.dart';
import 'package:blogs_area/widgets/build_dialogbox.dart';
import 'package:blogs_area/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _obscureText = true;
  bool _isDisableFields = true;

  TextEditingController? _emailController = TextEditingController();
  TextEditingController? _passwordController = TextEditingController();
  TextEditingController? _nameController = TextEditingController();
  TextEditingController? _phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  isPasswordVisible() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController(text: UserDetails.getEmail());
    _passwordController =
        TextEditingController(text: UserDetails.getPassword());
    _nameController = TextEditingController(text: UserDetails.getName());
    _phoneController =
        TextEditingController(text: UserDetails.getPhoneNumber());

    super.initState();
  }

  void updateUserProfile() async {
    final FormState? _key = _formKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(key: _key);
    String name = _nameController!.text;
    String email = _emailController!.text;
    String password = _passwordController!.text;
    String phoneNumber = _phoneController!.text;
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
        FirebaseAuth instance = FirebaseAuth.instance;
        instance.currentUser!.updateEmail(email);
        instance.currentUser!.updatePassword(password);
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("users").doc(UserDetails.getUserID()).update({
          "name": name,
          "email": email,
          "phone": phoneNumber,
        });
        UserDetails.setEmail(email: email);
        UserDetails.setPassword(password: password);
        UserDetails.setName(name: name);
        UserDetails.setPhoneNumber(phoneNumber: phoneNumber);
        Navigator.pushNamed(context, MyProfile.myProfileRoute);
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
                    _nameController!.clear();
                    _emailController!.clear();
                    _passwordController!.clear();
                    _phoneController!.clear();
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Padding(
          padding: EdgeInsets.only(
            right: getProportionateScreenWidth(30),
            left: getProportionateScreenWidth(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Icon(
                      Icons.person,
                      size: getProportionateScreenHeight(100),
                      color: Colors.purple,
                    ),
                    const Text(
                      "Profile details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    TextFormField(
                      enabled: _isDisableFields,
                      controller: _nameController,
                      maxLength: 15,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(12),
                          vertical: getProportionateScreenHeight(6),
                        ),
                      ),
                      validator: (value) {
                        return FieldValidations.isName(value: value);
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    TextFormField(
                      enabled: _isDisableFields,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: Theme.of(context).primaryColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(12),
                          vertical: getProportionateScreenHeight(6),
                        ),
                      ),
                      validator: (value) {
                        return FieldValidations.isEmail(value: value);
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    TextFormField(
                      enabled: _isDisableFields,
                      controller: _passwordController,
                      obscureText: _obscureText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Enter your new password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColor,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: isPasswordVisible,
                          child: _obscureText
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black45,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: Theme.of(context).primaryColor,
                                ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(12),
                          vertical: getProportionateScreenHeight(6),
                        ),
                      ),
                      validator: (value) {
                        return FieldValidations.isPassword(value: value);
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    TextFormField(
                      enabled: _isDisableFields,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter your new phone number",
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Theme.of(context).primaryColor,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(12),
                          vertical: getProportionateScreenHeight(6),
                        ),
                      ),
                      validator: (value) {
                        return FieldValidations.isPhoneNumber(value: value);
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    DefaultButton(
                      onTap: () {
                        updateUserProfile();
                      },
                      text: "Save",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
