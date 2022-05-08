import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../constants.dart';

class BrokerCompany{
  final String name;
  final int overallPolicies;
  final int newRequests;
  final String ageRange;
  final int policyAgeAmount;
  final int pendingPolicies;
  final int requestedClaims;
  final charts.Color barColor;

  BrokerCompany({
    required this.name,
    required this.ageRange,
    required this.policyAgeAmount,
    required this.overallPolicies,
    required this.newRequests,
    required this.pendingPolicies,
    required this.requestedClaims,
    required this.barColor,
  });
}

final List<BrokerCompany> brokerCompaniesRegulator = [

  BrokerCompany(
      name: brokerCompanyList[0],
      ageRange: "18-25",
      policyAgeAmount: 2,
      overallPolicies: 10,
      newRequests: 3,
      pendingPolicies: 2,
      requestedClaims: 8,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue)
  ),
  BrokerCompany(
      name: brokerCompanyList[1],
      overallPolicies: 6,
      ageRange: "26-35",
      policyAgeAmount: 4,
      newRequests: 6,
      pendingPolicies: 2,
      requestedClaims: 9,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue)
  ),
  BrokerCompany(
      name: brokerCompanyList[2],
      overallPolicies: 8,
      ageRange: "36-45",
      policyAgeAmount: 6,
      newRequests: 4,
      pendingPolicies: 5,
      requestedClaims: 6,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue)
  ),
  BrokerCompany(
      name: brokerCompanyList[3],
      overallPolicies: 2,
      ageRange: "46-55",
      policyAgeAmount: 8,
      newRequests: 1,
      pendingPolicies: 2,
      requestedClaims: 7,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue)
  ),
  BrokerCompany(
      name: brokerCompanyList[4],
      overallPolicies: 4,
      ageRange: "56-60",
      policyAgeAmount: 4,
      newRequests: 3,
      pendingPolicies: 4,
      requestedClaims: 4,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue)
  ),
];