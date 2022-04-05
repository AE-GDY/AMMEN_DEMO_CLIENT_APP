// IM HERE!
import 'package:flutter/material.dart';
import 'package:newest_insurance/services/database.dart';

import '../constants.dart';



class CenterClaimDetails extends StatefulWidget {
  const CenterClaimDetails({Key? key}) : super(key: key);

  @override
  _CenterClaimDetailsState createState() => _CenterClaimDetailsState();
}

class _CenterClaimDetailsState extends State<CenterClaimDetails> {

  TextEditingController invoiceItemController = TextEditingController();
  TextEditingController invoiceFeeController = TextEditingController();

  DataBaseService dataBaseService = DataBaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Claim Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 1500,
          height: 1000,
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
                        child: Text("National ID: ${globalClaimIds[globalCurrentClaimIndex]}", style: TextStyle(
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
              Positioned(
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
                        child: Text("Plate Number: ${globalClaimVehicleLicenses[globalCurrentClaimIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 300,
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
                        left: 110,
                        child: Text("Vehicle Attachments", style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 1000,
                child: Container(
                  width: 200,
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
                      Expanded(
                        child: ListView.builder(
                            itemCount: invoiceItems.length,
                            itemBuilder: (context, index){
                              return Container(
                                margin: EdgeInsets.all(10),
                                child: Text("${invoiceItems[index]} : ${invoiceFees[index]} EGP", style: TextStyle(
                                  fontSize: 18,
                                ),),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 60,
                left: 550,
                child: Container(
                  width: 300,
                  height: 100,
                  child: TextField(
                    controller: invoiceItemController,
                    decoration: InputDecoration(
                      hintText: "Item",
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 130,
                left: 550,
                child: Container(
                  width: 300,
                  height: 100,
                  child: TextField(
                    controller: invoiceFeeController,
                    decoration: InputDecoration(
                      hintText: "Fee",
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 200,
                left: 670,
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: (){

                    },
                    child: Center(
                      child: Text("Attach Invoice", style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 550,
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: (){
                      setState(() {
                        invoiceItems.add(invoiceItemController.text);
                        invoiceFees.add(invoiceFeeController.text);
                      });
                    },
                    child: Center(
                      child: Text("Add Fee", style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 791,
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () async {
                        await dataBaseService.updateClaimsRequestsData(
                          globalClaimNumberUsers[globalCurrentClaimIndex],
                          globalClaimIntendedInsuranceCompanies[globalCurrentClaimIndex],
                          globalClaimNumbers[globalCurrentClaimIndex],
                          invoiceItems,
                          invoiceFees,
                        );

                        await dataBaseService.updateClaimsRequestsDataUser(
                          globalClaimNumberUsers[globalCurrentClaimIndex],
                          invoiceItems,
                          invoiceFees,
                        );


                        Navigator.pushNamed(context, '/service-center-dashboard');

                    },
                    child: Center(
                      child: Text("Send Invoice", style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
