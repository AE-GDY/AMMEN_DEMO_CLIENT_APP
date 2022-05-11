import 'package:flutter/material.dart';
import 'package:newest_insurance/data_regulator/yearly_complain_list.dart';
import 'package:newest_insurance/data_regulator/yearly_issuance_list.dart';
import 'package:newest_insurance/information/complains_in_year.dart';
import 'package:newest_insurance/information/issuances_in_year.dart';
import 'package:newest_insurance/widgets_regulator/info_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:newest_insurance/widgets_regulator/bar_chart.dart';
import 'package:newest_insurance/data_regulator/insurance_companies.dart';

import '../constants.dart';


class InsuranceDetails extends StatefulWidget {
  const InsuranceDetails({Key? key}) : super(key: key);

  @override
  _InsuranceDetailsState createState() => _InsuranceDetailsState();
}

class _InsuranceDetailsState extends State<InsuranceDetails> {

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

  Widget buildInsCompanyDetailsButton(String company){
    if(company != null){
      return Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        width: 200,
        height: 50,
        child: TextButton(
          onPressed: (){},
          child: Text("$company details", style: TextStyle(
          color: Colors.white,
          ),),
        ),
      );
    }
    else{
      return Container();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Insurance Companies"),
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
                top: 200,
                left: 350,
                child: Row(
                  children: [
                    Text("Insurance Company: ", style: TextStyle(
                      fontSize: 18,
                    ),),
                    SizedBox(width: 20,),
                    Container(
                      height: 1.5 * (MediaQuery.of(context).size.height / 20),
                      width: 5 * (MediaQuery.of(context).size.width / 18),
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black),
                      ),
                      child: DropdownButton<String>(
                        value: insComp,
                        items: insuranceCompanyList.map(buildMenuItem).toList(),
                        onChanged: (value){
                          setState(() {
                            insComp = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 40,),
                    Container(
                      decoration: BoxDecoration(
                        color: (insComp == null)?Colors.white:Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 200,
                      height: 50,
                      child: TextButton(
                        onPressed: (){

                          setState(() {
                            currentInsuranceCompany = insComp!;
                            onBrokerDetails = false;
                          });

                          Navigator.pushNamed(context, '/company-info');
                        },
                        child: Text("${insComp ?? ""} details", style: TextStyle(
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  ],
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
                        title: "Total Insurance Companies",
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
                        title: "Total Policy Issuances this year",
                        value: "400",
                        onTap: () {},
                        topColor: Colors.blue,
                      ),
                      SizedBox(width: 10,),
                      InfoCard(
                        title: "Total Claim registers this year",
                        value: "450",
                        onTap: () {},
                        topColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 600,
                child: Container(
                  width: 500,
                  height: 300,
                  child: BarChart(data: insuranceCompanies, title: "Top Complains", chartType: "complains",),
                ),
              ),
              Positioned(
                left: 680,
                top: 600,
                child: Container(
                  width: 500,
                  height: 300,
                  child: Container(
                    height: 400,
                    padding: EdgeInsets.all(20),
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 30,
                            top: 30,
                            child: Container(
                              width: 250,
                              height: 80,
                              child: Text("Most Complains", style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                                fontSize: 15,
                              ),),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            top: 50,
                            child: Container(
                              width: 250,
                              height: 80,
                              child: Text("Cairo Insurance", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),),
                            ),
                          ),
                          Positioned(
                            left: 300,
                            top: 30,
                            child: Container(
                              width: 250,
                              height: 80,
                              child: Text("Least Complains", style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                                fontSize: 15,
                              ),),
                            ),
                          ),
                          Positioned(
                            left: 300,
                            top: 50,
                            child: Container(
                              width: 250,
                              height: 80,
                              child: Text("Allianz", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),),
                            ),
                          ),

                          Positioned(
                            left: 180,
                            top: 180,
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {  },
                                child: Text("More details", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 880,
                child: Container(
                  width: 500,
                  height: 300,
                  child: BarChart(data: insuranceCompanies, title: "Top Policy Issuances", chartType: "policy ranking",),
                ),
              ),
              Positioned(
                left: 270,
                top: 300,
                child: Container(
                  width: 400,
                  height: 300,
                  child: SfCartesianChart(
                    title: ChartTitle(text: "Complains over years"),
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
                top: 300,
                child: Container(
                  width: 400,
                  height: 300,
                  child: SfCartesianChart(
                    title: ChartTitle(text: "Issuances over years"),
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
                left: 680,
                top: 880,
                child: Container(
                  width: 500,
                  height: 300,
                  child: Container(
                    height: 400,
                    padding: EdgeInsets.all(20),
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 30,
                            top: 30,
                            child: Container(
                              width: 250,
                              height: 80,
                              child: Text("Most Issuances", style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                                fontSize: 15,
                              ),),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            top: 50,
                            child: Container(
                              width: 250,
                              height: 80,
                              child: Text("Cairo Insurance", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),),
                            ),
                          ),
                          Positioned(
                            left: 300,
                            top: 30,
                            child: Container(
                              width: 250,
                              height: 80,
                              child: Text("Least Issuances", style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                                fontSize: 15,
                              ),),
                            ),
                          ),
                          Positioned(
                            left: 300,
                            top: 50,
                            child: Container(
                              width: 250,
                              height: 80,
                              child: Text("Allianz", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),),
                            ),
                          ),

                          Positioned(
                            left: 180,
                            top: 180,
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {  },
                                child: Text("More details", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 1160,
                child: Container(
                  width: 500,
                  height: 300,
                  child: BarChart(data: insuranceCompanies, title: "Top Claim Registers", chartType: "claims",),
                ),
              ),
              Positioned(
                left: 680,
                top: 1160,
                child: Container(
                  width: 500,
                  height: 300,
                  child: Container(
                    height: 400,
                    padding: EdgeInsets.all(20),
                    child: Card(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 30,
                            top: 30,
                            child: Container(
                              width: 250,
                              height: 80,
                              child: Text("Most Claims", style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                                fontSize: 15,
                              ),),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            top: 50,
                            child: Container(
                              width: 250,
                              height: 80,
                              child: Text("Cairo Insurance", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),),
                            ),
                          ),
                          Positioned(
                            left: 300,
                            top: 30,
                            child: Container(
                              width: 250,
                              height: 80,
                              child: Text("Least Claims", style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                                fontSize: 15,
                              ),),
                            ),
                          ),
                          Positioned(
                            left: 300,
                            top: 50,
                            child: Container(
                              width: 250,
                              height: 80,
                              child: Text("Allianz", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),),
                            ),
                          ),

                          Positioned(
                            left: 180,
                            top: 180,
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {  },
                                child: Text("More details", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}