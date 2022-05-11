import 'package:flutter/material.dart';
import 'package:newest_insurance/data_regulator/age_claims_data.dart';
import 'package:newest_insurance/data_regulator/broker_companies.dart';
import 'package:newest_insurance/widgets_regulator/bar_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:newest_insurance/widgets_regulator/info_card.dart';
import 'package:newest_insurance/data_regulator/insurance_companies.dart';

import '../constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Dashboard"),
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height + 1000,
          child: Stack(
            children: [
              //Container(color: Colors.red,),
              Positioned(
                left: 0,
                //right: 0,
                child: Container(
                  width: 210,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded),
                        title: Text("Dashboard", style: TextStyle(
                          fontSize: 12,
                        ),),
                        onTap: (){
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
                        onTap: (){
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
                        onTap: (){
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
                        onTap: (){
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
                        onTap: (){
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
                        onTap: (){
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
                        onTap: (){
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
                        title: "Rejected Claims",
                        value: "20 %",
                        onTap: () {},
                        topColor: Colors.orange,
                      ),
                      SizedBox(
                        width: _width / 64,
                      ),
                      InfoCard(
                        title: "Canceled Policies",
                        value: "17%",
                        topColor: Colors.lightGreen,
                        onTap: () {},
                      ),
                      SizedBox(
                        width: _width / 64,
                      ),
                      InfoCard(
                        title: "Policies issued this year",
                        value: "100",
                        topColor: Colors.redAccent,
                        onTap: () {},
                      ),
                      SizedBox(
                        width: _width / 64,
                      ),
                      InfoCard(
                        title: "Complains",
                        value: "32%",
                        onTap: () {},
                        topColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 180,
                child: Container(
                  width: 500,
                  height: 300,
                  child: BarChart(data: insuranceCompanies, title: "Insurance Company Claims", chartType: 'claims',),
                ),
              ),
              Positioned(
                left: 700,
                top: 180,
                child: Container(
                  width: 500,
                  height: 300,
                  child: BarChart(data: ageClaims, title: "Claims by Age", chartType: 'claims',),
                ),
              ),
              Positioned(
                left: 230,
                top: 480,
                child: Container(
                  width: 500,
                  height: 300,
                  child: BarChart(data: insuranceCompanies, title: "Top Insurance Companies", chartType: "ranking",),
                ),
              ),
              Positioned(
                left: 700,
                top: 480,
                child: Container(
                  width: 500,
                  height: 300,
                  child: BarChart(data: brokerCompanies, title: "Top Broker Companies", chartType: 'ranking',),
                ),
              ),

            ],
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
