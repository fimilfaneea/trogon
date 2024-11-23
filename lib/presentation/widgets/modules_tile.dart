// widgets/module_tile.dart

import 'package:flutter/material.dart';
import 'package:trogon/models/modules_model.dart';
import 'package:trogon/presentation/widgets/custom_container.dart';

class ModuleTile extends StatelessWidget {
  final Module module;

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
