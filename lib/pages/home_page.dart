import 'package:flutter/material.dart';
import '../models/match_model.dart';

class HomePage extends StatefulWidget {
  final List<MatchModel> matches;
  const HomePage({super.key, required this.matches});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? tappedIndex; // buat simpan index kartu yang diklik

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Pertandingan'),
        backgroundColor: Colors.green[700],
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.matches.length,
        itemBuilder: (context, index) {
          final match = widget.matches[index];
          final isTapped = tappedIndex == index;

          return GestureDetector(
            onTapDown: (_) {
              setState(() => tappedIndex = index);
            },
            onTapUp: (_) {
              Future.delayed(const Duration(milliseconds: 150), () {
                setState(() => tappedIndex = null);
              });
            },
            onTapCancel: () {
              setState(() => tappedIndex = null);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              transform:
                  isTapped ? Matrix4.translationValues(0, -5, 0) : Matrix4.identity(),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isTapped ? 0.3 : 0.1),
                    blurRadius: isTapped ? 12 : 6,
                    offset: Offset(0, isTapped ? 6 : 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _teamSection(match.home, match.homeLogo, TextAlign.left),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, anim) =>
                              ScaleTransition(scale: anim, child: child),
                          child: Text(
                            '${match.homeScore} - ${match.awayScore}',
                            key: ValueKey('${match.homeScore}-${match.awayScore}'),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${match.date.day}/${match.date.month}/${match.date.year}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _teamSection(match.away, match.awayLogo, TextAlign.right),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _teamSection(String name, String logoPath, TextAlign align) {
    return SizedBox(
      width: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage(logoPath),
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(height: 6),
          Text(
            name,
            textAlign: align,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
