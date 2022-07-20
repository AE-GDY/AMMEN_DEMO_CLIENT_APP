import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newest_insurance/companies/insurancecompanies.dart';
import 'package:newest_insurance/constants.dart';
import 'package:newest_insurance/services/database.dart';

class PolicyStatusBroker extends StatefulWidget {
  const PolicyStatusBroker({Key? key}) : super(key: key);

  @override
  _PolicyStatusBrokerState createState() => _PolicyStatusBrokerState();
}

class _PolicyStatusBrokerState extends State<PolicyStatusBroker> {

  DataBaseService dataBaseService = DataBaseService();

  Future<Map<String, dynamic>?> requestsDocBrokerPolicyRequestData() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc("requests").get()).data();
  }

  String assignedCompany = "none";
  String currentBroker = "none";

  Future<Map<String, dynamic>?> insuranceCompanyPolicyData(String assignedComp) async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc(assignedComp).get()).data();
  }

  Future<Map<String, dynamic>?> brokerCompanyPolicyData(String assignedComp) async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests-broker').
    doc(currentBroker).get()).data();
  }

  Future<Map<String, dynamic>?> usersSignedUp() async {
    return (await FirebaseFirestore.instance.collection('users-signed-up').
    doc("users").get()).data();
  }

  Future<Map<String, dynamic>?> currentPolicyRequest() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc(globalCompanyAssigned).get()).data();
  }

  Future<Map<String, dynamic>?> requestsDocCurrentPolicyRequest() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc("requests").get()).data();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Status"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1500,
          width: 1500,
          child: Stack(
            children: [
              Positioned(
                top: 50,
                left: 50,
                child: Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 5,
                        left: 90,
                        child: Text("Policy holder information", style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 50,
                        left: 10,
                        child: Text("Name: ${globalNewNames[globalCurrentPolicyIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 80,
                        left: 10,
                        child: Text("National ID: ${globalPolicyIDs[globalCurrentPolicyIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 110,
                        left: 10,
                        child: Text("Mobile: ${globalPolicyMobiles[globalCurrentPolicyIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 140,
                        left: 10,
                        child: Text("Email: ${globalPolicyEmails[globalCurrentPolicyIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ],
                  ),
                ),
              ),

              //VEHICLE INFO
              buildVehicleInfo(),


              Positioned(
                top: 50,
                left: 500,
                child: Container(
                  width: 400,
                  height: 300,
                  child: FutureBuilder(
                    future: Future.wait([requestsDocBrokerPolicyRequestData(),brokerCompanyPolicyData(currentBroker)]),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.hasError){
                          return const Text("Please wait");
                        }
                        else if(snapshot.hasData){

                          if(snapshot.data[0]['$globalCurrentPolicyIndex']['status-waiting-broker-schedule-approval']){
                            return  Positioned(
                              top: 50,
                              left: 850,
                              child: Container(
                                height: 900,
                                width: 400,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Column(
                                  children: [
                                    Text("Time scheduled: ${snapshot.data[0]['$globalCurrentPolicyIndex']['time-scheduled']}",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    ),
                                    Text("Date scheduled: ${snapshot.data[0]['$globalCurrentPolicyIndex']['day-scheduled']}/${snapshot.data[0]['$globalCurrentPolicyIndex']['month-scheduled']}/${snapshot.data[0]['$globalCurrentPolicyIndex']['year-scheduled']}",
                                      style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        SizedBox(width: 70,),
                                        Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: TextButton(
                                            onPressed: () async {
                                              Navigator.pushNamed(context, '/broker-page');
                                              /*
                                              setState(() {
                                                currentBroker = snapshot.data[0]['$globalCurrentPolicyIndex']['broker-name'];
                                              });
                                              */

                                              await dataBaseService.requestsDocUpdateSchedulingToWaitingUserApprovalStatus(
                                                globalCurrentPolicyIndex
                                              );

                                              print("CURRENT POLICY INDEX: ${snapshot.data[0]['$globalCurrentPolicyIndex']['policy-idx']}");
                                              await dataBaseService.updateSchedulingToWaitingUserApprovalStatus(
                                                  snapshot.data[0]['$globalCurrentPolicyIndex']['intended-company'],
                                                  snapshot.data[0]['$globalCurrentPolicyIndex']['policy-idx'],
                                              );

                                              /*
                                              await dataBaseService.updateTotalNewRequests(
                                                snapshot.data[0]['$globalCurrentPolicyIndex']['broker-name'],
                                                snapshot.data[1]['$globalCurrentPolicyIndex']['total-new-requests']-1,
                                              );
                                              */

                                            },
                                            child: Text("Confirm", style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                          ),
                                        ),
                                        SizedBox(width: 30,),
                                        Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: TextButton(
                                            onPressed: (){},
                                            child: Text("Deny",style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          else if(snapshot.data[0]['$globalCurrentPolicyIndex']['status-scheduling']){
                            return Column(
                              children: [
                                Text("Assign Insurance Company"),
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
                                        assignedCompany = insComp!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 10,),
                                FutureBuilder(
                                  future: Future.wait([insuranceCompanyPolicyData(assignedCompany),usersSignedUp()]),
                                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                    if(snapshot.connectionState == ConnectionState.done){
                                      if(snapshot.hasError){
                                        return const Text("There is an error");
                                      }
                                      else if(snapshot.hasData){
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          width: 100,
                                          height: 40,
                                          child: TextButton(
                                            onPressed: () async {


                                              Navigator.pushNamed(context, '/broker-page');

                                              int policyAmount = 0;
                                              int idx1 = 0;
                                              while(idx1 < firstCompanies.length){
                                                if(firstCompanies[idx1].title == assignedCompany){
                                                  policyAmount = firstCompanies[idx1].price;
                                                  break;
                                                }
                                                idx1++;
                                              }

                                              idx1 = 0;
                                              while(idx1 < secondCompanies.length){
                                                if(secondCompanies[idx1].title == assignedCompany){
                                                  policyAmount = secondCompanies[idx1].price;
                                                  break;
                                                }
                                                idx1++;
                                              }

                                              if(globalVehiclesRequested[globalCurrentPolicyIndex].isEmpty){

                                                print("SDHIFDSFSDDSFIOJDSIJFSDIOFJASIFOAISJDFIOASJFIOAS");

                                                setState(() {
                                                  snapshot.data[0]['total-policy-amount']++;
                                                  snapshot.data[0]['total-new-requests']++;
                                                });


                                                await dataBaseService.updatePolicyRequestsData(
                                                  globalCurrentPolicyIndex,
                                                  policyAmount,
                                                  assignedCompany,
                                                  currentBrokerCompany,
                                                  snapshot.data[0]['total-policy-amount'],
                                                  snapshot.data[0]['total-new-requests'],
                                                );


                                                int idx = 0;
                                                while(idx <= snapshot.data[1]['total-user-amount']){
                                                  if(snapshot.data[1]['$idx']['user-name'] == globalNewNames[globalCurrentPolicyIndex]){
                                                    print("GLOBAL POLICY USER INDEX: $idx");
                                                    await dataBaseService.changeIntendedCompanyUsersSignedUp(
                                                        assignedCompany,
                                                        idx,
                                                        globalPolicyVehicleIndexes[globalCurrentPolicyIndex]);
                                                  }
                                                  idx++;
                                                }

                                              }
                                              else{

                                                int idx = 0;
                                                while(idx <= snapshot.data[1]['total-user-amount']){
                                                  if(snapshot.data[1]['$idx']['user-name'] == globalNewNames[globalCurrentPolicyIndex]){
                                                    int vIndex = 0;
                                                    while(vIndex < globalPolicyMultipleVehicleIndexes[globalCurrentPolicyIndex].length){
                                                      await dataBaseService.changeIntendedCompanyUsersSignedUp(
                                                        assignedCompany,
                                                        idx,
                                                        globalPolicyMultipleVehicleIndexes[globalCurrentPolicyIndex][vIndex],
                                                      );
                                                      vIndex++;
                                                    }
                                                  }
                                                  idx++;
                                                }

                                                int vehicleIndex = 0;

                                                while(vehicleIndex < globalVehiclesRequested[globalCurrentPolicyIndex].length){
                                                  await dataBaseService.updatePolicyRequestsDataCompany(
                                                    currentBrokerCompany,
                                                    policyAmount,
                                                    assignedCompany,
                                                    globalCurrentPolicyIndex,
                                                    globalVehiclesRequested[globalCurrentPolicyIndex].length,
                                                    vehicleIndex,
                                                    snapshot.data[0]['total-policy-amount']+1,
                                                    snapshot.data[0]['total-new-requests']+1,
                                                  );
                                                  vehicleIndex++;
                                                }
                                              }

                                              await dataBaseService.requestsDocUpdateIntendedCompany(
                                                  policyAmount,
                                                  assignedCompany, globalCurrentPolicyIndex
                                              );
                                            },
                                            child: Text("Confirm",style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                          ),
                                        );
                                      }
                                    }
                                    return const Text("Please wait");
                                  },

                                ),
                              ],
                            );
                          }
                          else if(snapshot.data[0]['$globalCurrentPolicyIndex']['status-waiting-broker-inspection-approval']){
                            return Column(
                              children: [
                                Text("Inspection Details", style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),),
                                SizedBox(height: 10,),
                                Container(
                                  height: 100,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[50],
                                    border: Border.all(width: 1.0,),
                                  ),
                                  child: Center(child: Text("Inspection Report", style: TextStyle(
                                    fontSize: 20,
                                  ),)),
                                ),
                                Container(
                                  height: 100,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[50],
                                    border: Border.all(width: 1.0,),
                                  ),
                                  child: Center(child: Text("Vehicle Attachments", style: TextStyle(
                                    fontSize: 20,
                                  ),)),
                                ),
                                SizedBox(height: 20,),
                                FutureBuilder(
                                  future: Future.wait([currentPolicyRequest(),requestsDocCurrentPolicyRequest()]),
                                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                    if(snapshot.connectionState == ConnectionState.done){
                                      if(snapshot.hasError){
                                        return const Text("There is an error");
                                      }
                                      else if(snapshot.hasData){
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          width: 150,
                                          height: 40,
                                          child: TextButton(
                                            onPressed: () async {
                                              //Navigator.pushNamed(context, '/broker-page');


                                              if(globalVehiclesRequested[globalCurrentPolicyIndex].isEmpty){
                                                int idx = 0;
                                                while(idx <= snapshot.data[1]['total-policy-amount']){
                                                  if(globalNewNames[globalCurrentPolicyIndex] == snapshot.data[1]['$idx']['policy-holder-name']
                                                      && globalCompanyAssigned == snapshot.data[1]['$idx']['intended-company']
                                                      && globalPolicyVehicleIndexes[globalCurrentPolicyIndex] == snapshot.data[1]['$idx']['vehicle-index']
                                                  ){

                                                    await dataBaseService.updateInspectionToUnderwriting(
                                                      globalCompanyAssigned,
                                                      snapshot.data[1]['$idx']['policy-idx'],
                                                      false,
                                                    );


                                                    await dataBaseService.requestsDocUpdateInspectionToUnderwriting(idx);

                                                  }
                                                  idx++;
                                                }
                                              }
                                              else{
                                                int idx = 0;
                                                while(idx <= snapshot.data[1]['total-policy-amount']){
                                                  if(globalNewNames[globalCurrentPolicyIndex] == snapshot.data[1]['$idx']['policy-holder-name']
                                                      && snapshot.data[1]['$idx']['vehicle-amount'] == globalVehiclesRequested[globalCurrentPolicyIndex].length){

                                                    bool isPolicy = true;
                                                    int vehicleIdx = 0;
                                                    while(vehicleIdx < globalVehiclesRequested[globalCurrentPolicyIndex].length){
                                                      if(snapshot.data[1]['$idx']['vehicles']['$vehicleIdx']['vehicle-index'] != globalVehiclesRequested[globalCurrentPolicyIndex][vehicleIdx].currentIndex){
                                                        isPolicy = false;
                                                      }
                                                      vehicleIdx++;
                                                    }

                                                    if(isPolicy){
                                                      if(globalCompanyAssigned == snapshot.data[1]['$idx']['intended-company']){
                                                        await dataBaseService.updateInspectionToUnderwriting(
                                                          globalCompanyAssigned,
                                                          snapshot.data[1]['$idx']['policy-idx'],
                                                          false,
                                                        );
                                                        await dataBaseService.requestsDocUpdateInspectionToUnderwriting(idx);
                                                      }
                                                    }
                                                  }
                                                  idx++;
                                                }
                                              }


                                              print("current USER: ${globalNewNames[globalCurrentPolicyIndex]}");
                                              Navigator.pushNamed(context, '/broker-page');
                                            },
                                            child: Text("Approve",style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                          ),
                                        );
                                      }
                                    }
                                    return const Text("Please wait");
                                  },

                                ),
                              ],
                            );
                          }
                          else if(snapshot.data[0]['$globalCurrentPolicyIndex']['status-waiting-broker-underwriting-approval']){
                            return Column(
                              children: [
                                Text("Underwriting Details", style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                                SizedBox(height: 10,),
                                Container(
                                  height: 100,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[50],
                                    border: Border.all(width: 1.0,),
                                  ),
                                  child: Center(child: Text("Underwriting Report", style: TextStyle(
                                    fontSize: 20,
                                  ),)),
                                ),
                                Container(
                                  height: 100,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[50],
                                    border: Border.all(width: 1.0,),
                                  ),
                                  child: Center(child: Text("Policy premium: ${globalPolicyValues[globalCurrentPolicyIndex]} EGP", style: TextStyle(
                                    fontSize: 20,
                                  ),)),
                                ),
                                SizedBox(height: 20,),
                                FutureBuilder(
                                  future: Future.wait([currentPolicyRequest(),requestsDocCurrentPolicyRequest()]),
                                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                    if(snapshot.connectionState == ConnectionState.done){
                                      if(snapshot.hasError){
                                        return const Text("There is an error");
                                      }
                                      else if(snapshot.hasData){
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          width: 150,
                                          height: 40,
                                          child: TextButton(
                                            onPressed: () async {
                                              //Navigator.pushNamed(context, '/broker-page');


                                              if(globalVehiclesRequested[globalCurrentPolicyIndex].isEmpty){
                                                int idx = 0;
                                                while(idx <= snapshot.data[1]['total-policy-amount']){
                                                  if(globalNewNames[globalCurrentPolicyIndex] == snapshot.data[1]['$idx']['policy-holder-name']
                                                      && globalCompanyAssigned == snapshot.data[1]['$idx']['intended-company']
                                                      && globalPolicyVehicleIndexes[globalCurrentPolicyIndex] == snapshot.data[1]['$idx']['vehicle-index']
                                                  ){
                                                    await dataBaseService.requestsDocUpdateUnderwritingToWaitingIcApproval(idx,globalPolicyValues[globalCurrentPolicyIndex]);
                                                    await dataBaseService.updateUnderwritingToWaitingICApproval(
                                                      globalCompanyAssigned,
                                                      snapshot.data[1]['$idx']['policy-idx'],
                                                      false,
                                                    );

                                                  }
                                                  idx++;
                                                }
                                              }
                                              else{
                                                int idx = 0;
                                                while(idx <= snapshot.data[1]['total-policy-amount']){
                                                  if(globalNewNames[globalCurrentPolicyIndex] == snapshot.data[1]['$idx']['policy-holder-name']
                                                      && snapshot.data[1]['$idx']['vehicle-amount'] == globalVehiclesRequested[globalCurrentPolicyIndex].length){

                                                    bool isPolicy = true;
                                                    int vehicleIdx = 0;
                                                    while(vehicleIdx < globalVehiclesRequested[globalCurrentPolicyIndex].length){
                                                      if(snapshot.data[1]['$idx']['vehicles']['$vehicleIdx']['vehicle-index'] != globalVehiclesRequested[globalCurrentPolicyIndex][vehicleIdx].currentIndex){
                                                        isPolicy = false;
                                                      }
                                                      vehicleIdx++;
                                                    }

                                                    if(isPolicy){
                                                      if(globalCompanyAssigned == snapshot.data[1]['$idx']['intended-company']){
                                                        await dataBaseService.requestsDocUpdateUnderwritingToWaitingIcApproval(idx,globalPolicyValues[globalCurrentPolicyIndex]);
                                                        await dataBaseService.updateUnderwritingToWaitingICApproval(
                                                          globalCompanyAssigned,
                                                          snapshot.data[1]['$idx']['policy-idx'],
                                                          false,
                                                        );
                                                      }
                                                    }
                                                  }
                                                  idx++;
                                                }
                                              }


                                              print("current USER: ${globalNewNames[globalCurrentPolicyIndex]}");
                                              Navigator.pushNamed(context, '/broker-page');
                                            },
                                            child: Text("Approve",style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                          ),
                                        );
                                      }
                                    }
                                    return const Text("Please wait");
                                  },

                                ),
                              ],
                            );
                          }
                          else{
                            return const Text("");
                          }
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

  Widget buildVehicleInfo(){
    if(globalVehiclesRequested[globalCurrentPolicyIndex].length == 0){
      return Positioned(
        top: 300,
        left: 50,
        child: Container(
          width: 400,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child:  Stack(
            children: [
              Positioned(
                top: 5,
                left: 110,
                child: Text("Vehicle Information", style: TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),),
              ),
              Positioned(
                top: 50,
                left: 10,
                child: Text("Vehicle Make: ${globalPolicyVehicleMakes[globalCurrentPolicyIndex]} ", style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.bold,
                ),),
              ),
              Positioned(
                top: 80,
                left: 10,
                child: Text("Vehicle Model: ${globalPolicyVehicleModels[globalCurrentPolicyIndex]}", style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.bold,
                ),),
              ),
              Positioned(
                top: 110,
                left: 10,
                child: Text("Production Year: ${globalPolicyProductionYears[globalCurrentPolicyIndex]}", style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.bold,
                ),),
              ),
              Positioned(
                top: 140,
                left: 10,
                child: Text("Plate Number: ${globalPolicyPlateNumbers[globalCurrentPolicyIndex]}", style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.bold,
                ),),
              ),
            ],
          ),
        ),
      );
    }
    else{
      return Positioned(
        top: 300,
        left: 50,
        child: Container(
          width: 400,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child:  Stack(
            children: [
              Positioned(
                top: 5,
                left: 110,
                child: Text("Vehicle Information", style: TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),),
              ),
              Positioned(
                top: 100,
                left: 120,
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/vehiclesRequested');
                    },
                    child: Text("View Vehicles", style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }


}