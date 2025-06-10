import 'package:flutter/material.dart';
import 'package:lachaudiere/api/api.dart';
import 'package:lachaudiere/models/category.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  List<Category> categories = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final result = await Api.getCategories();
      setState(() {
        categories = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(child: Text('Erreur : $error')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Catégories')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(categories[index].name));
        },
      ),
    );
  }
}
