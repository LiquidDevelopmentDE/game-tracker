import 'package:flutter/material.dart';
import 'package:tallee/core/enums.dart';

class News {
  final IconData icon;
  final AppColor iconColor;
  final String heading;
  final String text;

  News({
    required this.icon,
    required this.iconColor,
    required this.heading,
    required this.text,
  });
}

final List<News> news = [
  News(
    icon: Icons.pin_drop,
    iconColor: AppColor.red,
    heading: 'Lorem ipsum',
    text: 'Lorem ipsum dolor sit amet, _consetetur_ sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut.',
  ),
  News(
    icon: Icons.exposure_rounded,
    iconColor: AppColor.green,
    heading: 'Lorem ipsum',
    text: 'labore et **dolore** magna aliquyam erat, sed diam **voluptua**. At vero eos et accusam et justo duo dolores et ea rebum. ',
  ),
  News(
    icon: Icons.dark_mode_rounded,
    iconColor: AppColor.blue,
    heading: 'Lorem ipsum',
    text: 'Stet clita kasd _gubergren_, no sea takimata sanctus est **Lorem* ipsum dolor sit amet.',
  ),
];
