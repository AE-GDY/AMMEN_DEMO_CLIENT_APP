import 'package:charts_flutter/flutter.dart' as charts;

class BrokerCompany{
  final int score;
  final String name;
  final charts.Color barColor;

  BrokerCompany({required this.score, required this.name, required this.barColor});
}