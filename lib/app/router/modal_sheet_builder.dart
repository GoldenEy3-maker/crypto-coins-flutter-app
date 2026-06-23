import "package:flutter/material.dart";

Route<T> modalSheetBuilder<T>(
  BuildContext context,
  Widget child,
  RouteSettings page,
) {
  return ModalBottomSheetRoute(
    settings: page,
    builder: (context) => child,
    isScrollControlled: true, // Allows sheet to expand based on content
    useSafeArea: true,
  );
}
