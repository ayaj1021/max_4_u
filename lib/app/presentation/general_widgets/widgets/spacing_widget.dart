import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Spacing extends StatelessWidget {
  const Spacing({super.key});
}

final class HorizontalSpacing extends Spacing {
  const HorizontalSpacing(this.size, {super.key});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size.w);
  }
}

final class VerticalSpacing extends Spacing {
  const VerticalSpacing(
    this.size, {
    super.key,
  });
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size.h);
  }
}
