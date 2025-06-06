class Event {
  final String id;
  final String title;
  final String category;
  final DateTime startDate;
  final DateTime? endDate;
  final String? description;
  final String? location;
  final String? imageUrl;

  Event({
    required this.id,
    required this.title,
    required this.category,
    required this.startDate,
    this.endDate,
    this.description,
    this.location,
    this.imageUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      category: json['category'] ?? json['type'] ?? '',
      startDate: DateTime.parse(json['startDate'] ?? json['date']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      description: json['description'],
      location: json['location'],
      imageUrl: json['imageUrl'] ?? json['image'],
    );
  }
  
  String get formattedDate {
    if (endDate != null && !isSameDay(startDate, endDate!)) {
      return '${_formatDate(startDate)} - ${_formatDate(endDate!)}';
    }
    return _formatDate(startDate);
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}