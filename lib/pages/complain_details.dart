import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newest_insurance/services/database.dart';

import '../constants.dart';


class ComplainsDetails extends StatefulWidget {
  const ComplainsDetails({Key? key}) : super(key: key);

  @override
  _ComplainsDetailsState createState() => _ComplainsDetailsState();
}

class _ComplainsDetailsState extends State<ComplainsDetails> {


  Future<Map<String, dynamic>?> userComplains() async {
    return (await FirebaseFirestore.instance.collection('user-complains').
    doc("complains").get()).data();
  }

  Future<Map<String, dynamic>?> usersSignedUp() async {
    return (await FirebaseFirestore.instance.collection('users-signed-up').
    doc('users').get()).data();
  }


  DataBaseService dataBaseService = DataBaseService();

  TextEditingController messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complain Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
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
                        left: 55,
                        child: Text("Complain Requester information", style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 50,
                        left: 10,
                        child: Text("Name: ${globalComplainRequestersNames[globalCurrentComplainIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 80,
                        left: 10,
                        child: Text("National ID: ${globalComplainRequestersIDs[globalCurrentComplainIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 110,
                        left: 10,
                        child: Text("Driving License: ${globalComplainRequestersDrivingLicenses[globalCurrentComplainIndex]}", style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 140,
                        left: 10,
                        child: Text("Email: ${globalComplainRequestersEmails[globalCurrentComplainIndex]}", style: TextStyle(
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
                  child: Stack(
                    children: [
                      Positioned(
                        top: 5,
                        left: 140,
                        child: Text("Complaint", style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Positioned(
                        top: 50,
                        left: 10,
                        child: Text("${globalComplainRequestersComplains[globalCurrentComplainIndex]}", style: TextStyle(
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
                  child: Column(
                    children: [
                      Text("Reply", style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                      ),),
                      TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          labelText: "Message",
                        ),
                      ),
                      SizedBox(height: 30,),
                      FutureBuilder(
                          future: usersSignedUp(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              if(snapshot.hasError){
                                return const Text("There is an error");
                              }
                              else if(snapshot.hasData) {
                                return Container(
                                  width: 150,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      //globalCurrentComplainIndex
                                      await dataBaseService.updateUserComplains(
                                        globalCurrentComplainIndex,
                                        signInAsBroker?currentBrokerCompany:currentInsuranceCompany,
                                        messageController.text,
                                        'Complaint',
                                        globalComplainUserIdxs[globalCurrentComplainIndex],
                                        snapshot.data['${globalComplainUserIdxs[globalCurrentComplainIndex]}']['notification-amount']+1,
                                      );

                                      Navigator.pushNamed(context, '/home');

                                    },
                                    child: Text("Send Message", style: TextStyle(
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
