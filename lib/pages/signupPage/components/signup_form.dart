import 'package:blogs_area/pages/LoginPage/login_page.dart';
import 'package:blogs_area/pages/signupPage/signup.dart';
import 'package:blogs_area/size_configuration.dart';
import 'package:blogs_area/validations/field_validation.dart';
import 'package:blogs_area/widgets/build_dialogbox.dart';
import 'package:blogs_area/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _obscureText = true;
  bool _isDisableFields = true;
  final TextEditingController? _emailController = TextEditingController();
  final TextEditingController? _passwordController = TextEditingController();
  final TextEditingController? _nameController = TextEditingController();
  final TextEditingController? _phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  isPasswordVisible() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void signupPerson() async {
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
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;
      String name = _nameController!.text;
      String email = _emailController!.text;
      String password = _passwordController!.text;
      String phoneNumber = _phoneController!.text;
      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await db.collection('users').doc(user.user!.uid).set({
          "name": name,
          "email": email,
          "phone": phoneNumber,
        });
        _nameController!.clear();
        _emailController!.clear();
        _passwordController!.clear();
        _phoneController!.clear();
        Navigator.pushNamed(context, LoginPage.loginPageRoute);
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            enabled: _isDisableFields,
            maxLength: 15,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Enter your name",
              prefixIcon: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
            ),
            validator: (value) {
              return FieldValidations.isName(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(5)),
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
          TextFormField(
            controller: _phoneController,
            enabled: _isDisableFields,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "Enter your phone number",
              prefixIcon: Icon(
                Icons.phone,
                color: Theme.of(context).primaryColor,
              ),
            ),
            validator: (value) {
              return FieldValidations.isPhoneNumber(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Signup",
            onTap: signupPerson,
          ),
        ],
      ),
    );
  }
}
