import 'package:flutter/material.dart';
import 'package:lachaudiere/models/event.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;

  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final startDate = event.start_date.toString().split(' ')[0];
    final endDate = event.end_date.toString().split(' ')[0];
    final price = (event.price == null || event.price == 0) ? 'Gratuit' : '${event.price} €';
    final artist = event.artist;
    final author = event.author;

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  event.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.blueAccent),
                    const SizedBox(width: 8),
                    Text('Du $startDate au $endDate'),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.euro, color: Colors.blueAccent),
                    const SizedBox(width: 8),
                    Text('Prix : $price'),
                  ],
                ),
                if (artist != null && artist.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.blueAccent),
                      const SizedBox(width: 8),
                      Text('Artiste : $artist'),
                    ],
                  ),
                ],
                if (author != null && author.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Auteur : $author',
                      style: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}