import 'package:flutter/material.dart';
import 'package:newest_insurance/information/age_claims.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:newest_insurance/information/broker_company_info.dart';

import '../constants.dart';
import '../constants_regulator/insurance_company_list.dart';


List<BrokerCompany> brokerCompanies = [
  BrokerCompany(
    score: 500,
    fraud: insuranceCompanyListData[0]['fraud cases'],
    name: brokerCompanyList[0],
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    claims: 50,
    ageClaims: [
      {'20-40': 10},
      {'40-60': 20},
      {'60-80': 30},
      {'Below 20': 28},
    ],
    complains: 16,
    carModels: 10,
    rejectedClaims: 20,
    policiesIssued: 80,
    canceledPolicies: 10,
    complainsBrokers: 3,
    insuranceRate: 1000,
    locations: ["Fifth Settlement", "Masr el gedida", "Maadi"],
    yearsInBusiness: 10,
    shareHolderNames: ["Ahmed", "Omar", "Youssef"],
    complainsClients: 13,
    totalPremiums: 1000000,
  ),
  BrokerCompany(
    score: 800,
    fraud: insuranceCompanyListData[1]['fraud cases'],
    name: brokerCompanyList[1],
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ageClaims: [
      {'20-40': 10},
      {'40-60': 20},
      {'60-80': 30},
      {'Below 20': 28},
    ],
    claims: 20,
    complains: 26,
    carModels: 14,
    rejectedClaims: 29,
    policiesIssued: 108,
    canceledPolicies: 10,
    complainsBrokers: 3,
    insuranceRate: 1000,
    locations: ["Fifth Settlement", "Masr el gedida", "Maadi"],
    yearsInBusiness: 10,
    shareHolderNames: ["Ahmed", "Omar", "Youssef"],
    complainsClients: 13,
    totalPremiums: 1000000,
  ),
  BrokerCompany(
      score: 1000,
      name: brokerCompanyList[2],
      fraud: insuranceCompanyListData[2]['fraud cases'],
      claims: 40,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      complains: 8,
      carModels: 5,
      rejectedClaims: 6,
      policiesIssued: 60,
      canceledPolicies: 10,
      complainsBrokers: 3,
      insuranceRate: 1000,
      locations: ["Fifth Settlement", "Masr el gedida", "Maadi"],
      yearsInBusiness: 10,
      shareHolderNames: ["Ahmed", "Omar", "Youssef"],
      complainsClients: 13,
      totalPremiums: 1000000,
      ageClaims: [
        {'20-40': 10},
        {'40-60': 20},
        {'60-80': 30},
        {'Below 20': 28},
      ]

  ),
  BrokerCompany(
      score: 400,
      name: brokerCompanyList[3],
      fraud: insuranceCompanyListData[3]['fraud cases'],
      claims: 80,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      complains: 4,
      carModels: 24,
      rejectedClaims: 13,
      policiesIssued: 120,
      canceledPolicies: 10,
      complainsBrokers: 3,
      insuranceRate: 1000,
      locations: ["Fifth Settlement", "Masr el gedida", "Maadi"],
      yearsInBusiness: 10,
      shareHolderNames: ["Ahmed", "Omar", "Youssef"],
      complainsClients: 13,
      totalPremiums: 1000000,
      ageClaims: [
        {'20-40': 10},
        {'40-60': 20},
        {'60-80': 30},
        {'Below 20': 28},
      ]
  ),

];