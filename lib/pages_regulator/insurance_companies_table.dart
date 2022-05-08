import 'package:flutter/material.dart';
import 'package:newest_insurance/constants_regulator/insurance_company_list.dart';
//import 'package:newest_insurance/constants.dart/';
//import '../constants.dart';


class InsuranceCompaniesDetails extends StatefulWidget {
  const InsuranceCompaniesDetails({Key? key}) : super(key: key);

  @override
  _InsuranceCompaniesDetailsState createState() => _InsuranceCompaniesDetailsState();
}

class _InsuranceCompaniesDetailsState extends State<InsuranceCompaniesDetails> {
  List<Map> selectedComps = [];
  bool companySelected = false;
  Map currentlySelected = {};
  Color mainColor = Color(0xff2470c7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Insurance Company Details"),
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
                            Navigator.pushNamed(context, '/insurance_details');
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
                            Navigator.pushNamed(context, '/insurance_details');
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
                            Navigator.pushNamed(context, '/insurance_details');
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
                top: 100,
                child: Container(
                  width: 1000,
                  height: 800,
                  child: Expanded(
                    child: buildDataTable(),
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
      headingRowHeight: 40,
      dataRowHeight: 50,
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
        Navigator.pushNamed(context, '/insurance_page');

      }),
      cells: [
        DataCell(
          Container(
            width: 150,
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
