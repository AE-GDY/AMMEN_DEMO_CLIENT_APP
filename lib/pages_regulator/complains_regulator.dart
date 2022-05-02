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
