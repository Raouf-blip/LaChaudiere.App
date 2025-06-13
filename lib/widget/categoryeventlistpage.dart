import 'package:flutter/material.dart';
import 'package:lachaudiere/api/api.dart';
import 'package:lachaudiere/models/event.dart';
import 'package:lachaudiere/widget/eventdetailpage.dart';

class CategoryEventListPage extends StatefulWidget {
  final String categoryName;

  const CategoryEventListPage({super.key, required this.categoryName});

  @override
  State<CategoryEventListPage> createState() => _CategoryEventListPageState();
}

class _CategoryEventListPageState extends State<CategoryEventListPage> {
  List<Event> events = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    try {
      final result = await Api.getEvents();
      setState(() {
        events = result.where((e) => e.category == widget.categoryName).toList();
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
      appBar: AppBar(title: Text('Événements - ${widget.categoryName}')),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text(event.title),
            subtitle: Text('${event.start_date.toString().split(' ')[0]}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventDetailPage(event: event),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
