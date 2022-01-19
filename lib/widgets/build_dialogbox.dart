import 'package:flutter/material.dart';

Future<dynamic> dialogBoxWithFunctions(
  BuildContext context, {
  @required String? title,
  @required String? description,
  @required void Function()? onYes,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title!,
          textAlign: TextAlign.center,
        ),
        content: Text(
          description!,
        ),
        actions: [
          TextButton(
            onPressed: onYes,
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("No"),
          ),
        ],
      );
    },
  );
}

Future<dynamic> dialogBoxError(
  BuildContext context, {
  @required String? e,
  @required routeName,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Unexpected Error Found"),
        content: Text(e.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(routeName);
            },
            child: const Text("Cancel"),
          ),
        ],
      );
    },
  );
}
