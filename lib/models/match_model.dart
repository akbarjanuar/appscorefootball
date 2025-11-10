class MatchModel {
  final String home;
  final String away;
  final String homeLogo;
  final String awayLogo;
  final int homeScore;
  final int awayScore;
  final DateTime date;

  MatchModel({
    required this.home,
    required this.away,
    required this.homeLogo,
    required this.awayLogo,
    required this.homeScore,
    required this.awayScore,
    required this.date,
  });
}
