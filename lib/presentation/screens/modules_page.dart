import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trogon/bloc/modules/modules_bloc.dart';
import 'package:trogon/bloc/modules/modules_event.dart';
import 'package:trogon/bloc/modules/modules_state.dart';
import 'package:trogon/presentation/widgets/modules_tile.dart';
import 'package:trogon/services/modules_service.dart';

class ModulesPage extends StatefulWidget {
  final String subjectId;
  final String subjectTitle;

  const ModulesPage(
      {super.key, required this.subjectId, required this.subjectTitle});

  @override
  ModulesPageState createState() => ModulesPageState();
}

class ModulesPageState extends State<ModulesPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectTitle} Modules'),
      ),
      body: BlocProvider(
        create: (context) => ModuleBloc(FetchModulesService())
          ..add(FetchModules(widget.subjectId)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search modules by title',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (query) {
                  print("Fimil Search Query: $query"); // Debug print for search input
                  context.read<ModuleBloc>().add(
                      FilterModules(query)); // Dispatch the event to filter
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<ModuleBloc, ModuleState>(
  builder: (context, state) {
    if (state is ModuleLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is ModuleLoaded) {
      final filteredModules = state.filteredModules;
      print('Fimil Rendering Filtered Modules: ${filteredModules.length}');
      
      return ListView.builder(
        itemCount: filteredModules.length,
        itemBuilder: (context, index) {
          final module = filteredModules[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/videos',
                arguments: module.id,
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
)

            ),
          ],
        ),
      ),
    );
  }
}
