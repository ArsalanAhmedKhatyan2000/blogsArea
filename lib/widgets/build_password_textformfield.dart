import 'package:flutter/material.dart';

class BuildPasswordFormField extends StatelessWidget {
  const BuildPasswordFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: "Enter your password",
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.purple,
        ),
        suffixIcon: Icon(
          Icons.visibility_off,
          color: Colors.purple,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: Colors.purple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: Colors.purple),
        ),
      ),
    );
  }
}
