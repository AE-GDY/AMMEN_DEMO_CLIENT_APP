import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newest_insurance/models/user_vehicle.dart';
import 'package:newest_insurance/services/database.dart';

import '../constants.dart';

class PoliciesPage extends StatefulWidget {
  const PoliciesPage({Key? key}) : super(key: key);

  @override
  _PoliciesPageState createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  List<Map> selectedComps = [];
  bool companySelected = false;
  Map currentlySelected = {};


  @override
  Widget build(BuildContext context) {


    print("broker comp: $currentBrokerCompany");
    print("signinasbroker: $signInAsBroker");

    Future<Map<String, dynamic>?> policyRequestData() async {
      return (await FirebaseFirestore.instance.collection('users-policy-requests').
      doc(currentInsuranceCompany).get()).data();
    }

    Future<Map<String, dynamic>?> usersSignedUp() async {
      return (await FirebaseFirestore.instance.collection('users-signed-up').
      doc("users").get()).data();
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(signInAsBroker?"${currentBrokerCompany} Policies":"${currentInsuranceCompany} Policies"),
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
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height + 2000,
          child: Stack(
            children: [
              // FIRST
              Positioned(
                left: 0,
                //right: 0,
                child: Container(
                  width: 210,
                  height: MediaQuery.of(context).size.height + 2000,
                  color: Colors.grey[100],
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
                            Navigator.pushNamed(context, '/home');
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.directions_car),
                        title: Text("Policies", style: TextStyle(
                          fontSize: 12,
                        ),),
                        onTap: (){
                          setState(() {
                            if(signInAsBroker){
                              print("as broker");
                              Navigator.pushNamed(context, '/broker-page');
                            }
                            else{
                              print("as insurance comp");
                              Navigator.pushNamed(context, '/policies-page');
                            }
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
                            Navigator.pushNamed(context, '/claims-page');
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
                            Navigator.pushNamed(context, '/complains');
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
                        future: policyRequestData(),
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
                        future: policyRequestData(),
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
                        future: policyRequestData(),
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
                        future: claimRequestData(),
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
                                                  text: "${snapshot.data[signInAsBroker?currentBrokerCompany:currentInsuranceCompany]['total-claim-amount']+1}",
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
                  future: Future.wait([policyRequestData(),usersSignedUp(),]),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('there is an error'),
                        );
                      }
                      else if(snapshot.hasData){
                        final List<int> policyAmounts = [];
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
                        final List<int> brokerPolicyNumbers = [];
                        final List<List<UserVehicleWidget>> vehiclesRequested = [];
                        final List<int> vehicleAmounts = [];
                        final List<String> vehicleTypes = [];
                        final List<String> vehicleWeights = [];
                        final List<String> vehicleNumberOfSeats = [];

                        int idx = 0;

                        while(idx <= snapshot.data[0]['total-policy-amount']){
                          newNames.add(snapshot.data[0]['$idx']['policy-holder-name']!.toString());
                          policyBrokerNames.insert(idx, snapshot.data[0]['$idx']['broker-name']!.toString());
                          policyApprovedByIC.insert(idx, snapshot.data[0]['$idx']['status-ic-approved']!);
                          policyAmounts.insert(idx, snapshot.data[0]['$idx']['policy-amount']!);
                          policyPositions.insert(idx, snapshot.data[0]['$idx']['policy-number']!);
                          policyIDs.insert(idx, snapshot.data[0]['$idx']['policy-holder-id']!.toString());
                          policyMobiles.insert(idx, snapshot.data[0]['$idx']['policy-holder-mobile']!.toString());
                          policyAddresses.insert(idx, snapshot.data[0]['$idx']['policy-holder-address']!.toString());
                          policyEmails.insert(idx, snapshot.data[0]['$idx']['policy-holder-email']!.toString());
                          vehicleAmounts.insert(idx, snapshot.data[0]['$idx']['vehicle-amount']!);


                          List<UserVehicleWidget> userVehicles = [];
                          if(snapshot.data[0]['$idx']['vehicle-amount'] != 0){

                            print("VEHICLE AMOUNT: ${snapshot.data[0]['$idx']['vehicle-amount']}");

                            int vehicleIndex = 0;
                            while(vehicleIndex < snapshot.data[0]['$idx']['vehicle-amount']){
                              print("REACHED WHILE LOOP TO CHANGE userVehicles");
                              UserVehicleWidget newVehicle;

                              if(snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-type'] != ''){
                                 newVehicle = UserVehicleWidget(
                                  currentIndex: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-index']!,
                                  vehicleLicenseId: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-driving-license']!.toString(),
                                  vehicleChassisNumber: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-chassis-number']!.toString(),
                                  vehicleMake: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-make']!.toString(),
                                  vehicleModel: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-model']!.toString(),
                                  vehicleMotorNumber: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-motor-number']!.toString(),
                                  vehiclePlateNumber: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-plate-number']!.toString(),
                                  productionYear: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-production-year']!.toString(),
                                  vehicleValue: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-value']!.toString(),
                                  vehicleType: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-type']!.toString(),
                                  vehicleWeight: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-weight']!.toString(),
                                  vehicleNumberOfSeats: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['no-seats']!.toString(),
                                );
                              }
                              else{
                                 newVehicle = UserVehicleWidget(
                                  currentIndex: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-index']!,
                                  vehicleLicenseId: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-driving-license']!.toString(),
                                  vehicleChassisNumber: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-chassis-number']!.toString(),
                                  vehicleMake: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-make']!.toString(),
                                  vehicleModel: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-model']!.toString(),
                                  vehicleMotorNumber: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-motor-number']!.toString(),
                                  vehiclePlateNumber: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-plate-number']!.toString(),
                                  productionYear: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-production-year']!.toString(),
                                  vehicleValue: snapshot.data[0]['$idx']['vehicles']['$vehicleIndex']['vehicle-value']!.toString(),
                                  vehicleType: '',
                                  vehicleWeight: '',
                                  vehicleNumberOfSeats: '',
                                );
                              }





                              userVehicles.add(newVehicle);

                              vehicleIndex++;
                            }

                            policyVehicleIndexes.add(1000);
                            vehicleWeights.add("");
                            vehicleTypes.add("");
                            vehicleNumberOfSeats.add("");
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
                            //print("ZERO VEHICLES");


                            if(snapshot.data[0]['$idx']['vehicle-type'] != ''){
                              vehicleTypes.add(snapshot.data[0]['$idx']['vehicle-type']!.toString());
                              vehicleWeights.add(snapshot.data[0]['$idx']['vehicle-weight']!.toString());
                              vehicleNumberOfSeats.add(snapshot.data[0]['$idx']['no-seats']!.toString());
                            }
                            else{
                              vehicleTypes.add("");
                              vehicleWeights.add("");
                              vehicleNumberOfSeats.add("");
                            }

                            policyVehicleIndexes.add(snapshot.data[0]['$idx']['vehicle-index']!);
                            policyVehicleMakes.add(snapshot.data[0]['$idx']['vehicle-make']!.toString());
                            policyVehicleModels.add( snapshot.data[0]['$idx']['vehicle-model']!.toString());
                            policyProductionYears.add( snapshot.data[0]['$idx']['vehicle-production-year']!.toString());
                            policyVehicleValues.add( snapshot.data[0]['$idx']['vehicle-value']!.toString());
                            policyVehicleLicenseId.add( snapshot.data[0]['$idx']['vehicle-license-id']!.toString());
                            policyVehicleDrivingLicenses.add( snapshot.data[0]['$idx']['vehicle-driving-license']!.toString());
                            policyPlateNumbers.add(snapshot.data[0]['$idx']['vehicle-plate-number']!.toString());
                            policyChassisNumbers.add( snapshot.data[0]['$idx']['vehicle-chassis-number']!.toString());
                            policyMotorNumbers.add(snapshot.data[0]['$idx']['vehicle-motor-number']!.toString());

                          }

                          vehiclesRequested.add(userVehicles);
                          idx++;
                        }

                        /*
                         print("SIZE OF NEWNAMES: ${newNames.length}");

                        int idx2 = 0;
                        while(idx2 < newNames.length){
                          print("NAME: ${newNames[idx2]}");
                          idx2++;
                        }
                        */

                        return Container(
                          width: 1100,
                          height: 800,
                          child: buildDataTable(
                            policyRequestData(),
                            policyApprovedByIC,
                            policyAmounts,
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
                            brokerPolicyNumbers,
                            vehiclesRequested,
                            vehicleAmounts,
                            vehicleTypes,
                            vehicleWeights,
                            vehicleNumberOfSeats,
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
      List<int> policyAmounts,
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
      List<int> brokerPolicyNumbers,
      List<List<UserVehicleWidget>> vehiclesRequested,
      List<int> vehicleAmounts,
      List<String> vehicleTypes,
      List<String> vehicleWeights,
      List<String> vehicleNumberOfSeats,
      ){

    final columns = ['Client Name', 'Vehicle Make', 'Vehicle Model', 'Driving License', 'Status'];

    List<Map> myMap = [];
    DataBaseService dataBaseService = DataBaseService();



    int currentPolicyIndex = 0;
      while(currentPolicyIndex < finalNames.length){

      if(policyApprovedByIC[currentPolicyIndex] == false){
        print("REACHED HERE!!!!!!!!!!!!!!!!!!!!!!!!!!");
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
        policyAmounts,
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
          brokerPolicyNumbers,
        vehiclesRequested,
        vehicleTypes,
        vehicleWeights,
        vehicleNumberOfSeats,

      ),
    );
  }

  List<DataRow> getRows(
      List<Map> companyList,
      Future<Map<String, dynamic>?> func,
  policyApprovedByIC,
  policyPositions,
  policyAmounts,
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
      brokerPolicyNumbers,
      vehiclesRequested,
      vehicleTypes,
      vehicleWeights,
      vehicleNumberOfSeats,
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
            child: Text("${(current['broker-name'] != "none")?current['broker-name']:current['client-name']}", style: TextStyle(
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
            width: 60,
            child: Text("${current['vehicle-driving-license']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),

        ),
        DataCell(
          FutureBuilder(
            future: func,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return const Text("There is an error");
                }
                else if(snapshot.hasData){
                  return SizedBox(
                    width: 120,
                    child: TextButton(
                      onPressed: () async {
                        if(snapshot.data['${current['policy-number']}']['status-waiting-user-schedule-approval'] == false){
                          setState(() {
                            globalCurrentPolicyIndex = current['policy-number'];
                            globalPolicyApprovedByIC = policyApprovedByIC;
                            globalPolicyPositions = policyPositions;
                            globalPolicyAmounts = policyAmounts;
                            globalNewNames = finalNames;
                            globalPolicyIDs = policyIDs;
                            globalPolicyMobiles = policyMobiles;
                            globalPolicyAddresses = policyAddresses;
                            globalPolicyEmails = policyEmails;
                            globalPolicyVehicleMakes = policyVehicleMakes;
                            globalPolicyVehicleModels = policyVehicleModels;
                            globalPolicyProductionYears = policyProductionYears;
                            globalPolicyVehicleValues = policyVehicleValues;
                            globalPolicyVehicleLicenseId = policyVehicleLicenseId;
                            globalPolicyVehicleDrivingLicenses = policyVehicleDrivingLicenses;
                            globalPolicyVehicleIndexes = policyVehicleIndexes;
                            globalPolicyPlateNumbers = policyPlateNumbers;
                            globalChassisNumbers = policyChassisNumbers;
                            globalPolicyMotorNumbers = policyMotorNumbers;
                            globalBrokerPolicyNumbers = brokerPolicyNumbers;
                            globalVehicleTypes = vehicleTypes;
                            globalVehicleWeights = vehicleWeights;
                            globalNumberOfSeats = vehicleNumberOfSeats;
                            if(vehiclesRequested.length != 0){
                              globalVehiclesRequested = vehiclesRequested;
                            }

                            int policiesRequestedIndex = 0;

                            while(policiesRequestedIndex < policyVehicleIndexes.length){
                              print("vehicle index: ${policyVehicleIndexes[policiesRequestedIndex]}");
                              policiesRequestedIndex++;
                            }


                            print("CURRENT POLICY INDEX:$globalCurrentPolicyIndex");

                            //insuranceCompanyList
                            /*
                            print("Current policy index: $globalCurrentPolicyIndex");
                            print("Current insurance company: $currentInsuranceCompany");
                            print("sign in as broker: $signInAsBroker");
                            print("Current policy holder name: ${globalNewNames[globalCurrentPolicyIndex]}");
                            */

                            print("vehicle amount: ${globalVehiclesRequested[globalCurrentPolicyIndex].length}");
                          });
                          //DataBaseService dataBaseService = DataBaseService();
                          //await dataBaseService.updatePolicyIdx(globalCurrentPolicyIndex);
                          Navigator.pushNamed(context, '/policy-status');
                        }
                      },
                      child: Text(
                        snapshot.data['${current['policy-number']}']['status-schedule-date-denied']?"Date Denied":
                        snapshot.data['${current['policy-number']}']['status-scheduling']?"Scheduling":
                        snapshot.data['${current['policy-number']}']['status-user-denied-policy-details']?"User Denied Policy Details":
                        snapshot.data['${current['policy-number']}']['status-waiting-broker-underwriting-approval']?"Waiting Broker Underwriting Approval":
                        snapshot.data['${current['policy-number']}']['status-waiting-broker-schedule-approval']?"Waiting Broker Approval":
                        snapshot.data['${current['policy-number']}']['status-waiting-broker-inspection-approval']?"Waiting Broker Inspection Approval":
                        snapshot.data['${current['policy-number']}']['status-waiting-user-schedule-approval']?"Waiting Schedule Approval":
                        snapshot.data['${current['policy-number']}']['status-inspection']?"Inspection":
                        snapshot.data['${current['policy-number']}']['status-underwriting']?"Underwriting":
                        snapshot.data['${current['policy-number']}']['status-waiting-ic-approval']?"Pending Approval":
                        "Approved"
                        ,style: TextStyle(
                        fontSize: 18,
                      ),),
                    ),
                  );
                }
              }
              return const Text("Please wait");
            },

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




/*

*/