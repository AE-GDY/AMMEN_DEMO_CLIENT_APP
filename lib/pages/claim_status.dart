import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newest_insurance/services/database.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class ClaimStatus extends StatefulWidget {

  double currentHeight = 200.0;
  ClaimStatus({Key? key}) : super(key: key);

  @override
  _ClaimStatusState createState() => _ClaimStatusState();
}

class _ClaimStatusState extends State<ClaimStatus> {

  final GlobalKey _key = GlobalKey();
  DataBaseService dataBaseService = DataBaseService();
  bool isChecked = false;
  bool isTotalLoss = false;
  int currentTime = 0;


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

  Future<Map<String, dynamic>?> claimsRequestsData() async {
    return (await FirebaseFirestore.instance.collection('users-claim-requests').
    doc('claims').get()).data();
  }

  Future<Map<String, dynamic>?> brokerClaimsRequestsData() async {
    return (await FirebaseFirestore.instance.collection('users-claim-requests-broker').
    doc('claims').get()).data();
  }

  Future<Map<String, dynamic>?> claimsApprovedData() async {
    return (await FirebaseFirestore.instance.collection('users-claim-approvals').
    doc('approvals').get()).data();
  }

  @override
  Widget build(BuildContext context) {

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text("Claim Status"),
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
                        child: Text("Name: ${globalClaimRequesterNames[globalCurrentClaimIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 80,
                        left: 10,
                        child: Text("Date of Birth: ${globalClaimDateOfBirths[globalCurrentClaimIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 110,
                        left: 10,
                        child: Text("Mobile: ${globalClaimMobiles[globalCurrentClaimIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 140,
                        left: 10,
                        child: Text("Email: ${globalClaimEmails[globalCurrentClaimIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ],
                  ),
                ),
              ),

              buildUserComment(),

              Positioned(
                top: 270,
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
                        child: Text("Vehicle Make: ${globalClaimVehicleMakes[globalCurrentClaimIndex]} ", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 80,
                        left: 10,
                        child: Text("Vehicle Model: ${globalClaimVehicleModels[globalCurrentClaimIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 110,
                        left: 10,
                        child: Text("Production Year: ${globalClaimVehicleProductionYears[globalCurrentClaimIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 140,
                        left: 10,
                        child: Text("Vehicle Number: ${globalClaimVehicleLicenses[globalCurrentClaimIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 490,
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
                        child: Text("Accident Info", style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 50,
                        left: 10,
                        child: Text("Accident Location: ${globalClaimAccidentLocations[globalCurrentClaimIndex]} ", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 80,
                        left: 10,
                        child: Text("Accident Info: ${globalClaimAccidentInfo[globalCurrentClaimIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 110,
                        left: 10,
                        child: Text("Vehicle current status: Not Fixed", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 140,
                        left: 10,
                        child: Text("Fixing Place: ${globalClaimCenters[globalCurrentClaimIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ],
                  ),
                ),
              ),



              FutureBuilder(
                future: signInAsBroker?brokerClaimsRequestsData():claimsRequestsData(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){

                      if(snapshot.data[signInAsBroker?currentBrokerCompany:currentInsuranceCompany]['$globalCurrentClaimIndex']['status-waiting-ic-approval'] == false){
                        return Positioned(
                          top: 50,
                          left: 500,
                          child: Container(
                            height: 450,
                            width: 400,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Column(
                              children: [

                                Text("Scheduling Inspection", style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),),

                                SizedBox(height: 10,),

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
                                        color: mainColor,
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
                                      //  print(timePicked.day);
                                    },
                                    onFormatChanged: (CalendarFormat _format){
                                      setState((){
                                        format = _format;
                                        // print(format.toString());
                                        setState(() {
                                          if(format == CalendarFormat.week){
                                            widget.currentHeight = 200;
                                          }
                                          else if(format == CalendarFormat.twoWeeks){
                                            widget.currentHeight = 350;
                                          }
                                          else if(format == CalendarFormat.month){
                                            widget.currentHeight = 400;
                                          }
                                        });
                                        //   print(widget._key!.currentContext!.size!.height);
                                      });
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


                                Container(
                                  width: 170,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: snapshot.data[signInAsBroker?currentBrokerCompany:currentInsuranceCompany]['$globalCurrentClaimIndex']['status-waiting-ic-approval']?Colors.white:mainColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      if(snapshot.data[signInAsBroker?currentBrokerCompany:currentInsuranceCompany]['$globalCurrentClaimIndex']['status-waiting-ic-approval'] == false){
                                        await dataBaseService.claimUpdateSchedulingToWaitingIcApproval(
                                            signInAsBroker?currentBrokerCompany:currentInsuranceCompany,
                                            globalCurrentClaimIndex,
                                            signInAsBroker
                                        );

                                        await dataBaseService.updateClaimsRequestsDataUserWaitingICApproval(globalClaimNumberUsers[globalCurrentClaimIndex]);

                                        Navigator.pushNamed(context, '/claims-page');
                                      }
                                    },
                                    child: Text(snapshot.data[signInAsBroker?currentBrokerCompany:currentInsuranceCompany]['$globalCurrentClaimIndex']['status-waiting-ic-approval'] == false?
                                    "Send Inspection Date":"", style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Container();
                    }
                  }
                  return const Text("");
                },

              ),

             /*
              Positioned(
                top: 50,
                left: 800,
                child: Container(
                  width: 300,
                  height: 300,
                  child: TextButton(
                    onPressed:(){},
                      child: const Text("Fixing Report"),),
                ),
              ),
             */

              Positioned(
                top: 50,
                left: 950,
                child: Container(
                  width: 250,
                  height: 300,
                //  padding: const EdgeInsets.all(10),
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
                      SizedBox(height: 20,),
                      Text("Fixing Fees Details", style: TextStyle(
                        fontSize: 20,
                      ),),
                      SizedBox(height: 20,),
                      Expanded(
                        child: ListView.builder(
                            itemCount: globalInvoiceItems[globalCurrentClaimIndex].length,
                            itemBuilder: (context,index){
                              return Container(
                                margin: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    buildCheckBox(getColor, index),
                                    Text("${globalInvoiceItems[globalCurrentClaimIndex][index]}: ${globalInvoiceFees[globalCurrentClaimIndex][index]} EGP",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                        }),
                      ),
                      SizedBox(height: 10,),
                      Text("Overall Fees: $overallFees EGP", style: TextStyle(
                        fontSize: 20,
                      ),),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: signInAsBroker?brokerClaimsRequestsData():claimsRequestsData(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){
                      if(snapshot.data[signInAsBroker?currentBrokerCompany:currentInsuranceCompany]['$globalCurrentClaimIndex']['status-waiting-ic-approval'] == true){
                        return Positioned(
                          top: 490,
                          left: 500,
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
                            child:  Column(
                              children: [
                                Text("Claim Settlement", style: TextStyle(
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  ),),
                                SizedBox(height: 10,),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "Comments",
                                  ),
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Text("Total Loss: ", style: TextStyle(
                                      fontSize: 18,
                                    ),),
                                    SizedBox(width: 20,),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: isTotalLoss?Colors.blue:Colors.grey[300],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: 100,
                                      height: 40,
                                      child: TextButton(
                                        onPressed: (){
                                          setState(() {
                                            isTotalLoss = !isTotalLoss;
                                          });
                                        },
                                        child: Text("Yes", style: TextStyle(
                                          color: Colors.white,
                                        ),),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: isTotalLoss?Colors.grey[300]:Colors.blue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: 100,
                                      height: 40,
                                      child: TextButton(
                                        onPressed: (){
                                          setState(() {
                                            isTotalLoss = !isTotalLoss;
                                          });
                                        },
                                        child: Text("No", style: TextStyle(
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
                      else{
                        return Positioned(
                          top: 490,
                          left: 500,
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
                                  left: 120,
                                  child: Text("Claim Settlement", style: TextStyle(
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  ),),
                                ),
                                Positioned(
                                  top: 100,
                                  left: 90,
                                  child: Text("Waiting for schedule link", style: TextStyle(
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                  ),),
                                ),
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
                future: signInAsBroker?brokerClaimsRequestsData():claimsRequestsData(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){
                      if(snapshot.data[signInAsBroker?currentBrokerCompany:currentInsuranceCompany]['$globalCurrentClaimIndex']['status-waiting-ic-approval'] == true) {
                        return FutureBuilder(
                          future: claimsApprovedData(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              if(snapshot.hasError){
                                return const Text("There is an error");
                              }
                              else if(snapshot.hasData){
                                  return Positioned(
                                    top: 650,
                                    left: 1000,
                                    child: Container(
                                      height: 50,
                                      width: 200,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextButton(
                                        onPressed: () async {
                                          Navigator.pushNamed(context, '/claims-page');

                                          await dataBaseService.claimUpdateWaitingIcApprovalToIcApproved(
                                              signInAsBroker?currentBrokerCompany:currentInsuranceCompany,
                                              globalCurrentClaimIndex,
                                              signInAsBroker,
                                          );

                                          setState(() {
                                            snapshot.data['total-amount-approved']++;
                                          });

                                          await dataBaseService.claimUpdateApprovals(
                                            globalClaimNumbers[globalCurrentClaimIndex],
                                            globalClaimVehicleIndexes[globalCurrentClaimIndex],
                                            globalClaimVehicleMakes[globalCurrentClaimIndex],
                                            globalClaimVehicleModels[globalCurrentClaimIndex],
                                            signInAsBroker?currentBrokerCompany:currentInsuranceCompany,
                                            globalClaimRequesterNames[globalCurrentClaimIndex],
                                            "1800",
                                            snapshot.data['total-amount-approved'],
                                          );

                                          await dataBaseService.updateClaimsRequestsDataUserICApproved(
                                              isTotalLoss,
                                              globalClaimNumberUsers[globalCurrentClaimIndex],
                                              approvedFixesAmount,
                                              totalClientPay,
                                          );

                                        },
                                        child: Text("Confirm and Send", style: TextStyle(
                                          color: Colors.white,
                                        ),),
                                      ),
                                    ),
                                  );
                              }
                            }
                            return const Text("");
                          },
                        );
                      }
                    }
                  }
                  return const Text("");
                },
              ),
              buildFeesDetails(),
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
        color: idx == currentTime?mainColor:Color(0xffEEEEEE),
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

  Widget buildCheckBox(Color getColor(Set<MaterialState> states), int index){
    if(waitingIcApproval){
      return Checkbox(
        checkColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: invoiceItemsChecked[index],
        onChanged: (bool? value) {
          setState(() {
            invoiceItemsChecked[index] = value!;
            if(!invoiceItemsChecked[index]){

              invoiceItemsOnComp.remove(globalInvoiceItems[globalCurrentClaimIndex][index]);
              invoiceFeesOnComp.remove(globalInvoiceFees[globalCurrentClaimIndex][index]);

              int currentFee = int.parse(globalInvoiceFees[globalCurrentClaimIndex][index]);
              approvedFixesAmount -= currentFee;

              companyShareAmount = approvedFixesAmount * 0.8;
              clientDeductibleAmount = approvedFixesAmount * 0.2;
              outOfCoverageAmount = overallFees - approvedFixesAmount;
              totalClientPay = clientDeductibleAmount + outOfCoverageAmount;
            }
            else{

              invoiceItemsOnComp.add(globalInvoiceItems[globalCurrentClaimIndex][index]);
              invoiceFeesOnComp.add(globalInvoiceFees[globalCurrentClaimIndex][index]);

              int currentFee = int.parse(globalInvoiceFees[globalCurrentClaimIndex][index]);
              approvedFixesAmount += currentFee;

              companyShareAmount = approvedFixesAmount * 0.8;
              clientDeductibleAmount = approvedFixesAmount * 0.2;
              outOfCoverageAmount = overallFees - approvedFixesAmount;

              totalClientPay = clientDeductibleAmount + outOfCoverageAmount;
            }
            /*
            int idx2 = 0;
            while(idx2 < invoiceItemsOnComp.length){
              print("ITEMM: ${invoiceItemsOnComp[idx2]}");
              print("FEEEE: ${invoiceFeesOnComp[idx2]}");
              idx2++;
            }
            print("DONE");
            */

          });
        },
      );
    }
    else{
      return Container();
    }

  }

  Widget buildFeesDetails(){
    if(waitingIcApproval){
      return Positioned(
        top: 400,
        left: 950,
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
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text("Approved Fixes: $approvedFixesAmount", style: TextStyle(
                  fontSize: 20,
                ),),
                Text("Company Share: $companyShareAmount", style: TextStyle(
                  fontSize: 20,
                ),),
                Text("Client deductible: $clientDeductibleAmount", style: TextStyle(
                  fontSize: 20,
                ),),
                Text("Out of coverage: $outOfCoverageAmount", style: TextStyle(
                  fontSize: 20,
                ),),
                Text("Total client's payment: $totalClientPay", style: TextStyle(
                  fontSize: 20,
                ),),
              ],
            ),
          ),
        ),
      );
    }
    else{
      return Container();
    }
  }

  Widget buildUserComment(){
    if(globalUserComments[globalCurrentClaimIndex] != ''){
      print("THIS IS A COMMENT");
      return Positioned(
        top: 710,
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
                child: Text("Claim Requester Comment: ", style: TextStyle(
                  fontSize: 20,
                ),),
              ),
              Positioned(
                top: 40,
                left: 15,
                child: Text(globalUserComments[globalCurrentClaimIndex], style: TextStyle(
                  fontSize: 15,
                ),),
              ),
            ],
          ),
        ),
      );
    }
    else{
      print("NOT A COMMENT");
      return Container();
    }
  }


}
