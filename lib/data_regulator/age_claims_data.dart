import 'package:flutter/material.dart';
import 'package:newest_insurance/information/age_claims.dart';
import 'package:charts_flutter/flutter.dart' as charts;

final List<AgeClaims> ageClaims = [
  AgeClaims(
    claims: 20,
    name: '20-40',
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  AgeClaims(
    claims: 17,
    name: '40-60',
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  AgeClaims(
    claims: 14,
    name: '60-80',
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  AgeClaims(
    claims: 28,
    name: 'Below 20',
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
];