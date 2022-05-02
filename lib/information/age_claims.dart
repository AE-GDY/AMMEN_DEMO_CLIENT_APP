import 'package:charts_flutter/flutter.dart' as charts;

class AgeClaims{
  final int claims;
  final String name;
  final charts.Color barColor;

  AgeClaims({required this.claims, required this.name, required this.barColor});
}