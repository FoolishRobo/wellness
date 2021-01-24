import 'package:flutter/material.dart';

void showToast(BuildContext context, String text,
    {String action = "OK", Color color, Function toastAction}) {
  // SnackBar not showing? Try: https://stackoverflow.com/a/51304732/5129047

  final scaffold = Scaffold.of(context);

  if (color != null) {
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
        action: SnackBarAction(
          label: action,
          onPressed:
              toastAction != null ? toastAction : scaffold.hideCurrentSnackBar,
          textColor: Colors.white,
        ),
      ),
    );
  } else {
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: action,
          onPressed:
              toastAction != null ? toastAction : scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }
}
