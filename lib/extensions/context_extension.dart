import 'package:flutter/widgets.dart';

extension SizeExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;

  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;

  Size get currentSize => MediaQuery.of(this).size;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
}

extension NumberExtension on BuildContext {
  double get lowHeight => dynamicHeight(0.01);

  double get lowMediumHeight => dynamicHeight(0.03);

  double get mediumHeight => dynamicHeight(0.05);

  double get mediumLargeHeight => dynamicHeight(0.075);

  double get largeHeight => dynamicHeight(0.1);

  double get lowWidth => dynamicHeight(0.01);

  double get lowMediumWidth => dynamicHeight(0.03);

  double get mediumWidth => dynamicHeight(0.05);

  double get mediumLargeWidth => dynamicHeight(0.075);

  double get largeWidth => dynamicHeight(0.1);

  Size dynamicSquare(double val) {
    var ratio = currentSize.width / currentSize.height;
    var size = Size(val * currentSize.width, val * currentSize.height * ratio);

    return size;
  }
}
