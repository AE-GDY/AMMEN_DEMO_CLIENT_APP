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


class Claims extends StatefulWidget {
  const Claims({Key? key}) : super(key: key);

  @override
  _ClaimsState createState() => _ClaimsState();
}

class _ClaimsState extends State<Claims> {

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

  List<String> chosenType = brokerCompanyList;
  bool brokerChosen = false;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Claims"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded),
                        title: Text("Dashboard", style: TextStyle(
                          fontSize: 12,
                        ),),
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(context, '/home-regulator');
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text("Insurance Companies", style: TextStyle(
                          fontSize: 12,
                        ),),
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(context, '/insurance_details');
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded),
                        title: Text("Broker Companies", style: TextStyle(
                          fontSize: 12,
                        ),),
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(context, '/broker_details');
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded),
                        title: Text("Claims", style: TextStyle(
                          fontSize: 12,
                        ),),
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(context, '/claims-regulator');
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded),
                        title: Text("Policies", style: TextStyle(
                          fontSize: 12,
                        ),),
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(context, '/policies-regulator');
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded),
                        title: Text("Complains", style: TextStyle(
                          fontSize: 12,
                        ),),
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(context, '/complains_regulator');
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded),
                        title: Text("Fraud", style: TextStyle(
                          fontSize: 12,
                        ),),
                        onTap: () {
                          setState(() {
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
                        title: "Total Claim Registers",
                        value: "400",
                        onTap: () {},
                        topColor: Colors.orange,
                      ),
                      SizedBox(
                        width: _width / 64,
                      ),
                      InfoCard(
                        title: "Rejected Claims",
                        value: "17%",
                        topColor: Colors.lightGreen,
                        onTap: () {},
                      ),
                      SizedBox(
                        width: _width / 64,
                      ),
                      InfoCard(
                        title: "Total Losses",
                        value: "100",
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
                    title: ChartTitle(text: "Total losses over years"),
                    series: <ChartSeries>[
                      LineSeries<IssuancesInYear, double>(
                          dataSource: yearlyIssuances,
                          xValueMapper: (IssuancesInYear current, _) =>
                          current.year,
                          yValueMapper: (IssuancesInYear current, _) =>
                          current.issuances),
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
                    title: ChartTitle(text: "Claim Rejections over years"),
                    series: <ChartSeries>[
                      LineSeries<IssuancesInYear, double>(
                          dataSource: yearlyIssuances,
                          xValueMapper: (IssuancesInYear current, _) =>
                          current.year,
                          yValueMapper: (IssuancesInYear current, _) =>
                          current.issuances),
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
                  child: BarChart(data: insuranceCompanies, title: "Top Claim Registers", chartType: "claims",),
                ),
              ),

              Positioned(
                left: 230,
                top: 860,
                child: Container(
                  width: 1000,
                  height: 300,
                  child: BarChart(data: insuranceCompanies, title: "Top Total Losses", chartType: "claims",),
                ),
              ),
              Positioned(
                left: 230,
                top: 1160,
                child: Container(
                  width: 1000,
                  height: 300,
                  child: BarChart(data: insuranceCompanies, title: "Top Claim Rejections", chartType: "claims",),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}