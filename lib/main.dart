import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const ScoreFootballApp());
}

class ScoreFootballApp extends StatelessWidget {
  const ScoreFootballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Score Football',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const HomePage(),
    );
  }
}

class MatchModel {
  String home;
  String away;
  int homeScore;
  int awayScore;
  DateTime date;
  String homeLogo;
  String awayLogo;

  MatchModel({
    required this.home,
    required this.away,
    required this.homeScore,
    required this.awayScore,
    required this.date,
    required this.homeLogo,
    required this.awayLogo,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  List<MatchModel> matches = [
    MatchModel(
      home: 'Persija',
      away: 'Persib',
      homeScore: 2,
      awayScore: 1,
      date: DateTime(2025, 11, 5),
      homeLogo: 'assets/logos/persija.png',
      awayLogo: 'assets/logos/persib.png',
    ),
    MatchModel(
      home: 'Arema',
      away: 'Bali United',
      homeScore: 0,
      awayScore: 0,
      date: DateTime(2025, 11, 4),
      homeLogo: 'assets/logos/arema.png',
      awayLogo: 'assets/logos/baliunited.png',
    ),
    MatchModel(
      home: 'PSM',
      away: 'Persebaya',
      homeScore: 3,
      awayScore: 2,
      date: DateTime(2025, 11, 3),
      homeLogo: 'assets/logos/psm.png',
      awayLogo: 'assets/logos/persebaya.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void updateScores() {
    final random = Random();
    _controller.forward(from: 0);
    setState(() {
      for (var match in matches) {
        match.homeScore = random.nextInt(5);
        match.awayScore = random.nextInt(5);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🏆 Score Football',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: FadeTransition(
        opacity: _animation,
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: matches.length,
          itemBuilder: (context, index) {
            final match = matches[index];
            return Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTeamColumn(match.home, match.homeLogo),
                    _buildAnimatedScore(match.homeScore, match.awayScore),
                    _buildTeamColumn(match.away, match.awayLogo),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: updateScores,
        label: const Text(
          'Update Skor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildTeamColumn(String name, String logoPath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: name,
          child: Image.asset(
            logoPath,
            width: 70,
            height: 70,
            fit: BoxFit.contain, // ✅ biar gak ke-crop
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildAnimatedScore(int home, int away) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 400),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Column(
            children: [
              Text(
                '$home : $away',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'LIVE',
                style: TextStyle(
                  color: Colors.redAccent.shade400,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
