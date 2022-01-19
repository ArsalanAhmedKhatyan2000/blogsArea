import 'package:blogs_area/size_configuration.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String? _text;
  final void Function()? _onTap;
  const DefaultButton({
    Key? key,
    @required text,
    @required onTap,
  })  : _text = text,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: _onTap,
      child: Container(
        width: double.infinity,
        height: getProportionateScreenHeight(45),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.purple,
        ),
        child: Text(
          _text!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
