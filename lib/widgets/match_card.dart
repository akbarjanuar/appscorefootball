import 'package:flutter/material.dart';
import '../models/match.dart';

class MatchCard extends StatelessWidget {
  final MatchModel match;
  final VoidCallback onUpdate;

  const MatchCard({
    super.key,
    required this.match,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(match.home, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('${match.homeScore} - ${match.awayScore}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(match.away, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${match.date.day}/${match.date.month}/${match.date.year}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: onUpdate,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text("Update Skor"),
            ),
          ],
        ),
      ),
    );
  }
}

