import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tallee/presentation/utils/navigation/adaptive_page_route.dart';

/// Returns a platform-adaptive sheet route
Route<T> adaptiveSheetRoute<T>({
  required Widget Function(BuildContext) builder,
  RouteSettings? settings,
}) {
  if (Platform.isIOS) {
    return CupertinoSheetRoute<T>(
      settings: settings,
      scrollableBuilder: (context, controller) => builder(context),
    );
  }
  return adaptivePageRoute<T>(
    settings: settings,
    builder: builder,
    fullscreenDialog: true,
  );
}
