import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newest_insurance/data/insurance_companies_data.dart';
import 'package:newest_insurance/data_regulator/yearly_issuance_list.dart';
import 'package:newest_insurance/information/issuances_in_year.dart';
import 'package:newest_insurance/models/user_vehicle.dart';
import 'package:newest_insurance/services/database.dart';
import 'package:newest_insurance/widgets/bar_chart.dart';
import 'package:newest_insurance/widgets_regulator/info_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants.dart';


class Policies extends StatefulWidget {
  const Policies({Key? key}) : super(key: key);

  @override
  _PoliciesState createState() => _PoliciesState();
}

class _PoliciesState extends State<Policies> {

  List<Map> selectedComps = [];
  bool companySelected = false;
  Map currentlySelected = {};

  Future<Map<String, dynamic>?> policyRequestData() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc(insComp).get()).data();
  }

  Future<Map<String, dynamic>?> brokerPolicyRequestData() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests-broker').
    doc(brokerComp).get()).data();
  }

  Future<Map<String, dynamic>?> claimRequestData() async {
    return (await FirebaseFirestore.instance.collection('users-claim-requests').
    doc("claims").get()).data();
  }

  Future<Map<String, dynamic>?> brokerClaimRequestData() async {
    return (await FirebaseFirestore.instance.collection('users-claim-requests-broker').
    doc("claims").get()).data();
  }

  List<String> chosenType = brokerCompanyList;
  bool brokerChosen = false;

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        fontSize: MediaQuery.of(context).size.height / 30,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Policies"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pushNamed(context, '/');
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.logout, color: Colors.white,),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          width: 1500,
          height: 1500,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                //right: 0,
                child: Container(
                  width: 210,
                  height: MediaQuery.of(context).size.height,
                  //color: Colors.grey[200],
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded,
                          size: currentRegulatorTab == "Dashboard"?32:25,
                          color: currentRegulatorTab == "Dashboard"?Colors.black:Colors.grey,),
                        title: Text("Dashboard", style: TextStyle(
                            fontSize: currentRegulatorTab == "Dashboard"?17:12,
                            fontWeight: currentRegulatorTab == "Dashboard"?FontWeight.bold:FontWeight.normal
                        ),),
                        onTap: (){
                          setState(() {
                            currentRegulatorTab = "Dashboard";
                            Navigator.pushNamed(context, '/home-regulator');
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      ListTile(
                        leading: Icon(Icons.directions_car,
                          size: currentRegulatorTab == "Insurance Companies"?32:25,
                          color: currentRegulatorTab == "Insurance Companies"?Colors.black:Colors.grey,),
                        title: Text("Insurance Companies", style: TextStyle(
                            fontSize: currentRegulatorTab == "Insurance Companies"?17:12,
                            fontWeight: currentRegulatorTab == "Insurance Companies"?FontWeight.bold:FontWeight.normal
                        ),),
                        onTap: (){
                          setState(() {
                            currentRegulatorTab = "Insurance Companies";
                            Navigator.pushNamed(context, '/insurance_details');
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded,
                          size: currentRegulatorTab == "Broker Companies"?32:25,
                          color: currentRegulatorTab == "Broker Companies"?Colors.black:Colors.grey,
                        ),
                        title: Text("Broker Companies", style: TextStyle(
                          fontSize: currentRegulatorTab == "Broker Companies"?17:12,
                          fontWeight: currentRegulatorTab == "Broker Companies"?FontWeight.bold:FontWeight.normal,
                        ),),
                        onTap: (){
                          setState(() {
                            currentRegulatorTab = "Broker Companies";
                            Navigator.pushNamed(context, '/broker_details');
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded,
                          size: currentRegulatorTab == "Claims"?32:25,
                          color: currentRegulatorTab == "Claims"?Colors.black:Colors.grey,),
                        title: Text("Claims", style: TextStyle(
                          fontSize: currentRegulatorTab == "Claims"?17:12,
                          fontWeight: currentRegulatorTab == "Claims"?FontWeight.bold:FontWeight.normal,
                        ),),
                        onTap: (){
                          setState(() {
                            currentRegulatorTab = "Claims";
                            Navigator.pushNamed(context, '/claims-regulator');
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded,
                          size: currentRegulatorTab == "Policies"?32:25,
                          color: currentRegulatorTab == "Policies"?Colors.black:Colors.grey,),
                        title: Text("Policies", style: TextStyle(
                          fontSize: currentRegulatorTab == "Policies"?17:12,
                          fontWeight: currentRegulatorTab == "Policies"?FontWeight.bold:FontWeight.normal,
                        ),),
                        onTap: (){
                          setState(() {
                            currentRegulatorTab = "Policies";
                            Navigator.pushNamed(context, '/policies-regulator');
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded,
                          size: currentRegulatorTab == "Complains"?32:25,
                          color: currentRegulatorTab == "Complains"?Colors.black:Colors.grey,),
                        title: Text("Complains", style: TextStyle(
                          fontSize: currentRegulatorTab == "Complains"?17:12,
                          fontWeight: currentRegulatorTab == "Complains"?FontWeight.bold:FontWeight.normal,
                        ),),
                        onTap: (){
                          setState(() {
                            currentRegulatorTab = "Complains";
                            Navigator.pushNamed(context, '/complains_regulator');
                          });
                        },
                      ),
                      SizedBox(height: 10,),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded,
                          size: currentRegulatorTab == "Fraud"?32:25,
                          color: currentRegulatorTab == "Fraud"?Colors.black:Colors.grey,),
                        title: Text("Fraud", style: TextStyle(
                          fontSize: currentRegulatorTab == "Fraud"?17:12,
                          fontWeight: currentRegulatorTab == "Fraud"?FontWeight.bold:FontWeight.normal,
                        ),),
                        onTap: (){
                          setState(() {
                            currentRegulatorTab = "Fraud";
                            Navigator.pushNamed(context, '/fraud');
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 230,
                child: Container(
                  width: 1000,
                  height: 200,
                  child: Row(
                    children: [
                      InfoCard(
                        title: "Total Policy Issuances",
                        value: "480",
                        onTap: () {},
                        topColor: Colors.orange,
                      ),
                      SizedBox(
                        width: _width / 64,
                      ),
                      InfoCard(
                        title: "Rejected Policy Requests",
                        value: "35%",
                        topColor: Colors.lightGreen,
                        onTap: () {},
                      ),
                      SizedBox(
                        width: _width / 64,
                      ),
                      InfoCard(
                        title: "Total Insurance Company Issuances",
                        value: "100",
                        topColor: Colors.redAccent,
                        onTap: () {},
                      ),
                      SizedBox(
                        width: _width / 64,
                      ),
                      InfoCard(
                        title: "Total Broker Company Issuances",
                        value: "380",
                        topColor: Colors.redAccent,
                        onTap: () {},
                      ),
                      SizedBox(
                        width: _width / 64,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 770,
                top: 200,
                child: Container(
                  width: 400,
                  height: 300,
                  child: SfCartesianChart(
                    title: ChartTitle(text: "Policies Issuances over years"),
                    series: <ChartSeries>[
                      LineSeries<IssuancesInYear,double>(
                          dataSource: yearlyIssuances,
                          xValueMapper: (IssuancesInYear current, _)=>current.year,
                          yValueMapper: (IssuancesInYear current, _)=>current.issuances),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 270,
                top: 200,
                child: Container(
                  width: 400,
                  height: 300,
                  child: SfCartesianChart(
                    title: ChartTitle(text: "Policy Rejections over years"),
                    series: <ChartSeries>[
                      LineSeries<IssuancesInYear,double>(
                          dataSource: yearlyIssuances,
                          xValueMapper: (IssuancesInYear current, _)=>current.year,
                          yValueMapper: (IssuancesInYear current, _)=>current.issuances),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 560,
                child: Container(
                  width: 1000,
                  height: 300,
                  child: BarChart(data: insuranceCompanies, title: "Policy Issuances", chartType: "claims",),
                ),
              ),

              Positioned(
                left: 230,
                top: 860,
                child: Container(
                  width: 1000,
                  height: 300,
                  child: BarChart(data: insuranceCompanies, title: "Policy Rejections", chartType: "claims",),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
