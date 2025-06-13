import 'package:flutter/material.dart';
import 'package:lachaudiere/api/api.dart';
import 'package:lachaudiere/models/category.dart';
import 'package:lachaudiere/models/event.dart';
import 'package:lachaudiere/widget/eventdetailpage.dart';
import 'package:lachaudiere/widget/eventfiltersfab.dart';

enum SortMode { dateAsc, dateDesc, title }

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  SortMode _sortMode = SortMode.dateAsc;
  String? error;
  bool isLoading = true;
  List<Category> _categories = [];
  int _currentCategoryIndex = -1;
  List<Event> allEvents = [];
  bool fabExpanded = false;

  @override
  void initState() {
    super.initState();
    loadElements();
  }

  Future<void> loadElements() async {
    try {
      final resultE = await Api.getEvents();
      final resultC = await Api.getCategories();
      setState(() {
        allEvents = resultE;
        _categories = resultC;
        isLoading = false;
        _currentCategoryIndex = _categories.isNotEmpty ? _categories.length : -1;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  void _cycleSortMode() {
    setState(() {
      _sortMode =
      SortMode.values[(_sortMode.index + 1) % SortMode.values.length];
    });
  }

  void _cycleFilterMode() {
    if (_categories.isEmpty) return;

    setState(() {
      _currentCategoryIndex =
          (_currentCategoryIndex + 1) % (_categories.length + 1); // +1 = Tous
    });
  }

  String _getSortLabel() {
    switch (_sortMode) {
      case SortMode.dateAsc:
        return 'Date';
      case SortMode.dateDesc:
        return 'Date';
      case SortMode.title:
        return 'Titre';
    }
  }

  IconData _getSortIcon() {
    switch (_sortMode) {
      case SortMode.dateAsc:
        return Icons.arrow_upward;
      case SortMode.dateDesc:
        return Icons.arrow_downward;
      case SortMode.title:
        return Icons.title;
    }
  }

  String _getFilterLabel() {
    if (_currentCategoryIndex == _categories.length || _categories.isEmpty) {
      return 'Tous';
    }
    return _categories[_currentCategoryIndex].name;
  }

  IconData _getFilterIcon() {
    if (_currentCategoryIndex == _categories.length || _categories.isEmpty) {
      return Icons.filter_list;
    }
    return Icons.category;
  }

  List<Event> _applyFiltersAndSorting() {
    List<Event> filtered = allEvents;

    if (_currentCategoryIndex != _categories.length &&
        _currentCategoryIndex >= 0 &&
        _currentCategoryIndex < _categories.length) {
      final selectedCategory = _categories[_currentCategoryIndex].name;
      filtered =
          filtered.where((e) => e.category == selectedCategory).toList();
    }

    switch (_sortMode) {
      case SortMode.dateAsc:
        filtered.sort((a, b) => a.start_date.compareTo(b.start_date));
        break;
      case SortMode.dateDesc:
        filtered.sort((a, b) => b.start_date.compareTo(a.start_date));
        break;
      case SortMode.title:
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    List<Event> displayedEvents = _applyFiltersAndSorting();

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des événements'),
      ),
      body: ListView.builder(
        itemCount: displayedEvents.length,
        itemBuilder: (context, index) {
          final event = displayedEvents[index];
          return ListTile(
            title: Text(event.title),
            subtitle: Text('${event.start_date.toString().split(' ')[0]}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailPage(event: event),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: EventFilterFab(
        onCycleSort: _cycleSortMode,
        onCycleFilter: _cycleFilterMode,
        currentSortLabel: _getSortLabel(),
        currentFilterLabel: _getFilterLabel(),
        currentSortIcon: _getSortIcon(),
        currentFilterIcon: _getFilterIcon(),
        isExpanded: fabExpanded,
        onToggleExpanded: () {
          setState(() {
            fabExpanded = !fabExpanded;
          });
        },
      ),
    );
  }
}
