// widgets/module_tile.dart

import 'package:flutter/material.dart';
import 'package:trogon/models/modules_model.dart'; // Assuming you have a Module model class

class ModuleTile extends StatelessWidget {
  final Module module;

  const ModuleTile({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(module.title),
        subtitle: Text(module.description),
        onTap: () {
          // You can navigate to another screen or show details for the module
          // For example:
          // Navigator.pushNamed(context, '/moduleDetails', arguments: module);
        },
      ),
    );
  }
}
