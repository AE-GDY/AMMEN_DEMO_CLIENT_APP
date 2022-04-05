import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newest_insurance/companies/insurancecompanies.dart';
import 'package:newest_insurance/constants.dart';
import 'package:newest_insurance/services/database.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class PolicyStatus extends StatefulWidget {

  double currentHeight = 200.0;
  PolicyStatus({Key? key}) : super(key: key);

  @override
  _PolicyStatusState createState() => _PolicyStatusState();
}

class _PolicyStatusState extends State<PolicyStatus> {

  final GlobalKey _key = GlobalKey();
  DataBaseService dataBaseService = DataBaseService();
  int currentTime = 0;
  String currentComp = "الدلتا للتأمين";

  List<String> timings = [
    "9:00",
    "9:15",
    "9:30",
    "9:45",
    "10:00",
    "10:15",
    "10:30",
    "10:45",
    "11:00",
    "11:15",
  ];

  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String currentInsuranceComp = "none";
  String currentBrokerComp = "none";
  TextEditingController underwriterController = TextEditingController();
  TextEditingController policyPremiumController = TextEditingController();


  bool changePolicyPremium = false;

  Future<Map<String, dynamic>?> policiesApprovedData() async {
    return (await FirebaseFirestore.instance.collection('users-policy-approvals').
    doc('approvals').get()).data();
  }

  Future<Map<String, dynamic>?> policiesSchedulingStatus() async {
    return (await FirebaseFirestore.instance.collection('users-policy-approvals').
    doc('scheduling').get()).data();
  }

