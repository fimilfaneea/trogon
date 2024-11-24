import 'package:flutter/material.dart';
import 'package:trogon/models/modules_model.dart';
import 'package:trogon/presentation/widgets/modules_tile.dart';
import 'package:trogon/services/modules_service.dart';

/// A page displaying a list of modules for a specific subject.
///
/// This page allows the user to search for modules by title. The modules
/// are fetched from a service based on the [subjectId] and are displayed
/// in a list. The user can tap on a module to navigate to a related video
/// page.
class ModulesPage extends StatefulWidget {
  /// The unique identifier for the subject.
  final String subjectId;

  /// The title of the subject.
  final String subjectTitle;

  const ModulesPage({
    super.key,
    required this.subjectId,
    required this.subjectTitle,
  });

  @override
  ModulesPageState createState() => ModulesPageState();
}

class ModulesPageState extends State<ModulesPage> {
  /// Controller for the search input field.
  late TextEditingController _searchController;

  /// A list to hold all modules fetched from the service.
  List<Module> allModules = [];

  /// A list to hold the filtered modules based on the search query.
  List<Module> filteredModules = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Fetch all modules when the page is initialized.
    _fetchModules();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Fetches modules for the given subject ID from the service.
  ///
  /// If the [subjectId] is '1', it will mock a service call and fetch modules.
  /// If the [subjectId] is anything other than '1', no modules will be fetched.
  Future<void> _fetchModules() async {
    if (widget.subjectId == '1') {
      // Mock fetch from service only if subjectId == '1'
      final modules = await FetchModulesService().fetchModules(widget.subjectId);
      setState(() {
        allModules = modules;
        filteredModules = modules; // Initially, show all modules
      });
    } else {
      // If subjectId is not '1', show no modules
      setState(() {
        allModules = [];
        filteredModules = [];
      });
    }
  }

  /// Filters the list of modules based on the search query.
  ///
  /// The function compares the module title with the search query and returns
  /// a list of modules whose title contains the query.
  ///
  /// [allModules]: The list of all available modules.
  /// [value]: The search query entered by the user.
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
          // Search input field for filtering modules by title.
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
              // Update the filtered modules list when the search query changes.
              onChanged: (query) {
                setState(() {
                  filteredModules = _filterModules(allModules, query);
                });
              },
            ),
          ),
          // Display the filtered modules in a list view.
          Expanded(
            child: filteredModules.isEmpty
                ? const Center(child: Text('No modules found.'))
                : ListView.builder(
                    itemCount: filteredModules.length,
                    itemBuilder: (context, index) {
                      final module = filteredModules[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the video page when a module is tapped.
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
