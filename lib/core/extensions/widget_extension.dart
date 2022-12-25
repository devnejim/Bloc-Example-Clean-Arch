import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget coloredPadded({Color? color, double? paddingVal}) => ColoredBox(
        color: color ?? Colors.yellow,
        child: Padding(
          padding: EdgeInsets.all(paddingVal ?? 4),
          child: this,
        ),
      );

  Widget paddedColored({Color? color, double? paddingVal}) => Padding(
        padding: EdgeInsets.all(paddingVal ?? 4),
        child: ColoredBox(
          color: color ?? Colors.red,
          child: this,
        ),
      );

  Widget paddingSymetric({double? vertical, double? horizontal}) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontal ?? 4, vertical: vertical ?? 4),
        child: this,
      );

  Widget paddingAll([double padding = 8]) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget colored({Color? color}) => ColoredBox(
        color: color ?? Colors.red,
        child: this,
      );

  Widget align({Alignment? alignment}) =>
      Align(alignment: alignment ?? Alignment.centerLeft, child: this);

  Widget get center => Center(child: this);
}
