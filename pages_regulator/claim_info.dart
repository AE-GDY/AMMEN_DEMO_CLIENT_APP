import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class ClaimInfo extends StatefulWidget {
  const ClaimInfo({Key? key}) : super(key: key);

  @override
  _ClaimInfoState createState() => _ClaimInfoState();
}

class _ClaimInfoState extends State<ClaimInfo> {
  List<Map> selectedComps = [];
  bool companySelected = false;
  Map currentlySelected = {};

  @override
  Widget build(BuildContext context) {


    print("CURRENT INSURANCE COMPANY!!!!!: $currentInsuranceCompany");

    Future<Map<String, dynamic>?> policyRequestData() async {
      return (await FirebaseFirestore.instance.collection('users-policy-requests').
      doc(currentInsuranceCompany).get()).data();
    }

    Future<Map<String, dynamic>?> claimRequestData() async {
      return (await FirebaseFirestore.instance.collection('users-claim-requests').
      doc("claims").get()).data();
    }

    Future<Map<String, dynamic>?> brokerPolicyRequestData() async {
      return (await FirebaseFirestore.instance.collection('users-policy-requests-broker').
      doc(currentBrokerCompany).get()).data();
    }

    Future<Map<String, dynamic>?> brokerClaimRequestData() async {
      return (await FirebaseFirestore.instance.collection('users-claim-requests-broker').
      doc("claims").get()).data();
    }



    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(onBrokerDetails?"${currentBrokerCompany} Claims":"${currentInsuranceCompany} Claims"),
        centerTitle: true,
        actions: [
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


              //SECOND
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
                top: 250,
                left: 210,
                child:  FutureBuilder(
                  future: onBrokerDetails?brokerClaimRequestData():claimRequestData(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('there is an error'),
                        );
                      }
                      else if(snapshot.hasData){
                        final List<int> claimNumbers = [];
                        final List<String> claimAccidentInfo = [];
                        final List<String> claimAccidentLocations = [];
                        final List<String> claimAddresses = [];
                        final List<String> claimDateOfBirths = [];
                        final List<String> claimEmails = [];
                        final List<String> claimIds = [];
                        final List<String> claimMobiles = [];
                        final List<String> claimRequesterNames = [];
                        final List<String> claimVehicleLicenses = [];
                        final List<int> claimVehicleIndexes = [];
                        final List<String> claimVehicleMakes = [];
                        final List<String> claimVehicleModels = [];
                        final List<String> claimVehicleProductionYears = [];
                        final List<String> claimVehicleValues = [];
                        final List<String> claimIntendedInsuranceCompanies = [];
                        final List<bool> claimsApprovedByIC = [];
                        final List<bool> claimsApprovedByUser = [];
                        final List<String> claimCenters = [];
                        final List<List<dynamic>> invoicesItems = [];
                        final List<List<dynamic>> invoicesFees = [];
                        final List<int> claimUserNumbers = [];
                        final List<bool> declinedAmount = [];

                        print(currentInsuranceCompany);

                        if(onBrokerDetails){
                          currentCompany = currentBrokerCompany;
                        }
                        else{
                          currentCompany = currentInsuranceCompany;
                        }
                        int idx = 0;
                        while(idx <= snapshot.data[currentCompany]['total-claim-amount']){
                         // declinedAmount.insert(idx, snapshot.data[currentCompany]['$idx']['declined-amount']!);
                          claimUserNumbers.insert(idx, snapshot.data[currentCompany]['$idx']['claim-number-user']!);
                          invoicesItems.insert(idx, snapshot.data[currentCompany]['$idx']['invoice-items']!);
                          invoicesFees.insert(idx, snapshot.data[currentCompany]['$idx']['invoice-fees']!);
                          claimCenters.insert(idx, snapshot.data[currentCompany]['$idx']['center']!);
                          claimNumbers.insert(idx, snapshot.data[currentCompany]['$idx']['claim-number']!);
                          claimAccidentInfo.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-accident-info']!.toString());
                          claimAccidentLocations.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-accident-location']!.toString());
                          claimAddresses.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-address']!.toString());
                          claimDateOfBirths.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-date-of-birth']!.toString());
                          claimEmails.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-email']!.toString());
                          claimIds.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-id']!.toString());
                          claimMobiles.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-mobile']!.toString());
                          claimRequesterNames.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-name']!.toString());
                          claimVehicleLicenses.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-vehicle-car-license-id']!.toString());
                          claimVehicleIndexes.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-vehicle-index']!);
                          claimVehicleMakes.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-vehicle-make']!.toString());
                          claimVehicleModels.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-vehicle-model']!.toString());
                          claimVehicleProductionYears.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-vehicle-production-year']!.toString());
                          claimVehicleValues.insert(idx, snapshot.data[currentCompany]['$idx']['claim-requester-vehicle-value']!.toString());
                          claimIntendedInsuranceCompanies.insert(idx, snapshot.data[currentCompany]['$idx']['intended-insurance-company']!.toString());
                          claimsApprovedByIC.insert(idx, snapshot.data[currentCompany]['$idx']['status-ic-approved']!);
                          claimsApprovedByUser.insert(idx, snapshot.data[currentCompany]['$idx']['status-requester-approved']!);
                          idx++;
                        }

                        return Container(
                          width: 1100,
                          height: 800,
                          child: buildDataTable(
                            claimCenters,
                            onBrokerDetails?brokerClaimRequestData():claimRequestData(),
                            claimNumbers,
                            claimAccidentInfo,
                            claimAccidentLocations,
                            claimAddresses,
                            claimDateOfBirths,
                            claimEmails,
                            claimIds,
                            claimMobiles,
                            claimRequesterNames,
                            claimVehicleLicenses,
                            claimVehicleIndexes,
                            claimVehicleMakes,
                            claimVehicleModels,
                            claimVehicleProductionYears,
                            claimVehicleValues,
                            claimIntendedInsuranceCompanies,
                            claimsApprovedByIC,
                            claimsApprovedByUser,
                            invoicesItems,
                            invoicesFees,
                            claimUserNumbers,
                            declinedAmount,
                          ),
                        );
                      }
                    }
                    return const Text("Please wait");
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget buildDataTable(
      List<String> claimCenters,
      Future<Map<String, dynamic>?> func,
      List<int> claimNumbers,
      List<String> claimAccidentInfo,
      List<String> claimAccidentLocations,
      List<String> claimAddresses,
      List<String> claimDateOfBirths,
      List<String> claimEmails,
      List<String> claimIds,
      List<String> claimMobiles,
      List<String> claimRequesterNames,
      List<String> claimVehicleLicenses ,
      List<int> claimVehicleIndexes ,
      List<String> claimVehicleMakes,
      List<String> claimVehicleModels ,
      List<String> claimVehicleProductionYears,
      List<String> claimVehicleValues,
      List<String> claimIntendedInsuranceCompanies,
      List<bool> claimsApprovedByIC,
      List<bool> claimsApprovedByUser,
      List<List<dynamic>> invoicesItems,
      List<List<dynamic>> invoicesFees,
      List<int> claimUserNumbers,
      List<bool> declinedAmount,
      ){

    final columns = ['Client Name', 'Vehicle Make', 'Vehicle Model', 'Driving License'];

    List<Map> myMap = [];

    int currentClaimIndex = 0;
    while(currentClaimIndex < claimRequesterNames.length){
      if(claimsApprovedByUser[currentClaimIndex] == false){
        Map newMap = Map();
        newMap['claim-requester-vehicle-make'] = claimVehicleMakes[currentClaimIndex];
        newMap['claim-requester-vehicle-model'] = claimVehicleModels[currentClaimIndex];
        newMap['claim-requester-name'] = claimRequesterNames[currentClaimIndex];
        newMap['claim-requester-vehicle-license-id'] = claimVehicleLicenses[currentClaimIndex];
        newMap['claim-number'] = claimNumbers[currentClaimIndex];
        newMap['status-requester-approved'] = claimsApprovedByUser[currentClaimIndex];
        myMap.add(newMap);
      }
      currentClaimIndex++;
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
        claimCenters,
        claimNumbers,
        claimAccidentInfo,
        claimAccidentLocations,
        claimAddresses,
        claimDateOfBirths,
        claimEmails,
        claimIds,
        claimMobiles,
        claimRequesterNames,
        claimVehicleLicenses,
        claimVehicleIndexes,
        claimVehicleMakes,
        claimVehicleModels,
        claimVehicleProductionYears,
        claimVehicleValues,
        claimIntendedInsuranceCompanies,
        claimsApprovedByIC,
        claimsApprovedByUser,
        invoicesItems,
        invoicesFees,
        claimUserNumbers,
        declinedAmount,

      ),
    );
  }

  List<DataRow> getRows(
      List<Map> companyList,
      Future<Map<String, dynamic>?> func,
      claimCenters,
      claimNumbers,
      claimAccidentInfo,
      claimAccidentLocations,
      claimAddresses,
      claimDateOfBirths,
      claimEmails,
      claimIds,
      claimMobiles,
      claimRequesterNames,
      claimVehicleLicenses,
      claimVehicleIndexes,
      claimVehicleMakes,
      claimVehicleModels,
      claimVehicleProductionYears,
      claimVehicleValues,
      claimIntendedInsuranceCompanies,
      claimsApprovedByIC,
      claimsApprovedByUser,
      invoicesItems,
      invoicesFees,
      claimUserNumbers,
      declinedAmount,
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
            child: Text("${current['claim-requester-name']}", style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),
        DataCell(
          Container(
            width: 60,
            child: Text("${current['claim-requester-vehicle-make']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),

        DataCell(
          Container(
            width: 60,
            child: Text("${current['claim-requester-vehicle-model']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),

        ),
        DataCell(
          Container(
            width: 60,
            child: Text("${current['claim-requester-vehicle-license-id']}",style: TextStyle(
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