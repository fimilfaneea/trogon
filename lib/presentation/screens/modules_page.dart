import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/modules/modules_bloc.dart';
import 'package:trogon/bloc/modules/modules_event.dart';
import 'package:trogon/bloc/modules/modules_state.dart';
import 'package:trogon/presentation/widgets/modules_tile.dart';
import 'package:trogon/services/modules_service.dart';

class ModulesPage extends StatelessWidget {
  final String subjectId;
  final String subjectTitle;

  const ModulesPage(
      {super.key, required this.subjectId, required this.subjectTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$subjectTitle Modules'),
      ),
      body: BlocProvider(
        create: (context) =>
            ModuleBloc(FetchModulesService())..add(FetchModules(subjectId)),
        child: BlocBuilder<ModuleBloc, ModuleState>(
          builder: (context, state) {
            if (state is ModuleLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ModuleLoaded) {
              return ListView.builder(
                itemCount: state.modules.length,
                itemBuilder: (context, index) {
                  final module = state.modules[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to VideosPage using the named route and passing moduleId as argument
                      Navigator.pushNamed(
                        context,
                        '/videos',
                        arguments: module.id, // Pass moduleId as argument
                      );
                    },
                    child: ModuleTile(module: module),
                  );
                },
              );
            }
            if (state is ModuleError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('No modules available.'));
          },
        ),
      ),
    );
  }
}
