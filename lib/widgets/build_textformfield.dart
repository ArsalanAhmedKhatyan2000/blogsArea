import 'package:flutter/material.dart';

class BuildTextFormField extends StatelessWidget {
  final String? _hintText;
  final TextInputType? _keyboardType;
  final IconData _prefixIcon;

  const BuildTextFormField({
    Key? key,
    @required hintText,
    @required keyboardType,
    @required prefixIcon,
  })  : _hintText = hintText,
        _keyboardType = keyboardType,
        _prefixIcon = prefixIcon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: _keyboardType,
      decoration: InputDecoration(
        hintText: _hintText!,
        prefixIcon: Icon(
          _prefixIcon,
          color: Colors.purple,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: Colors.purple),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: Colors.purple),
        ),
      ),
    );
  }
}
