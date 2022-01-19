import 'package:flutter/material.dart';

class BuildNoAccountStrip extends StatelessWidget {
  final String? _firstText;
  final String? _lastText;
  final void Function()? _onTap;
  const BuildNoAccountStrip({
    Key? key,
    @required firstText,
    @required lastText,
    @required onTap,
  })  : _firstText = firstText,
        _lastText = lastText,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_firstText!),
        GestureDetector(
          onTap: _onTap,
          child: Text(
            _lastText!,
            style: const TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
