import 'package:flutter/material.dart';
import 'package:newest_insurance/information/age_claims.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:newest_insurance/information/broker_company_info.dart';


List<BrokerCompany> brokerCompanies = [
  BrokerCompany(
      score: 200,
      name: 'Deraya Insurance Brokerage',
      barColor: charts.ColorUtil.fromDartColor(Colors.blue)
  ),
  BrokerCompany(
      score: 600,
      name: 'BMW Egypt Insurance',
      barColor: charts.ColorUtil.fromDartColor(Colors.blue)
  ),
  BrokerCompany(
      score: 400,
      name: 'Future Insurance Brokerage',
      barColor: charts.ColorUtil.fromDartColor(Colors.blue)
  ),
  BrokerCompany(
      score: 800,
      name: 'GoodLife Insurance Brokers',
      barColor: charts.ColorUtil.fromDartColor(Colors.blue)
  ),
  BrokerCompany(
      score: 800,
      name: 'GIG Insurance Brokers',
      barColor: charts.ColorUtil.fromDartColor(Colors.blue)
  ),

];