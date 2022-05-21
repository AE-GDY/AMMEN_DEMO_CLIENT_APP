import 'package:charts_flutter/flutter.dart' as charts;

class BrokerCompany{
  final int claims;
  final String name;
  final int fraud;
  final int complains;
  final int carModels;
  final int policiesIssued;
  final int rejectedClaims;
  final int canceledPolicies;
  final int insuranceRate;
  final int yearsInBusiness;
  final int totalPremiums;
  final int complainsClients;
  final int complainsBrokers;
  final List<String> locations;
  final List<String> shareHolderNames;
  final int score;
  final charts.Color barColor;
  final List<Map<String,int>> ageClaims;

  BrokerCompany({ required this.canceledPolicies,
    required this.insuranceRate,
    required this.yearsInBusiness,
    required this.totalPremiums,
    required this.complainsClients,
    required this.complainsBrokers,
    required this.locations,
    required this.shareHolderNames,
    required this.complains,
    required this.carModels,
    required this.rejectedClaims,
    required this.policiesIssued,
    required this.score,
    required this.ageClaims,
    required this.fraud,
    required this.claims,
    required this.name,
    required this.barColor
  });
}