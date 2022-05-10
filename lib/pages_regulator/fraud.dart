import 'package:flutter/material.dart';
import 'package:newest_insurance/data_regulator/fraud_history_data.dart';
import 'package:newest_insurance/information/fraud_history.dart';
import 'package:newest_insurance/widgets_regulator/info_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:newest_insurance/widgets_regulator/bar_chart.dart';
import 'package:newest_insurance/data_regulator/insurance_companies.dart';
import 'package:newest_insurance/constants_regulator/insurance_company_list.dart';


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
                left: 230,
                top: 180,
                child: Container(
                  width: 500,
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
                left: 730,
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
      rows: getRows(insuranceCompanyList),
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
