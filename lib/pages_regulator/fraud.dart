import 'package:flutter/material.dart';
import 'package:newest_insurance/data_regulator/fraud_history_data.dart';
import 'package:newest_insurance/information/fraud_history.dart';
import 'package:newest_insurance/widgets_regulator/info_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:newest_insurance/widgets_regulator/bar_chart.dart';
import 'package:newest_insurance/data_regulator/insurance_companies.dart';
import 'package:newest_insurance/constants_regulator/insurance_company_list.dart';

import '../constants.dart';


class Fraud extends StatefulWidget {
  const Fraud({Key? key}) : super(key: key);

  @override
  _FraudState createState() => _FraudState();
}

class _FraudState extends State<Fraud> {

  List<Map> selectedComps = [];
  bool companySelected = false;
  Map currentlySelected = {};
  Color mainColor = Color(0xff2470c7);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Fraud"),
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
                        title: "Total Insurance Company Frauds",
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
                        title: "Total Broker Company Frauds",
                        value: "20",
                        onTap: () {},
                        topColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 190,
                top: 180,
                child: Container(
                  width: 600,
                  height: 300,
                  child: BarChart(data: insuranceCompanies, title: "Insurance Company Fraud Cases", chartType: "fraud",),
                ),
              ),
              Positioned(
                left: 230,
                top: 500,
                child: Container(
                  width: 1000,
                  height: 800,
                  child: Expanded(
                    child: buildDataTable(),
                  ),
                ),
              ),
              Positioned(
                left: 760,
                top: 200,
                child: Container(
                  width: 500,
                  height: 300,
                  child: SfCartesianChart(
                    series: <ChartSeries>[
                      LineSeries<FraudHistory,double>(
                          dataSource: fraudHistory,
                          xValueMapper: (FraudHistory current, _)=>current.year,
                          yValueMapper: (FraudHistory current, _)=>current.frauds),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDataTable(){
    final columns = ['Company', 'Total Claims', 'Policies Issued', 'Fraud Cases', 'Complains'];

    return DataTable(
      headingRowColor: MaterialStateColor.resolveWith((states) {return Colors.blueGrey.shade50;},),
      showBottomBorder: true,
      horizontalMargin: 15,
      dividerThickness: 1,
      headingRowHeight: 50,
      dataRowHeight: 100,
      columns: getColumns(columns),
      rows: getRows(insuranceCompanyListData),
    );
  }

  List<DataRow> getRows(List<Map> companyList)=>companyList
      .map((Map current) => DataRow(
      selected: selectedComps.contains(current),
      onSelectChanged: (isSelected) =>setState(() {
        Map previous = currentlySelected;
        currentlySelected = current;
        selectedComps.add(currentlySelected);
        selectedComps.remove(previous);
        // amountSelected--;

        //  insuranceCompanyName = current['name'];
        // insuranceCompanyImage = current['image'];
        // insuranceOptions = current['options'];
        // insuranceCompanyPrice = current['price'];
        // Navigator.pushNamed(context, '/companydetails');

      }),
      cells: [
        DataCell(
          Container(
            width: 120,
            child: Text("${current['name']}", style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),
        DataCell(
          Container(
            width: 60,
            child: Text("${current['total claims']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),

        DataCell(
          Container(
            width: 60,
            child: Text("${current['policies issued']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),
        DataCell(
          Container(
            width: 110,
            child: Text("${current['fraud cases']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),
        DataCell(
          Container(
            width: 110,
            child: Text("${current['complains']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),

      ]
  )).toList();

  List<DataColumn> getColumns(List<String> columns)=>columns
      .map((String column) => DataColumn(
    label: Text(column, style: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
    ),),
  )).toList();
}
