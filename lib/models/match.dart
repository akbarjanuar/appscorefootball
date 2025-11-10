class MatchModel {
  final String home;
  final String away;
  int homeScore;
  int awayScore;
  final DateTime date;
  final String homeLogo;
  final String awayLogo;

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
