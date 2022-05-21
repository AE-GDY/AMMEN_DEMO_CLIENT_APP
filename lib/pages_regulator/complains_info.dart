import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newest_insurance/services/database.dart';

import '../constants.dart';


class ComplainsInfo extends StatefulWidget {
  const ComplainsInfo({Key? key}) : super(key: key);

  @override
  _ComplainsInfoState createState() => _ComplainsInfoState();
}

class _ComplainsInfoState extends State<ComplainsInfo> {

  List<Map> selectedComps = [];
  bool companySelected = false;
  Map currentlySelected = {};

  Future<Map<String, dynamic>?> userComplains() async {
    return (await FirebaseFirestore.instance.collection('user-complains').
    doc("complains").get()).data();
  }

  Future<Map<String, dynamic>?> policyRequestData() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc(currentInsuranceCompany).get()).data();
  }

  Future<Map<String, dynamic>?> brokerPolicyRequestData() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests-broker').
    doc(currentBrokerCompany).get()).data();
  }

  Future<Map<String, dynamic>?> claimRequestData() async {
    return (await FirebaseFirestore.instance.collection('users-claim-requests').
    doc("claims").get()).data();
  }

  Future<Map<String, dynamic>?> brokerClaimRequestData() async {
    return (await FirebaseFirestore.instance.collection('users-claim-requests-broker').
    doc("claims").get()).data();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(onBrokerDetails?"${currentBrokerCompany} Complains":"${currentInsuranceCompany} Complains"),
        centerTitle: true,
        actions:[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.notifications),
          ),
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
              // FIRST
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
                        leading: Icon(Icons.directions_car),
                        title: Text("Policies", style: TextStyle(
                          fontSize: 12,
                        ),),
                        onTap: (){
                          setState(() {
                            if(onBrokerDetails){
                              Navigator.pushNamed(context, '/broker-info');
                            }
                            else{
                              Navigator.pushNamed(context, '/company-info');
                            }
                          });
                        },
                      ),
                      claimsTile(onBrokerDetails),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded),
                        title: Text("Complains", style: TextStyle(
                          fontSize: 12,
                        ),),
                        onTap: (){
                          setState(() {
                            Navigator.pushNamed(context, '/complains-info');
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 220,
                child: Container(
                  height: 200,
                  width: 1000,
                  child: Row(
                    children: [
                      FutureBuilder(
                        future: onBrokerDetails?brokerPolicyRequestData():policyRequestData(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){

                              int overallPolicies = snapshot.data['total-amount-approved']+
                                  snapshot.data['total-amount-cancelled']+
                                  snapshot.data['total-amount-renewal'];

                              return Expanded(
                                child: InkWell(
                                  onTap: (){},
                                  child: Container(
                                    height: 170,
                                    //width: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 6),
                                            color: Colors.grey.withOpacity(.1),
                                            blurRadius: 12
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Container(
                                              color: Colors.blue,
                                              height: 5,
                                            ))
                                          ],
                                        ),
                                        // Container(),
                                        RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: "Overall Policies\n",
                                                  style: TextStyle(
                                                      fontSize: 16, color: Colors.black)),
                                              TextSpan(
                                                  text: "$overallPolicies",
                                                  style:
                                                  TextStyle(fontSize: 40, color: Colors.black)),
                                            ])),
                                        //  Container(),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                          return const Text("");
                        },
                      ),
                      const SizedBox(width: 10,),

                      FutureBuilder(
                        future: onBrokerDetails?brokerPolicyRequestData():policyRequestData(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){
                              return Expanded(
                                child: InkWell(
                                  onTap: (){},
                                  child: Container(
                                    height: 170,
                                    //width: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 6),
                                            color: Colors.grey.withOpacity(.1),
                                            blurRadius: 12
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Container(
                                              color: Colors.orange,
                                              height: 5,
                                            ))
                                          ],
                                        ),
                                        // Container(),
                                        RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: "New Requests\n",
                                                  style: TextStyle(
                                                      fontSize: 16, color: Colors.black)),
                                              TextSpan(
                                                  text: "${snapshot.data['total-new-requests']}",
                                                  style:
                                                  TextStyle(fontSize: 40, color: Colors.black)),
                                            ])),
                                        //  Container(),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                          return const Text("");
                        },

                      ),


                      const SizedBox(width: 10,),

                      FutureBuilder(
                        future: onBrokerDetails?brokerPolicyRequestData():policyRequestData(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){
                              return Expanded(
                                child: InkWell(
                                  onTap: (){},
                                  child: Container(
                                    height: 170,
                                    //width: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 6),
                                            color: Colors.grey.withOpacity(.1),
                                            blurRadius: 12
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Container(
                                              color: Colors.red,
                                              height: 5,
                                            ))
                                          ],
                                        ),
                                        // Container(),
                                        RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: "Pending Policies\n",
                                                  style: TextStyle(
                                                      fontSize: 16, color: Colors.black)),
                                              TextSpan(
                                                  text: "${snapshot.data['total-pending-policies']}",
                                                  style:
                                                  TextStyle(fontSize: 40, color: Colors.black)),
                                            ])),
                                        //  Container(),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                          return const Text("");
                        },

                      ),
                      const SizedBox(width: 10,),
                      FutureBuilder(
                        future: onBrokerDetails?brokerClaimRequestData():claimRequestData(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){
                              return Expanded(
                                child: InkWell(
                                  onTap: (){},
                                  child: Container(
                                    height: 170,
                                    //width: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 6),
                                            color: Colors.grey.withOpacity(.1),
                                            blurRadius: 12
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Container(
                                              color: Colors.green,
                                              height: 5,
                                            ))
                                          ],
                                        ),
                                        // Container(),
                                        RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: "Requested Claims\n",
                                                  style: TextStyle(
                                                      fontSize: 16, color: Colors.black)),
                                              TextSpan(
                                                  text: "${snapshot.data[onBrokerDetails?currentBrokerCompany:currentInsuranceCompany]['total-claim-amount']+1}",
                                                  style:
                                                  TextStyle(fontSize: 40, color: Colors.black)),
                                            ])),
                                        //  Container(),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                          return const Text("");
                        },

                      ),
                      const SizedBox(width: 10,),


                    ],
                  ),
                ),
              ),

              Positioned(
                top: 300,
                left: 210,
                child: Container(
                  width: 1000,
                  height: 1000,
                  child: FutureBuilder(
                    future: userComplains(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('there is an error'),
                          );
                        }
                        else if(snapshot.hasData){
                          final List<String> userNames = [];
                          final List<int> complainIndexes = [];

                          final List<String> companies = [];
                          final List<String> userIDs = [];
                          final List<String> userEmails = [];
                          final List<String> complains = [];
                          final List<String> userLicenses = [];
                          final List<String> insuranceCompaniesAssigned = [];


                          int idx = 0;
                          while(idx <= snapshot.data[onBrokerDetails?currentBrokerCompany:currentInsuranceCompany]['total-complains']){
                            userNames.add(snapshot.data[onBrokerDetails?currentBrokerCompany:currentInsuranceCompany]['$idx']['user-name']!.toString());
                            userEmails.add(snapshot.data[onBrokerDetails?currentBrokerCompany:currentInsuranceCompany]['$idx']['user-email']!.toString());
                            userIDs.add(snapshot.data[onBrokerDetails?currentBrokerCompany:currentInsuranceCompany]['$idx']['user-id']!.toString());
                            userLicenses.add(snapshot.data[onBrokerDetails?currentBrokerCompany:currentInsuranceCompany]['$idx']['user-license']!.toString());
                            complains.add(snapshot.data[onBrokerDetails?currentBrokerCompany:currentInsuranceCompany]['$idx']['complain']!.toString());
                            complainIndexes.add(idx);
                            idx++;
                          }

                          return Container(
                            width: 1100,
                            height: 800,
                            child: buildDataTable(
                              userComplains(),
                              userNames,
                              userLicenses,
                              userIDs,
                              userEmails,
                              complains,
                              complainIndexes,
                            ),
                          );

                        }
                      }
                      return const Text("Please wait");
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildDataTable(
      Future<Map<String, dynamic>?> func,
      List<String> userNames,
      List<String> userLicenses,
      List<String> userIDs,
      List<String> userEmails,
      List<String> complains,
      List<int> complainIndexes,

      ){

    final columns = ['Name', 'ID', 'Driving License', 'Email'];

    List<Map> myMap = [];
    DataBaseService dataBaseService = DataBaseService();

    int currentComplainIndex = 0;
    while(currentComplainIndex < userNames.length){
      Map newMap = Map();
      newMap['user-name'] = userNames[currentComplainIndex];
      newMap['user-id'] = userIDs[currentComplainIndex];
      newMap['user-email'] = userEmails[currentComplainIndex];
      newMap['user-license'] = userLicenses[currentComplainIndex];
      newMap['complain'] = complains[currentComplainIndex];
      newMap['complain-index'] = complainIndexes[currentComplainIndex];


      myMap.add(newMap);

      currentComplainIndex++;
    }

    return DataTable(
      headingRowColor: MaterialStateColor.resolveWith((states) {return Colors.blueGrey.shade50;},),
      showBottomBorder: true,
      horizontalMargin: 15,
      dividerThickness: 1,
      headingRowHeight: 40,
      dataRowHeight: 70,
      columns: getColumns(columns),
      rows: getRows(
        myMap,
        func,
        userNames,
        userLicenses,
        userIDs,
        userEmails,
        complains,
        complainIndexes,

      ),
    );
  }

  List<DataRow> getRows(
      List<Map> companyList,
      Future<Map<String, dynamic>?> func,
      userNames,
      userLicenses,
      userIDs,
      userEmails,
      complains,
      complainIndexes,

      )=>companyList
      .map((Map current) => DataRow(
      selected: selectedComps.contains(current),
      onSelectChanged: (isSelected) =>setState(() {
        Map previous = currentlySelected;
        currentlySelected = current;
        selectedComps.add(currentlySelected);
        selectedComps.remove(previous);
        Navigator.pushNamed(context, '/insurance_page');

      }),
      cells: [
        DataCell(
          Container(
            width: 150,
            child: Text("${current['user-name']}", style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),

        DataCell(
          Container(
            width: 90,
            child: Text("${current['user-id']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),

        DataCell(
          Container(
            width: 90,
            child: Text("${current['user-email']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),

        ),
        DataCell(
          Container(
            width: 60,
            child: Text("${current['user-license']}",style: TextStyle(
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

  Widget claimsTile(bool asBroker){
    if(asBroker){
      return Container();
    }
    else{
      return ListTile(
        leading: Icon(Icons.account_circle_rounded),
        title: Text("Claims", style: TextStyle(
          fontSize: 12,
        ),),
        onTap: (){
          setState(() {
            Navigator.pushNamed(context, '/claims-page');
          });
        },
      );
    }
  }

}