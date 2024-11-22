// widgets/module_tile.dart

import 'package:flutter/material.dart';
import 'package:trogon/models/modules_model.dart';

class ModuleTile extends StatelessWidget {
  final Module module;

  const ModuleTile({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(module.title),
      subtitle: Text(module.description),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/videos',
          arguments: module.id,
        );
      },
    );
  }
}
