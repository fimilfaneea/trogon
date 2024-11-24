import 'package:flutter/material.dart';
import 'package:trogon/models/modules_model.dart';
import 'package:trogon/presentation/widgets/custom_container.dart';

/// A widget that displays a tile for a given module.
///
/// This widget is used to show the title and description of a [Module] and provides
/// a tap gesture that navigates to a video list page when tapped.
class ModuleTile extends StatelessWidget {
  /// The module to be displayed in the tile.
  final Module module;

  /// Constructs a [ModuleTile] widget with the provided [module].
  const ModuleTile({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return ShadowedContainer(
      child: ListTile(
        title: Text(
          module.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        subtitle: Text(module.description),
        onTap: () {
          // Navigate to the '/videos' screen, passing the module ID as an argument.
          Navigator.pushNamed(
            context,
            '/videos',
            arguments: module.id,
          );
        },
      ),
    );
  }
}
