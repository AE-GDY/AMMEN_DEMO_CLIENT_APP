import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newest_insurance/constants.dart';


class UserManagement extends StatefulWidget {
  const UserManagement({Key? key}) : super(key: key);

  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {

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

  Future<Map<String, dynamic>?> insuranceCompaniesSignedUp() async {
    return (await FirebaseFirestore.instance.collection('insurance-companies').
    doc('insurance-company-list').get()).data();
  }

  Future<Map<String, dynamic>?> serviceCentersSignedUp() async {
    return (await FirebaseFirestore.instance.collection('service-centers').
    doc('service-center-list').get()).data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text("User Management"),
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
              Positioned(
                left: 0,
                //right: 0,
                child: Container(
                  width: 210,
                  height: MediaQuery.of(context).size.height + 2000,
                  // color: Colors.grey[100],
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded,
                          size: currentTab=="Dashboard"?32:12,
                          color: currentTab=="Dashboard"?Colors.black:Colors.grey,),
                        title: Text("Dashboard", style: TextStyle(
                            fontSize: currentTab=="Dashboard"?17:12,
                            fontWeight: currentTab=="Dashboard"?FontWeight.bold:FontWeight.normal
                        ),),
                        onTap: (){
                          setState(() {
                            currentTab = "Dashboard";
                            Navigator.pushNamed(context, '/home');
                          });
                        },
                      ),
                      SizedBox(height: 20,),
                      ListTile(
                        leading: Icon(Icons.directions_car,
                          size: currentTab=="Policies"?32:25,
                          color: currentTab=="Policies"?Colors.black:Colors.grey,),
                        title: Text("Policies", style: TextStyle(
                            fontSize: currentTab=="Policies"?17:12,
                            fontWeight: currentTab=="Policies"?FontWeight.bold:FontWeight.normal
                        ),),
                        onTap: (){
                          setState(() {
                            currentTab = "Policies";
                            if(signInAsBroker){
                              Navigator.pushNamed(context, '/broker-page');
                            }
                            else{
                              Navigator.pushNamed(context, '/policies-page');
                            }

                          });
                        },
                      ),
                      claimsTile(signInAsBroker),
                      ListTile(
                        leading: Icon(Icons.live_help,
                          size: currentTab=="Complains"?32:25,
                          color: currentTab=="Complains"?Colors.black:Colors.grey,),
                        title: Text("Complains", style: TextStyle(
                            fontSize: currentTab=="Complains"?17:12,
                            fontWeight: currentTab=="Complains"?FontWeight.bold:FontWeight.normal
                        ),),
                        onTap: (){
                          setState(() {
                            currentTab = "Complains";
                            Navigator.pushNamed(context, '/complains');
                          });
                        },
                      ),
                      userManagementTile(),

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
                        //signInAsBroker?brokerPolicyRequestData():
                        future: policyRequestData(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          print('before');
                          if(snapshot.connectionState == ConnectionState.done){
                            print('in snapshot');
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){


                              print('1');

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
                        future: signInAsBroker?brokerPolicyRequestData():policyRequestData(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){

                              print('2');

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
                        future: signInAsBroker?brokerPolicyRequestData():policyRequestData(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){

                              print('3');

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
                        future: signInAsBroker?brokerClaimRequestData():claimRequestData(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){

                              print('4');

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
                left: 200,
                top: 200,
                child: FutureBuilder(
                  future: signInAsServiceOrWorkshop?serviceCentersSignedUp():insuranceCompaniesSignedUp(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return const Text("There is an error");
                      }
                      else if(snapshot.hasData){
                        return Container(
                          width: 1000,
                          height: 1000,
                          child: Column(
                            children: [

                              Text("Users",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text("Admins",style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),

                              Expanded(
                                child: ListView.builder(
                                    itemCount: snapshot.data['$globalCurrentCompanyIndex']['user-amount'],
                                    itemBuilder: (context,index){
                                      return Container(
                                        child: TextButton(
                                          onPressed: (){},
                                          child: ListTile(
                                            leading: VerticalDivider(width: 1.0,color: Colors.blue,),
                                            title: Text(snapshot.data['$globalCurrentCompanyIndex']['users']['$index']['email'],),
                                            subtitle: Text(snapshot.data['$globalCurrentCompanyIndex']['users']['$index']['role'],),
                                          ),
                                        ),
                                      );
                                    }
                                    )
                              ),


                            ],
                          ),
                        );
                      }
                    }
                    return const Text("Please wait");
                  },

                ),
              ),

              addUser(),


            ],
          ),


        ),
      ),
    );
  }

  Widget claimsTile(bool asBroker){
    if(asBroker){
      return SizedBox(height: 20,);
    }
    else{
      print('claims tile');
      return Column(
        children: [
          SizedBox(height: 20,),
          ListTile(
            leading: Icon(Icons.book,
              size: currentTab == "Claims"?32:25,
              color: currentTab == "Claims"?Colors.black:Colors.grey,
            ),
            title: Text("Claims", style: TextStyle(
              fontSize: currentTab == "Claims"?17:12,
              fontWeight: currentTab == "Claims"?FontWeight.bold:FontWeight.normal,
            ),),
            onTap: (){
              setState(() {

                currentTab = "Claims";
                Navigator.pushNamed(context, '/claims-page');
              });
            },
          ),
          SizedBox(height: 20,),
        ],
      );
    }
  }

  Widget userManagementTile(){
    if(isAdmin){
      return Column(
        children: [
          const SizedBox(height: 20,),
          ListTile(
            leading: Icon(Icons.supervisor_account,
              size: currentTab=="Management"?32:25,
              color: currentTab=="Management"?Colors.black:Colors.grey,),
            title: Text("User Management", style: TextStyle(
                fontSize: currentTab=="Management"?17:12,
                fontWeight: currentTab=="Management"?FontWeight.bold:FontWeight.normal
            ),),
            onTap: (){
              setState(() {
                currentTab = "Management";
                Navigator.pushNamed(context, '/management');
              });
            },
          ),
          const SizedBox(height: 20,),
        ],
      );
    }
    else{
      return const SizedBox(height: 20,);
    }
  }

  Widget addUser(){
    if(isAdmin){
      return Positioned(
        top: 200,
        right: 100,
        child: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: (){
              Navigator.pushNamed(context, '/add-user');
            },
            child: Text("Add User",style: TextStyle(
              color: Colors.white,
            ),),
          ),
        ),
      );
    }
    else{
      return Container();
    }
  }


}
