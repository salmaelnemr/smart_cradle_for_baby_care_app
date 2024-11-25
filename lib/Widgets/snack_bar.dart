import 'package:flutter/material.dart';
import '../Core/route_utils/route_utils.dart';

void showSnackBar(
  String message, {
  bool showDismissButton = false,
  bool error = false,
}) {
  ScaffoldMessenger.of(RouteUtils.context).hideCurrentSnackBar();
  ScaffoldMessenger.of(RouteUtils.context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      action: showDismissButton
          ? SnackBarAction(
              onPressed: () {
                print('Dismiss');
              },
              textColor: Colors.yellow,
              label: "Dismiss",
            )
          : null,
    ),
  );
}
