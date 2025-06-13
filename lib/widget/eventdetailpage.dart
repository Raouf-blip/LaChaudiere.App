import 'package:flutter/material.dart';
import 'package:lachaudiere/models/event.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;

  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(event.description),
                    const SizedBox(height: 16),
                    Text('Début : ${event.start_date.toString().split(' ')[0]}'),
                    Text('Fin : ${event.end_date.toString().split(' ')[0]}'),
                    const SizedBox(height: 8),
                    if (event.image != null && event.image!.isNotEmpty)
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.asset(
                          'images/${event.image}',
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(
                              height: 200,
                              child: Center(child: Text("Image non disponible")),
                            );
                          },
                        ),
                      ),

                    if (event.artist != null && event.artist!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text('Artiste : ${event.artist!}'),
                    ],
                    if (event.author != null && event.author!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Auteur : ${event.author!}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Text(
                      event.price == null || event.price == 0
                          ? 'Gratuit'
                          : 'Prix : ${event.price} €',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
