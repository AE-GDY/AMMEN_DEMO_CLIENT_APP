import 'package:flutter/material.dart';
import 'package:newest_insurance/data/broker_companies.dart';
import 'package:newest_insurance/data/insurance_companies_data.dart';
import 'package:newest_insurance/data_regulator/broker_companies.dart';
import 'package:newest_insurance/data_regulator/yearly_complain_list.dart';
import 'package:newest_insurance/information/complains_in_year.dart';
import 'package:newest_insurance/widgets/bar_chart.dart';
import 'package:newest_insurance/widgets_regulator/info_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../constants.dart';

class ComplainsRegulator extends StatefulWidget {
  const ComplainsRegulator({Key? key}) : super(key: key);

  @override
  _ComplainsRegulatorState createState() => _ComplainsRegulatorState();
}

class _ComplainsRegulatorState extends State<ComplainsRegulator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Complains"),
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
                        title: "Complains This Year",
                        value: "450",
                        onTap: () {},
                        topColor: Colors.red,
                      ),
                      SizedBox(width: 10,),
                      InfoCard(
                        title: "Insurance Companies Complains",
                        value: "50",
                        onTap: () {
                          setState(() {
                            print("click");
                            Navigator.pushNamed(context, '/insurance_table');
                          });
                        },
                        topColor: Colors.orange,
                      ),
                      SizedBox(width: 10,),
                      InfoCard(
                        title: "Broker Company Complains",
                        value: "400",
                        onTap: () {},
                        topColor: Colors.blue,
                      ),
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
                    title: ChartTitle(text: "Insurance Company Complains over years"),
                    series: <ChartSeries>[
                      LineSeries<ComplainsInYear,double>(
                          dataSource: yearlyComplains,
                          xValueMapper: (ComplainsInYear current, _)=>current.year,
                          yValueMapper: (ComplainsInYear current, _)=>current.complains),
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
                    title: ChartTitle(text: "Broker Company Complains over years"),
                    series: <ChartSeries>[
                      LineSeries<ComplainsInYear,double>(
                          dataSource: yearlyComplains,
                          xValueMapper: (ComplainsInYear current, _)=>current.year,
                          yValueMapper: (ComplainsInYear current, _)=>current.complains),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 500,
                child: Container(
                  width: 1000,
                  height: 300,
                  child: BarChart(data: insuranceCompanies, title: "Insurance Company Complains", chartType: "claims",),
                ),
              ),
              Positioned(
                left: 230,
                top: 800,
                child: Container(
                  width: 1000,
                  height: 300,
                  child: BarChart(data: brokerCompaniesRegulator, title: "Broker Company Complains", chartType: "claims",),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
