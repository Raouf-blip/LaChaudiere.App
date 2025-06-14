class Event {
  final int id;
  final String title;
  final String? artist;
  final String description;
  final DateTime start_date;
  final DateTime end_date;
  final DateTime? start_time;
  final DateTime? end_time;
  final double? price;
  final String? image;
  final String category;
  final String? author;
  final bool is_published;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.start_date,
    required this.end_date,
    required this.category,
    this.is_published = true,
    this.artist,
    this.start_time,
    this.end_time,
    this.price,
    this.image,
    this.author,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'].hashCode,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      start_date: DateTime.parse(json['start_date']),
      end_date: DateTime.parse(json['end_date']),
      category: json['category'] ?? '',
      is_published: true,
      artist: json['artist'] ?? '',
      start_time: null,
      end_time: null,
      price: json['price'] ?? 0,
      image: json['image'] ?? '',
      author: null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'start_date': start_date.toIso8601String(),
      'end_date': end_date.toIso8601String(),
      'category': category,
      'is_published': is_published,
      'artiste': artist,
      'heure_start': start_time?.toIso8601String(),
      'heure_end': end_time?.toIso8601String(),
      'price': price,
      'image': image,
      'author': author,
    };
  }

  @override
  String toString() {
    return 'Event{id: $id, name: $title, description: $description, dateStart: $start_date, dateEnd: $end_date, heureStart: $start_time, heureEnd: $end_time, price: $price, image: $image, category: $category, author: $author}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Event &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

}