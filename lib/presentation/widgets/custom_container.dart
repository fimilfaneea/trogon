import 'package:flutter/material.dart';

class ShadowedContainer extends StatelessWidget {
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget child;
  final double? height;
  final double? width;
  final Color? color;
  final double? borderRadius;
  const ShadowedContainer({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.all(8),
    this.padding = const EdgeInsets.all(8),
    this.height,
    this.width,
    this.color,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(-3, -3),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(3, 3),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
      child: child,
    );
  }
}
