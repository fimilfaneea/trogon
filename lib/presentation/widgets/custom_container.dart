import 'package:flutter/material.dart';

/// A container widget with shadow effects and customizable padding, margin, size, and border radius.
///
/// The [ShadowedContainer] widget provides a box with shadow effects to give a depth
/// appearance. It allows customization of margins, padding, height, width, color, and border radius,
/// while automatically applying a white background color and shadow effects for visual styling.
class ShadowedContainer extends StatelessWidget {
  /// The margin around the container.
  ///
  /// This defines the space outside the container. Defaults to [EdgeInsets.all(8)].
  final EdgeInsets? margin;

  /// The padding inside the container.
  ///
  /// This defines the space around the [child] widget inside the container. Defaults to [EdgeInsets.all(8)].
  final EdgeInsets? padding;

  /// The widget inside the container.
  ///
  /// This is the main content of the container that will be displayed inside.
  final Widget child;

  /// The height of the container.
  ///
  /// This defines the height of the container. If not provided, the container will size itself
  /// according to its child's size.
  final double? height;

  /// The width of the container.
  ///
  /// This defines the width of the container. If not provided, the container will size itself
  /// according to its child's size.
  final double? width;

  /// The background color of the container.
  ///
  /// This allows customization of the container's background color. If not provided, the default is white.
  final Color? color;

  /// The border radius of the container's corners.
  ///
  /// This defines the roundness of the container's corners. Defaults to 20.
  final double? borderRadius;

  /// Creates a [ShadowedContainer] widget with the provided properties.
  ///
  /// The [child] is required, while other parameters such as [margin], [padding], [height], [width],
  /// [color], and [borderRadius] are optional and have default values.
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
        color: color ?? Colors.white, // Use provided color or default to white
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Light shadow for depth
            offset: const Offset(-3, -3),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Dark shadow for contrast
            offset: const Offset(3, 3),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(borderRadius!), // Apply rounded corners
      ),
      child: child,
    );
  }
}
