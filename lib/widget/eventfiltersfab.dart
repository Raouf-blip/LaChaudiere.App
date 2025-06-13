import 'package:flutter/material.dart';

class EventFilterFab extends StatelessWidget {
  final VoidCallback onCycleSort;
  final VoidCallback onCycleFilter;
  final String currentSortLabel;
  final String currentFilterLabel;
  final IconData currentSortIcon;
  final IconData currentFilterIcon;
  final bool isExpanded;
  final VoidCallback onToggleExpanded;

  const EventFilterFab({
    super.key,
    required this.onCycleSort,
    required this.onCycleFilter,
    required this.currentSortLabel,
    required this.currentFilterLabel,
    required this.currentSortIcon,
    required this.currentFilterIcon,
    required this.isExpanded,
    required this.onToggleExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isExpanded) ...[
          _buildActionButton(
            icon: currentSortIcon,
            label: 'Trier : $currentSortLabel',
            onPressed: onCycleSort,
          ),
          const SizedBox(height: 8),
          _buildActionButton(
            icon: currentFilterIcon,
            label: 'Filtrer : $currentFilterLabel',
            onPressed: onCycleFilter,
          ),
          const SizedBox(height: 8),
        ],
        FloatingActionButton(
          onPressed: onToggleExpanded,
          backgroundColor: Colors.white,
          child: Icon(
            isExpanded ? Icons.close : Icons.menu,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return FloatingActionButton.extended(
      heroTag: label,
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.blue),
      label: Text(label, style: const TextStyle(color: Colors.blue)),
      backgroundColor: Colors.white,
    );
  }
}
