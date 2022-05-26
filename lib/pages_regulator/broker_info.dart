import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newest_insurance/models/user_vehicle.dart';
import 'package:newest_insurance/services/database.dart';

import '../constants.dart';


class BrokerInfo extends StatefulWidget {
  const BrokerInfo({Key? key}) : super(key: key);

  @override
  _BrokerInfoState createState() => _BrokerInfoState();
}

class _BrokerInfoState extends State<BrokerInfo> {
  List<Map> selectedComps = [];
  bool companySelected = false;
  Map currentlySelected = {};


  @override
  Widget build(BuildContext context) {

    print("broker comp: $currentBrokerCompany");
    print("signinasbroker: $signInAsBroker");


    Future<Map<String, dynamic>?> brokerPolicyRequestData() async {
      return (await FirebaseFirestore.instance.collection('users-policy-requests-broker').
      doc(currentBrokerCompany).get()).data();
    }

    Future<Map<String, dynamic>?> requestsDocBrokerPolicyRequestData() async {
      return (await FirebaseFirestore.instance.collection('users-policy-requests').
      doc("requests").get()).data();
    }


    Future<Map<String, dynamic>?> brokerClaimRequestData() async {
      return (await FirebaseFirestore.instance.collection('users-claim-requests-broker').
      doc("claims").get()).data();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("$currentBrokerCompany Policies"),
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
                            Navigator.pushNamed(context, '/broker-info');
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
                  child: Expanded(
                    child: Row(
                      children: [
                        FutureBuilder(
                          future: brokerPolicyRequestData(),
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
                          future: brokerPolicyRequestData(),
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
                          future: brokerPolicyRequestData(),
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
                          future: brokerClaimRequestData(),
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

                                                    text: "${snapshot.data[currentBrokerCompany]['total-claim-amount']+1}",
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
              ),
              Positioned(
                top: 250,
                left: 210,
                child:  FutureBuilder(
                  future: requestsDocBrokerPolicyRequestData(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('there is an error'),
                        );
                      }
                      else if(snapshot.hasData){
                        final List<int> policyPositions = [];
                        final List<String> newNames = [];
                        final List<String> policyIDs = [];
                        final List<String> policyMobiles = [];
                        final List<String> policyAddresses = [];
                        final List<String> policyEmails = [];
                        final List<String> policyVehicleMakes = [];
                        final List<String> policyVehicleModels = [];
                        final List<String> policyProductionYears = [];
                        final List<String> policyVehicleValues = [];
                        final List<String> policyVehicleLicenseId = [];
                        final List<String> policyVehicleDrivingLicenses = [];
                        final List<int> policyVehicleIndexes = [];
                        final List<bool> policyApprovedByIC = [];
                        final List<String> policyPlateNumbers = [];
                        final List<String> policyChassisNumbers = [];
                        final List<String> policyMotorNumbers = [];
                        final List<String> insuranceCompaniesAssigned = [];
                        final List<String> policyBrokerNames = [];
                        final List<List<UserVehicleWidget>> vehiclesRequested = [];
                        final List<int> vehicleAmounts = [];

                        int idx = 0;

                        while(idx <= snapshot.data['total-policy-amount']){
                          print("broker name in while loop: ${snapshot.data['$idx']['broker-name']}");
                          policyBrokerNames.insert(idx, snapshot.data['$idx']['broker-name']!.toString());
                          newNames.insert(idx, snapshot.data['$idx']['policy-holder-name']!.toString());
                          policyApprovedByIC.insert(idx, snapshot.data['$idx']['status-ic-approved']!);
                          policyPositions.insert(idx, snapshot.data['$idx']['policy-number']!);
                          policyIDs.insert(idx, snapshot.data['$idx']['policy-holder-id']!.toString());
                          policyMobiles.insert(idx, snapshot.data['$idx']['policy-holder-mobile']!.toString());
                          policyAddresses.insert(idx, snapshot.data['$idx']['policy-holder-address']!.toString());
                          policyEmails.insert(idx, snapshot.data['$idx']['policy-holder-email']!.toString());
                          vehicleAmounts.insert(idx, snapshot.data['$idx']['vehicle-amount']!);

                          List<UserVehicleWidget> userVehicles = [];

                          if(snapshot.data['$idx']['vehicle-amount'] != 0){
                            print("VEHICLE AMOUNT: ${snapshot.data['$idx']['vehicle-amount']}");

                            int vehicleIndex = 0;
                            while(vehicleIndex < snapshot.data['$idx']['vehicle-amount']){
                              print("REACHED WHILE LOOP TO CHANGE userVehicles");

                              UserVehicleWidget newVehicle = UserVehicleWidget(
                                currentIndex: snapshot.data['$idx']['vehicles']['$vehicleIndex']['vehicle-index']!,
                                vehicleLicenseId: snapshot.data['$idx']['vehicles']['$vehicleIndex']['vehicle-driving-license']!.toString(),
                                vehicleChassisNumber: snapshot.data['$idx']['vehicles']['$vehicleIndex']['vehicle-chassis-number']!.toString(),
                                vehicleMake: snapshot.data['$idx']['vehicles']['$vehicleIndex']['vehicle-make']!.toString(),
                                vehicleModel: snapshot.data['$idx']['vehicles']['$vehicleIndex']['vehicle-model']!.toString(),
                                vehicleMotorNumber: snapshot.data['$idx']['vehicles']['$vehicleIndex']['vehicle-motor-number']!.toString(),
                                vehiclePlateNumber: snapshot.data['$idx']['vehicles']['$vehicleIndex']['vehicle-plate-number']!.toString(),
                                productionYear: snapshot.data['$idx']['vehicles']['$vehicleIndex']['vehicle-production-year']!.toString(),
                                vehicleValue: snapshot.data['$idx']['vehicles']['$vehicleIndex']['vehicle-value']!.toString(),
                                vehicleType: '',
                                vehicleNumberOfSeats: '',
                                vehicleWeight: '',
                              );

                              userVehicles.add(newVehicle);
                              vehicleIndex++;
                            }

                            policyVehicleIndexes.add(1000);
                            policyVehicleMakes.add("");
                            policyVehicleModels.add("");
                            policyProductionYears.add("");
                            policyVehicleValues.add("");
                            policyVehicleLicenseId.add("");
                            policyVehicleDrivingLicenses.add("");
                            policyPlateNumbers.add("");
                            policyChassisNumbers.add("");
                            policyMotorNumbers.add("");
                            print("FINISHED WHILE LOOP");
                          }
                          else{
                            policyVehicleIndexes.insert(idx, snapshot.data['$idx']['vehicle-index']!);
                            policyVehicleMakes.insert(idx, snapshot.data['$idx']['vehicle-make']!.toString());
                            policyVehicleModels.insert(idx, snapshot.data['$idx']['vehicle-model']!.toString());
                            policyProductionYears.insert(idx, snapshot.data['$idx']['vehicle-production-year']!.toString());
                            policyVehicleValues.insert(idx, snapshot.data['$idx']['vehicle-value']!.toString());
                            policyVehicleLicenseId.insert(idx, snapshot.data['$idx']['vehicle-license-id']!.toString());
                            policyVehicleDrivingLicenses.insert(idx, snapshot.data['$idx']['vehicle-driving-license']!.toString());
                            policyPlateNumbers.insert(idx, snapshot.data['$idx']['vehicle-plate-number']!.toString());
                            policyChassisNumbers.insert(idx, snapshot.data['$idx']['vehicle-chassis-number']!.toString());
                            policyMotorNumbers.insert(idx, snapshot.data['$idx']['vehicle-motor-number']!.toString());
                          }

                          vehiclesRequested.add(userVehicles);
                          idx++;
                        }

                        return Container(
                          width: 1100,
                          height: 800,
                          child: buildDataTable(
                            requestsDocBrokerPolicyRequestData(),
                            policyApprovedByIC,
                            policyPositions,
                            newNames,
                            policyIDs,
                            policyMobiles,
                            policyAddresses,
                            policyEmails,
                            policyVehicleMakes,
                            policyVehicleModels,
                            policyProductionYears,
                            policyVehicleValues,
                            policyVehicleLicenseId,
                            policyVehicleDrivingLicenses,
                            policyVehicleIndexes,
                            policyPlateNumbers,
                            policyChassisNumbers,
                            policyMotorNumbers,
                            insuranceCompaniesAssigned,
                            policyBrokerNames,
                            vehiclesRequested,
                            vehicleAmounts,
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

      Future<Map<String, dynamic>?> func,
      List<bool> policyApprovedByIC,
      List<int> policyPositions,
      List<String> finalNames,
      List<String> policyIDs,
      List<String> policyMobiles,
      List<String> policyAddresses,
      List<String> policyEmails,
      List<String> policyVehicleMakes,
      List<String> policyVehicleModels ,
      List<String> policyProductionYears ,
      List<String> policyVehicleValues,
      List<String> policyVehicleLicenseId ,
      List<String> policyVehicleDrivingLicenses,
      List<int> policyVehicleIndexes,
      List<String> policyPlateNumbers,
      List<String> policyChassisNumbers,
      List<String> policyMotorNumbers,
      List<String> insuranceCompaniesAssigned,
      List<String> policyBrokerNames,
      List<List<UserVehicleWidget>> vehiclesRequested,
      List<int> vehicleAmounts,
      ){

    final columns = ['Client Name', 'Vehicle Make', 'Vehicle Model', 'Driving License'];

    List<Map> myMap = [];
    DataBaseService dataBaseService = DataBaseService();

    int currentPolicyIndex = 0;
    while(currentPolicyIndex < finalNames.length){
      if(policyApprovedByIC[currentPolicyIndex] == false && policyBrokerNames[currentPolicyIndex] == currentBrokerCompany){
        Map newMap = Map();
        if(vehicleAmounts[currentPolicyIndex] != 0){
          newMap['vehicle-make'] = "";
          newMap['vehicle-model'] = "";
          newMap['client-name'] = finalNames[currentPolicyIndex];
          newMap['broker-name'] = policyBrokerNames[currentPolicyIndex];
          newMap['vehicle-driving-license'] = "";
          newMap['policy-number'] = policyPositions[currentPolicyIndex];
        }
        else{
          newMap['vehicle-make'] = policyVehicleMakes[currentPolicyIndex];
          newMap['vehicle-model'] = policyVehicleModels[currentPolicyIndex];
          newMap['client-name'] = finalNames[currentPolicyIndex];
          newMap['broker-name'] = policyBrokerNames[currentPolicyIndex];
          newMap['vehicle-driving-license'] = policyVehicleDrivingLicenses[currentPolicyIndex];
          newMap['policy-number'] = policyPositions[currentPolicyIndex];
        }
        myMap.add(newMap);
      }
      currentPolicyIndex++;
    }

    return DataTable(
      headingRowColor: MaterialStateColor.resolveWith((states) {return Colors.blueGrey.shade50;},),
      showBottomBorder: true,
      horizontalMargin: 15,
      dividerThickness: 1,
      headingRowHeight: 40,
      dataRowHeight: 70,
      columns: getColumns(columns),
      rows: getRows(myMap,
        func,
        policyApprovedByIC,
        policyPositions,
        finalNames,
        policyIDs,
        policyMobiles,
        policyAddresses,
        policyEmails,
        policyVehicleMakes,
        policyVehicleModels,
        policyProductionYears,
        policyVehicleValues,
        policyVehicleLicenseId,
        policyVehicleDrivingLicenses,
        policyVehicleIndexes,
        policyPlateNumbers,
        policyChassisNumbers,
        policyMotorNumbers,
        policyBrokerNames,
        vehiclesRequested,
      ),
    );
  }

  List<DataRow> getRows(
      List<Map> companyList,
      Future<Map<String, dynamic>?> func,
      policyApprovedByIC,
      policyPositions,
      finalNames,
      policyIDs,
      policyMobiles,
      policyAddresses,
      policyEmails,
      policyVehicleMakes,
      policyVehicleModels,
      policyProductionYears,
      policyVehicleValues,
      policyVehicleLicenseId,
      policyVehicleDrivingLicenses,
      policyVehicleIndexes,
      policyPlateNumbers,
      policyChassisNumbers,
      policyMotorNumbers,
      policyBrokerNames,
      vehiclesRequested,
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
            child: Text("${current['client-name']}", style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),
        DataCell(
          Container(
            width: 90,
            child: Text("${current['vehicle-make']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),

        DataCell(
          Container(
            width: 90,
            child: Text("${current['vehicle-model']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),

        ),
        DataCell(
          Container(
            width: 90,
            child: Text("${current['vehicle-driving-license']}",style: TextStyle(
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