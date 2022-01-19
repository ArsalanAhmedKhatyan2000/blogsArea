import 'package:blogs_area/pages/LoginPage/components/user_detail.dart';
import 'package:blogs_area/pages/LoginPage/login_page.dart';
import 'package:blogs_area/pages/homePage/home_page.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:blogs_area/validations/field_validation.dart';
import 'package:blogs_area/widgets/build_dialogbox.dart';
import 'package:blogs_area/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  bool _isDisableFields = true;
  final TextEditingController? _emailController = TextEditingController();
  final TextEditingController? _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  isPasswordVisible() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void signInPerson() async {
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
        FirebaseAuth auth = FirebaseAuth.instance;
        FirebaseFirestore db = FirebaseFirestore.instance;
        String email = _emailController!.text;
        String password = _passwordController!.text;

        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        final DocumentSnapshot snapshot =
            await db.collection('users').doc(user.user!.uid).get();

        dynamic data = snapshot.data();
        UserDetails.setUserID(userID: user.user!.uid);
        UserDetails.setEmail(email: data["email"]);
        UserDetails.setName(name: data["name"]);
        UserDetails.setPhoneNumber(phoneNumber: data["phone"]);
        UserDetails.setPassword(password: password);

        _emailController!.clear();
        _passwordController!.clear();

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
                    _emailController!.clear();
                    _passwordController!.clear();
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            enabled: _isDisableFields,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Enter your email",
              prefixIcon: Icon(
                Icons.email,
                color: Theme.of(context).primaryColor,
              ),
            ),
            validator: (value) {
              return FieldValidations.isEmail(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          TextFormField(
            obscureText: _obscureText,
            enabled: _isDisableFields,
            controller: _passwordController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Enter your password",
              prefixIcon: Icon(
                Icons.lock,
                color: Theme.of(context).primaryColor,
              ),
              suffixIcon: InkWell(
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
            ),
            validator: (value) {
              return FieldValidations.isPassword(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            onTap: signInPerson,
            text: "Login",
          ),
        ],
      ),
    );
  }
}
