import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newest_insurance/services/database.dart';
import '../constants.dart';


class ServiceCenterDashboard extends StatefulWidget {
  const ServiceCenterDashboard({Key? key}) : super(key: key);

  @override
  _ServiceCenterDashboardState createState() => _ServiceCenterDashboardState();
}

class _ServiceCenterDashboardState extends State<ServiceCenterDashboard> {

  Future<Map<String, dynamic>?> centersRequests() async {
    return (await FirebaseFirestore.instance.collection('centers-requests').
    doc('requests').get()).data();
  }

  List<Map> selectedComps = [];
  bool companySelected = false;
  Map currentlySelected = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$currentServiceOrWorkshop Dashboard"),
        backgroundColor: mainColor,
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
          width: 1500,
          height: 1500,
          child: Stack(
            children: [

              Positioned(
                left: 0,
                //right: 0,
                child: Container(
                  width: 210,
                  height: 1000,
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
                            Navigator.pushNamed(context, '/service-center-dashboard');
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              /*
              Positioned(
                top: 10,
                left: 250,
                child: Container(
                  height: 200,
                  width: 300,
                  child: Row(
                    children: [
                      Expanded(
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
                                          text: "Total Requests\n",
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.black)),
                                      TextSpan(
                                          text: "2",
                                          style:
                                          TextStyle(fontSize: 40, color: Colors.black)),
                                    ])),
                                //  Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              */

              FutureBuilder(
                future: centersRequests(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){

                      List<int> claimNumbers = [];
                      List<String> claimRequesterNames= [];
                      List<String> claimRequesterDateOfBirths = [];
                      List<String> claimRequesterIDs= [];
                      List<String> claimRequesterMobiles= [];
                      List<String> claimRequesterAddresses= [];
                      List<String> claimRequesterEmails= [];
                      List<String> claimRequesterVehicleMakes= [];
                      List<String> claimRequesterVehicleModels = [];
                      List<String> claimRequesterProductionYears = [];
                      List<String> claimRequesterVehicleValues= [];
                      List<String> claimRequesterVehicleLicenseId = [];
                      List<String> claimRequesterDrivingLicenses= [];
                      List<String> claimRequesterIntendedCompanies= [];
                      List<int> currentIndexes= [];
                      List<String> claimRequesterAccidentLocations= [];
                      List<String> claimRequesterAccidentInfo= [];
                      List<bool> claimsApprovedByIC= [];
                      List<bool> claimsApprovedByUser= [];
                      List<int> claimNumberUsers = [];

                      int idx = 0;
                      while(idx <= snapshot.data[currentServiceOrWorkshop]['total-requests']){
                        claimNumberUsers.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-number-user']!);
                        claimNumbers.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-number']!);
                        currentIndexes.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['current-request']!);
                        claimRequesterAccidentInfo.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-accident-info']!.toString());
                        claimRequesterAccidentLocations.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-accident-location']!.toString());
                        claimRequesterAddresses.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-address']!.toString());
                        claimRequesterDateOfBirths.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-date-of-birth']!.toString());
                        claimRequesterEmails.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-email']!.toString());
                        claimRequesterIDs.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-id']!.toString());
                        claimRequesterMobiles.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-mobile']!.toString());
                        claimRequesterNames.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-name']!.toString());
                        claimRequesterVehicleLicenseId.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-vehicle-car-license-id']!.toString());
                        claimRequesterDrivingLicenses.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-vehicle-driving-license-id']!.toString());
                        claimRequesterVehicleMakes.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-vehicle-make']!.toString());
                        claimRequesterVehicleModels.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-vehicle-model']!.toString());
                        claimRequesterProductionYears.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-vehicle-production-year']!.toString());
                        claimRequesterVehicleValues.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['claim-requester-vehicle-value']!.toString());
                        claimRequesterIntendedCompanies.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['intended-insurance-company']!.toString());
                        claimsApprovedByIC.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['status-ic-approved']!);
                        claimsApprovedByUser.insert(idx, snapshot.data[currentServiceOrWorkshop]['$idx']['status-requester-approved']!);
                        idx++;
                      }



                      return Positioned(
                        top: 20,
                        left: 220,
                        child: Container(
                          width: 1000,
                          height: 1000,
                          child: buildDataTable(
                            centersRequests(),
                            claimNumbers,
                            claimRequesterNames,
                            claimRequesterDateOfBirths,
                            claimRequesterIDs,
                            claimRequesterMobiles,
                            claimRequesterAddresses,
                            claimRequesterEmails,
                            claimRequesterVehicleMakes,
                            claimRequesterVehicleModels ,
                            claimRequesterProductionYears ,
                            claimRequesterVehicleValues,
                            claimRequesterVehicleLicenseId ,
                            claimRequesterDrivingLicenses,
                            claimRequesterIntendedCompanies,
                            currentIndexes,
                            claimRequesterAccidentLocations,
                            claimRequesterAccidentInfo,
                            claimsApprovedByIC,
                            claimsApprovedByUser,
                              claimNumberUsers,
                          ),
                        ),
                      );
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

  Widget buildDataTable(

      Future<Map<String, dynamic>?> func,
      List<int> claimNumbers,
      List<String> claimRequesterNames,
      List<String> claimRequesterDateOfBirths,
      List<String> claimRequesterIDs,
      List<String> claimRequesterMobiles,
      List<String> claimRequesterAddresses,
      List<String> claimRequesterEmails,
      List<String> claimRequesterVehicleMakes,
      List<String> claimRequesterVehicleModels ,
      List<String> claimRequesterProductionYears ,
      List<String> claimRequesterVehicleValues,
      List<String> claimRequesterVehicleLicenseId ,
      List<String> claimRequesterDrivingLicenses,
      List<String> claimRequesterIntendedCompanies,
      List<int> currentIndexes,
      List<String> claimRequesterAccidentLocations,
      List<String> claimRequesterAccidentInfo,
       List<bool> claimsApprovedByIC,
       List<bool> claimsApprovedByUser,
      List<int> claimNumberUsers,
      ){

    final columns = ['Client Name', 'Vehicle Make', 'Vehicle Model', 'Driving License', 'Status'];

    List<Map> myMap = [];

    int currentClaimIndex = 0;
    while(currentClaimIndex < claimRequesterNames.length){
      if(claimsApprovedByUser[currentClaimIndex] == false){
        Map newMap = Map();
        newMap['claim-requester-vehicle-make'] = claimRequesterVehicleMakes[currentClaimIndex];
        newMap['claim-requester-vehicle-model'] = claimRequesterVehicleModels[currentClaimIndex];
        newMap['claim-requester-name'] = claimRequesterNames[currentClaimIndex];
        newMap['claim-requester-vehicle-license-id'] = claimRequesterVehicleLicenseId[currentClaimIndex];
        newMap['claim-number'] = claimNumbers[currentClaimIndex];
        newMap['current-index'] = currentIndexes[currentClaimIndex];
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
        centersRequests(),
        claimNumbers,
        claimRequesterNames,
        claimRequesterDateOfBirths,
        claimRequesterIDs,
        claimRequesterMobiles,
        claimRequesterAddresses,
        claimRequesterEmails,
        claimRequesterVehicleMakes,
        claimRequesterVehicleModels ,
        claimRequesterProductionYears ,
        claimRequesterVehicleValues,
        claimRequesterVehicleLicenseId ,
        claimRequesterDrivingLicenses,
        claimRequesterIntendedCompanies,
        currentIndexes,
        claimRequesterAccidentLocations,
        claimRequesterAccidentInfo,
        claimsApprovedByIC,
        claimsApprovedByUser,
          claimNumberUsers,
      ),
    );
  }

  List<DataRow> getRows(
      List<Map> companyList,
      Future<Map<String, dynamic>?> func,
      claimNumbers,
      claimRequesterNames,
      claimRequesterDateOfBirths,
      claimRequesterIDs,
      claimRequesterMobiles,
      claimRequesterAddresses,
      claimRequesterEmails,
      claimRequesterVehicleMakes,
      claimRequesterVehicleModels ,
      claimRequesterProductionYears ,
      claimRequesterVehicleValues,
      claimRequesterVehicleLicenseId ,
      claimRequesterDrivingLicenses,
      claimRequesterIntendedCompanies,
      currentIndexes,
      claimRequesterAccidentLocations,
      claimRequesterAccidentInfo,
      claimsApprovedByIC,
      claimsApprovedByUser,
      claimNumberUsers,
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
            width: 150,
            child: Text("${current['claim-requester-vehicle-make']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),
        ),

        DataCell(
          Container(
            width: 150,
            child: Text("${current['claim-requester-vehicle-model']}",style: TextStyle(
              fontSize: 18,
            ),),
          ),

        ),
        DataCell(
          Container(
            width: 150,
            child: Text("${current['claim-requester-vehicle-license-id']}",style: TextStyle(
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
                      onPressed: (){
                          setState(() {

                            invoiceItems = [];
                            invoiceFees = [];

                            globalCurrentClaimIndex = current['current-index'];

                            globalClaimNumbers = claimNumbers;
                            globalClaimAccidentInfo = claimRequesterAccidentInfo;
                            globalClaimAccidentLocations = claimRequesterAccidentLocations;
                            globalClaimAddresses = claimRequesterAddresses;
                            globalClaimDateOfBirths = claimRequesterDateOfBirths;
                            globalClaimEmails = claimRequesterEmails;
                            globalClaimIds = claimRequesterIDs;
                            globalClaimMobiles = claimRequesterMobiles;
                            globalClaimRequesterNames = claimRequesterNames;
                            globalClaimVehicleLicenses = claimRequesterVehicleLicenseId;
                            globalClaimVehicleMakes = claimRequesterVehicleMakes;
                            globalClaimVehicleModels = claimRequesterVehicleModels;
                            globalClaimVehicleProductionYears = claimRequesterProductionYears;
                            globalClaimVehicleValues = claimRequesterVehicleValues;
                            globalClaimIntendedInsuranceCompanies = claimRequesterIntendedCompanies;
                            globalClaimApprovedByIC = claimsApprovedByIC;
                            globalClaimApprovedByUser = claimsApprovedByUser;
                            globalCurrentIndexes = currentIndexes;
                            globalClaimNumberUsers = claimNumberUsers;
                          });
                          Navigator.pushNamed(context, '/service-center-details');
                      },
                      child: Text(
                        snapshot.data[currentServiceOrWorkshop]['${current['current-index']}']['status-scheduling']?"Scheduling":
                        snapshot.data[currentServiceOrWorkshop]['${current['current-index']}']['status-waiting-ic-approval']?"Waiting Approval":
                        snapshot.data[currentServiceOrWorkshop]['${current['current-index']}']['status-ic-approved']?"Waiting Requester Confirmation":
                        snapshot.data[currentServiceOrWorkshop]['${current['current-index']}']['status-requester-approved']?"Approved":
                        "Refused"
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
