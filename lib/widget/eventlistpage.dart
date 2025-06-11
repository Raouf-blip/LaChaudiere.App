import 'package:flutter/material.dart';
import 'package:lachaudiere/api/api.dart';
import 'package:lachaudiere/models/event.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
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
        events = result;
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
      appBar: AppBar(title: const Text('Evènements')),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(events[index].title));
        },
      ),
    );
  }
}
