import 'package:flutter/material.dart';
import 'package:trogon/models/modules_model.dart';
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
  List<Module> allModules = []; // To hold all the modules
  List<Module> filteredModules = []; // To hold filtered modules

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Fetch all modules for this subject
    _fetchModules();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Fetch modules (mocking service call here)
  Future<void> _fetchModules() async {
    // Mock fetch from service
    final modules = await FetchModulesService().fetchModules(widget.subjectId);
    setState(() {
      allModules = modules;
      filteredModules = modules; // Initially, show all modules
    });
  }

  // Filtering function for modules based on search query
  List<Module> _filterModules(List<Module> allModules, String value) {
    final lowerCaseValue = value.toLowerCase();
    return allModules
        .where((module) =>
            module.title.toLowerCase().contains(lowerCaseValue))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectTitle} Modules'),
      ),
      body: Column(
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
                print("Fimil Search Query: $query");
                setState(() {
                  filteredModules = _filterModules(allModules, query);
                });
              },
            ),
          ),
          Expanded(
            child: filteredModules.isEmpty
                ? const Center(child: Text('No modules found.'))
                : ListView.builder(
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
                  ),
          ),
        ],
      ),
    );
  }
}
