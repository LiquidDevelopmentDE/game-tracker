import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<T> AdaptivePageRoute<T>({
  required Widget Function(BuildContext) builder,
  bool fullscreenDialog = false,
}) {
  if (Platform.isIOS) {
    return CupertinoPageRoute<T>(
      builder: builder,
      fullscreenDialog: fullscreenDialog,
    );
  }
  return MaterialPageRoute<T>(
    builder: builder,
    fullscreenDialog: fullscreenDialog,
  );
}