  Future<Map<String, dynamic>?> currentPolicyRequest() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc(currentInsuranceCompany).get()).data();
  }

  Future<Map<String, dynamic>?> brokerCurrentPolicyRequest(String currentBroker) async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests-broker').
    doc(currentBroker).get()).data();
  }


  Future<Map<String, dynamic>?> requestsDocCurrentPolicyRequest() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc("requests").get()).data();
  }

  Future<Map<String, dynamic>?> getCurrentIdx() async {
    return (await FirebaseFirestore.instance.collection('users-policy-requests').
    doc("current-policy-request").get()).data();
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
          child:Stack(
            children: [

              // USER INFO
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

              //INSPECTION REPORT
              FutureBuilder(
                future: Future.wait([currentPolicyRequest(),requestsDocCurrentPolicyRequest()]),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){
                        print(snapshot.data[0]['$globalCurrentPolicyIndex']['status-inspection']);
                        if(snapshot.data[0]['$globalCurrentPolicyIndex']['status-inspection'] == true){
                          return  Positioned(
                            top: 20,
                            left: 500,
                            child: Container(
                              width: 300,
                              height: 250,
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
                              child: Column(
                                children: [
                                  Text("Inspector Report", style: TextStyle(
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 10,),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: "Comments",
                                    ),
                                  ),
                                  SizedBox(height: 10,),
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
                                  SizedBox(height: 10,),
                                  Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: () async {
                                        await dataBaseService.updateInspectionToUnderwriting(
                                          signInAsBroker?currentBrokerCompany:currentInsuranceCompany,
                                          globalCurrentPolicyIndex,
                                          signInAsBroker,
                                        );

                                        if(globalVehiclesRequested[globalCurrentPolicyIndex].isEmpty){
                                          int idx = 0;
                                          while(idx <= snapshot.data[1]['total-policy-amount']){
                                            if(globalNewNames[globalCurrentPolicyIndex] == snapshot.data[1]['$idx']['policy-holder-name']
                                                && currentInsuranceCompany == snapshot.data[1]['$idx']['intended-company']
                                                && globalPolicyVehicleIndexes[globalCurrentPolicyIndex] == snapshot.data[1]['$idx']['vehicle-index']
                                            ){
                                              print("REACHED REQUESTS DOC");
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
                                                if(currentInsuranceCompany == snapshot.data[1]['$idx']['intended-company']){
                                                  await dataBaseService.requestsDocUpdateInspectionToUnderwriting(idx);
                                                }
                                              }
                                            }
                                            idx++;
                                          }
                                        }


                                        print("current USER: ${globalNewNames[globalCurrentPolicyIndex]}");
                                        Navigator.pushNamed(context, '/policies-page');
                                      },
                                      child: Text("Complete Inspection", style: TextStyle(
                                        color: Colors.white,
                                      ),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        else if(snapshot.data[0]['$globalCurrentPolicyIndex']['status-scheduling'] == true){
                          return  Positioned(
                            top: 50,
                            left: 500,
                            child: Container(
                              width: 300,
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
                              child: Column(
                                children: [
                                  Text("Inspector Report", style: TextStyle(
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 40,),
                                  Text("Waiting for scheduling", style: TextStyle(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                  ),),
                                ],
                              ),
                            ),
                          );
                        }
                        else{
                          return  Positioned(
                            top: 50,
                            left: 500,
                            child: Container(
                              width: 300,
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
                              child: Column(
                                children: [
                                  Text("Inspector Report", style: TextStyle(
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 40,),
                                  Text("Complete", style: TextStyle(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                  ),),
                                ],
                              ),
                            ),
                          );
                        }

                      }
                  }
                  return const Text("");
                },

              ),

              FutureBuilder(
                future: currentPolicyRequest(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){
                        if(snapshot.data['$globalCurrentPolicyIndex']['status-scheduling'] == true){
                          return Positioned(
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
                                  SizedBox(
                                    height: widget.currentHeight,
                                    child: TableCalendar(
                                      key: _key,
                                      focusedDay:selectedDay,
                                      firstDay: DateTime(1990),
                                      lastDay: DateTime(2050),
                                      calendarFormat: format,
                                      daysOfWeekVisible: true,
                                      calendarStyle: CalendarStyle(
                                        isTodayHighlighted:true,
                                        selectedDecoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.rectangle,
                                          // borderRadius: BorderRadius.circular(10),
                                        ),

                                        todayTextStyle: TextStyle(color: Colors.black),
                                        selectedTextStyle: TextStyle(color: Colors.black),
                                        todayDecoration: BoxDecoration(
                                          border: Border.all(
                                            color:Colors.black,
                                          ),
                                          color:Colors.white,
                                          shape: BoxShape.rectangle,
                                          //borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      headerStyle: HeaderStyle(
                                        formatButtonVisible: true,
                                        titleCentered: true,
                                        formatButtonShowsNext: false,
                                      ),
                                      selectedDayPredicate: (DateTime date){
                                        return isSameDay(selectedDay, date);
                                      },
                                      onDaySelected: (DateTime selectDay, DateTime focusDay){
                                        setState(() {
                                          if((focusDay.day >= DateTime.now().day && focusDay.month == DateTime.now().month) || focusDay.month > DateTime.now().month){
                                            onCalender = true;
                                            selectedDay = selectDay;
                                            focusedDay = focusDay;
                                            timePicked = selectedDay;
                                          }
                                        });
                                        String formattedDate = DateFormat.LLLL().format(timePicked);
                                        print(timePicked.day);
                                      },
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: ScrollPhysics(),
                                    child: Container(
                                      height: 50,
                                      margin: EdgeInsets.only(right: 20),
                                      child: ListView.builder(
                                        itemCount: 10,
                                        scrollDirection: Axis.horizontal,
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index){
                                          return MaterialButton(
                                            onPressed: () {
                                              setState(() {
                                                currentTime = index;
                                              });
                                            },
                                            child: buildTiming(index),
                                          );
                                        },
                                      ),
                                    ),
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
                                          return TextButton(
                                            onPressed: () async {

                                              // UPDATED NEW REQUEST AMOUNT
                                              Navigator.pushNamed(context, '/policies-page');

                                              await dataBaseService.updateSchedulingToWaitingUserApproval(
                                                currentInsuranceCompany,
                                                globalCurrentPolicyIndex,
                                              );

                                              if(globalVehiclesRequested[globalCurrentPolicyIndex].isEmpty){

                                                print("AMOUNT OF VEHICLES IS ZEROOOOOOOOOOOOOOOOOOOOOOO");

                                                int idx = 0;
                                                while(idx <= snapshot.data[1]['total-policy-amount']){
                                                  if(globalNewNames[globalCurrentPolicyIndex] == snapshot.data[1]['$idx']['policy-holder-name']
                                                      && globalPolicyVehicleIndexes[globalCurrentPolicyIndex] == snapshot.data[1]['$idx']['vehicle-index']
                                                  ){


                                                    if(currentInsuranceCompany == snapshot.data[1]['$idx']['intended-company']){
                                                      print("REACHED REQUESTS DOC 1");
                                                      await dataBaseService.requestsDocUpdateSchedulingToWaitingUserApproval(
                                                        idx,
                                                        timings[currentTime],
                                                        timePicked.day,
                                                        timePicked.month,
                                                        timePicked.year,
                                                        globalCurrentPolicyIndex,
                                                        signInAsBroker?currentBrokerCompany:currentInsuranceCompany,
                                                        signInAsBroker,
                                                      );
                                                    }
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
                                                      if(currentInsuranceCompany == snapshot.data[1]['$idx']['intended-company']){
                                                        print("REACHED REQUESTS DOC 1");
                                                        await dataBaseService.requestsDocUpdateSchedulingToWaitingUserApproval(
                                                          idx,
                                                          timings[currentTime],
                                                          timePicked.day,
                                                          timePicked.month,
                                                          timePicked.year,
                                                          globalCurrentPolicyIndex,
                                                          signInAsBroker?currentBrokerCompany:currentInsuranceCompany,
                                                          signInAsBroker,
                                                        );
                                                      }
                                                    }
                                                  }
                                                  idx++;
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: 200,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Text("Send Schedule link", style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                      return const Text("Please wait");
                                    },

                                  ),


                                ],
                              ),
                            ),
                          );
                        }
                        else{
                          Container();
                        }

                    }
                  }
                  return const Text("");
                },
              ),

              FutureBuilder(
                future: Future.wait([currentPolicyRequest(),requestsDocCurrentPolicyRequest()]),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else{
                      if(signInAsBroker){

                      }
                      else{
                        if(snapshot.data[0]['$globalCurrentPolicyIndex']['status-underwriting'] == true){
                          return Positioned(
                            top: 300,
                            left: 500,
                            child: Container(
                              width: 350,
                              height: 400,
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
                              child: Column(
                                children: [
                                  Text("Underwriter Decision", style: TextStyle(
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 30,),
                                  TextField(
                                    decoration: InputDecoration(
                                      label: Text("Comments"),
                                    ),
                                    controller: underwriterController,
                                  ),
                                  SizedBox(height: 30,),
                                  Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextButton(
                                      onPressed: (){
                                        setState(() {
                                          if(changePolicyPremium){
                                            changePolicyPremium = false;
                                          }
                                          else{
                                            changePolicyPremium = true;
                                          }
                                        });
                                      },
                                      child: Text(changePolicyPremium?"Default Policy Premium":"Change Policy Premium", style: TextStyle(
                                        color: Colors.white,
                                      ),),
                                    ),
                                  ),
                                  SizedBox(height: 30,),
                                  TextField(
                                    enabled: changePolicyPremium,
                                    decoration: InputDecoration(
                                      label: Text("Policy Premium"),
                                    ),
                                    controller: policyPremiumController,
                                  ),
                                  SizedBox(height: 60,),
                                  Row(
                                    children: [
                                      SizedBox(width: 60,),
                                      Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: TextButton(
                                          onPressed: () async {

                                            Navigator.pushNamed(context, '/policies-page');
                                            await dataBaseService.updateUnderwritingToWaitingICApproval(
                                              currentInsuranceCompany,
                                              globalCurrentPolicyIndex,
                                              signInAsBroker,
                                            );

                                            if(globalVehiclesRequested[globalCurrentPolicyIndex].isEmpty){
                                              int idx = 0;
                                              while(idx <= snapshot.data[1]['total-policy-amount']){
                                                if(globalNewNames[globalCurrentPolicyIndex] == snapshot.data[1]['$idx']['policy-holder-name']
                                                    && currentInsuranceCompany == snapshot.data[1]['$idx']['intended-company']
                                                    && globalPolicyVehicleIndexes[globalCurrentPolicyIndex] == snapshot.data[1]['$idx']['vehicle-index']
                                                ){
                                                  print("REACHED REQUESTS DOC");
                                                  //int currentPolicyAmount = int.parse(policyPremiumController.text);
                                                  if(changePolicyPremium){
                                                    print("REACHED WHERE THERE HAS BEEN CHANGED");
                                                    await dataBaseService.requestsDocUpdateUnderwritingToWaitingIcApproval(idx, policyPremiumController.text);
                                                  }
                                                  else{
                                                    print("REACHED WHERE NO AMOUNT HAS CHANGED");
                                                    await dataBaseService.requestsDocUpdateUnderwritingToWaitingIcApprovalNoChangeInAmount(idx);
                                                  }
                                                }
                                                idx++;
                                              }
                                            }
                                            else{
                                              int idx = 0;
                                              while(idx <= snapshot.data[1]['total-policy-amount']){
                                                if(globalNewNames[globalCurrentPolicyIndex] == snapshot.data[1]['$idx']['policy-holder-name']
                                                    && snapshot.data[1]['$idx']['vehicle-amount'] == globalVehiclesRequested[globalCurrentPolicyIndex].length
                                                && currentInsuranceCompany == snapshot.data[1]['$idx']['intended-company']){

                                                  bool isPolicy = true;
                                                  int vehicleIdx = 0;
                                                  while(vehicleIdx < globalVehiclesRequested[globalCurrentPolicyIndex].length){
                                                    if(snapshot.data[1]['$idx']['vehicles']['$vehicleIdx']['vehicle-index'] != globalVehiclesRequested[globalCurrentPolicyIndex][vehicleIdx].currentIndex){
                                                      isPolicy = false;
                                                    }
                                                    vehicleIdx++;
                                                  }

                                                  if(isPolicy){
                                                      if(changePolicyPremium){
                                                        await dataBaseService.requestsDocUpdateUnderwritingToWaitingIcApproval(idx,policyPremiumController.text);
                                                      }
                                                      else{
                                                        await dataBaseService.requestsDocUpdateUnderwritingToWaitingIcApprovalNoChangeInAmount(idx);
                                                      }
                                                  }
                                                }
                                                idx++;
                                              }
                                            }
                                          },
                                          child: Text("Approve", style: TextStyle(
                                            color: Colors.white,
                                            //fontWeight: FontWeight.bold,
                                          ),),
                                        ),
                                      ),
                                      SizedBox(width: 60,),
                                      Container(
                                        width: 80,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: TextButton(
                                          onPressed: () {

                                          },
                                          child: Text("Decline", style: TextStyle(
                                            color: Colors.white,
                                            //fontWeight: FontWeight.bold,
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
                        else if(snapshot.data[0]['$globalCurrentPolicyIndex']['status-waiting-ic-approval'] == true){
                          return Positioned(
                            top: 300,
                            left: 500,
                            child: Container(
                              width: 300,
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
                              child: Column(
                                children: [
                                  Text("Underwriter Decision", style: TextStyle(
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 60,),
                                  Text("Approved", style: TextStyle(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                  ),),
                                ],
                              ),
                            ),
                          );
                        }
                        else{
                          return Positioned(
                            top: 300,
                            left: 500,
                            child: Container(
                              width: 300,
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
                              child: Column(
                                children: [
                                  Text("Underwriter Decision", style: TextStyle(
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 60,),
                                  Text("Waiting for inspection", style: TextStyle(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.bold,
                                  ),),
                                ],
                              ),
                            ),
                          );
                        }
                      }
                    }
                  }
                  return const Text("");
                },
              ),


              //PROBLEM HERE
              FutureBuilder(
                future: currentPolicyRequest(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){
                        if(snapshot.data['$globalCurrentPolicyIndex']['status-waiting-ic-approval'] == true){
                          return Positioned(
                            top: 100,
                            left: 900,
                            child: Column(
                              children: [
                                FutureBuilder(
                                  future: Future.wait([currentPolicyRequest(),policiesApprovedData(), requestsDocCurrentPolicyRequest(),brokerCurrentPolicyRequest(currentBrokerCompany)]),
                                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                    if(snapshot.connectionState == ConnectionState.done){
                                      if (snapshot.hasError) {
                                        return const Center(
                                          child: Text('there is an error'),
                                        );
                                      }
                                      else if(snapshot.hasData){

                                        return Container(
                                          width: 250,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: TextButton(
                                            onPressed: () async {

                                              Navigator.pushNamed(context, '/policies-page');



                                              // UPDATES INSURANCE COMPANY STATUS
                                              await dataBaseService.updateWaitingICApprovalToApprovedRequest(
                                                currentInsuranceCompany,
                                                globalCurrentPolicyIndex,
                                                signInAsBroker,
                                              );

                                              await dataBaseService.updatePendingPoliciesAmount(
                                                currentInsuranceCompany,
                                                snapshot.data[0]['total-pending-policies']+1,
                                                signInAsBroker,
                                              );

                                              int policyAmount = 0;

                                              int index = 0;
                                              while(index < firstCompanies.length){
                                                if(currentInsuranceCompany == firstCompanies[index].title){
                                                  policyAmount = firstCompanies[index].price;
                                                }
                                                index++;
                                              }

                                              index = 0;
                                              while(index < secondCompanies.length){
                                                if(currentInsuranceCompany == secondCompanies[index].title){
                                                  policyAmount = secondCompanies[index].price;
                                                }
                                                index++;
                                              }

                                              if(globalVehiclesRequested[globalCurrentPolicyIndex].isEmpty){
                                                await dataBaseService.updateApprovalsNew(
                                                  signInAsBroker?currentBrokerCompany:'none',
                                                  globalPolicyVehicleMakes[globalCurrentPolicyIndex],
                                                  globalPolicyVehicleModels[globalCurrentPolicyIndex],
                                                  globalPolicyVehicleIndexes[globalCurrentPolicyIndex],
                                                  currentInsuranceCompany,
                                                  globalNewNames[globalCurrentPolicyIndex],
                                                  policyAmount,
                                                  snapshot.data[1]['total-amount-approved']+1,
                                                );
                                              }
                                              else{
                                                int vehicleIndex = 0;

                                                while(vehicleIndex < globalVehiclesRequested[globalCurrentPolicyIndex].length){
                                                  await dataBaseService.updateApprovalsNewVehicles(
                                                    globalVehiclesRequested[globalCurrentPolicyIndex].length,
                                                    vehicleIndex,
                                                    signInAsBroker?currentBrokerCompany:'none',
                                                    globalVehiclesRequested[globalCurrentPolicyIndex][vehicleIndex].vehicleMake,
                                                    globalVehiclesRequested[globalCurrentPolicyIndex][vehicleIndex].vehicleModel,
                                                    globalVehiclesRequested[globalCurrentPolicyIndex][vehicleIndex].currentIndex,
                                                    currentInsuranceCompany,
                                                    globalNewNames[globalCurrentPolicyIndex],
                                                    policyAmount,
                                                    snapshot.data[1]['total-amount-approved']+1,
                                                  );
                                                  vehicleIndex++;
                                                }

                                              }


                                              currentPoliciesApproved++;

                                              if(globalVehiclesRequested[globalCurrentPolicyIndex].isEmpty){
                                                int idx = 0;
                                                while(idx <= snapshot.data[2]['total-policy-amount']){
                                                  if(globalNewNames[globalCurrentPolicyIndex] == snapshot.data[2]['$idx']['policy-holder-name']
                                                      && currentInsuranceCompany == snapshot.data[2]['$idx']['intended-company']
                                                      && globalPolicyVehicleIndexes[globalCurrentPolicyIndex] == snapshot.data[2]['$idx']['vehicle-index']
                                                  ){
                                                    print("REACHED REQUESTS DOC");

                                                    setState(() {
                                                      currentBrokerCompany = snapshot.data[2]['$idx']['broker-name'];
                                                    });

                                                    await dataBaseService.requestsDocUpdateWaitingICApprovalToApprovedRequest(idx);
                                                    //await dataBaseService.updatingAmount(idx, policyAmount);
                                                    await dataBaseService.updatePendingPoliciesAmount(
                                                      snapshot.data[2]['$idx']['broker-name'],
                                                      snapshot.data[3]['total-pending-policies']+1,
                                                      signInAsBroker,
                                                    );
                                                  }
                                                  idx++;
                                                }
                                              }
                                              else{
                                                print("REACHED THIS ELSE STATEMENTSDFSDFDSFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
                                                int idx = 0;
                                                while(idx <= snapshot.data[2]['total-policy-amount']){
                                                  if(globalNewNames[globalCurrentPolicyIndex] == snapshot.data[2]['$idx']['policy-holder-name']
                                                      && snapshot.data[2]['$idx']['vehicle-amount'] == globalVehiclesRequested[globalCurrentPolicyIndex].length){

                                                    print("VEHICLE AMOUNT IS EQUAL AND REACHED");
                                                    bool isPolicy = true;
                                                    int vehicleIdx = 0;
                                                    while(vehicleIdx < globalVehiclesRequested[globalCurrentPolicyIndex].length){
                                                      if(snapshot.data[2]['$idx']['vehicles']['$vehicleIdx']['vehicle-index'] != globalVehiclesRequested[globalCurrentPolicyIndex][vehicleIdx].currentIndex){
                                                        isPolicy = false;
                                                      }
                                                      vehicleIdx++;
                                                    }

                                                    if(isPolicy){
                                                      if(currentInsuranceCompany == snapshot.data[2]['$idx']['intended-company']){
                                                        print("REACHED REQUESTS DOC FINALLLLLLLLLLLLLLLLLLLLLLLLL");

                                                        setState(() {
                                                          currentBrokerCompany = snapshot.data[2]['$idx']['broker-name'];
                                                        });

                                                        await dataBaseService.requestsDocUpdateWaitingICApprovalToApprovedRequest(idx);
                                                        //await dataBaseService.updatingAmount(idx, policyAmount);
                                                        await dataBaseService.updatePendingPoliciesAmount(
                                                          snapshot.data[2]['$idx']['broker-name'],
                                                          snapshot.data[3]['total-pending-policies']+1,
                                                          signInAsBroker,
                                                        );
                                                      }
                                                    }
                                                  }
                                                  idx++;
                                                }
                                              }




                                            },
                                            child: const Text("Approve Policy Request",style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                          ),
                                        );


                                      }
                                    }
                                    return const Text("");
                                  },
                                ),
                                SizedBox(height: 30,),
                                Container(
                                  width: 250,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: (){

                                    },
                                    child: const Text("Decline Policy Request", style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  ),
                                ),

                              ],
                            ),
                          );
                        }
                        else{
                          return Container();
                        }

                    }
                  }
                  return const Text("");
                },

              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget buildTiming(int idx){
    return Container(
      width: 130,
      height: 100,
      margin: EdgeInsets.only(left: 20, top: 10),
      decoration: BoxDecoration(
        color: idx == currentTime?Colors.blue:Color(0xffEEEEEE),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 2, left:5),
            child: Icon(
              Icons.access_time,
              color: Colors.black,
              size: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 2, right:5),
            child: Text("${timings[idx]}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVehicleExtraInfo(){

    if(globalVehiclesRequested[globalCurrentPolicyIndex].length == 0){
      if(globalVehicleTypes[globalCurrentPolicyIndex] == 'truck'){
        return Text("Vehicle Weight: ${globalVehicleWeights[globalCurrentPolicyIndex]}", style: TextStyle(
          fontSize: 15,),);
      }
      else if(globalVehicleTypes[globalCurrentPolicyIndex] == 'bus'){
        return Text("Number of seats: ${globalNumberOfSeats[globalCurrentPolicyIndex]}", style: TextStyle(
          fontSize: 15,),);
      }
      else{
        return Container();
      }
    }
    else{
      return Container();
    }

  }


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
              Positioned(
                top: 170,
                left: 10,
                child: buildVehicleExtraInfo(),
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
                    color: Colors.blue,
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
